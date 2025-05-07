type terminalHandler struct {
	appLister         applisters.ApplicationLister
	db                db.ArgoDB
	enf               *rbac.Enforcer
	cache             *servercache.Cache
	appResourceTreeFn func(ctx context.Context, app *appv1.Application) (*appv1.ApplicationTree, error)
	allowedShells     []string
	namespace         string
	enabledNamespaces []string
	sessionManager    *util_session.SessionManager
}



type terminalSession struct {
	wsConn         *websocket.Conn
	sizeChan       chan remotecommand.TerminalSize
	doneChan       chan struct{}
	tty            bool
	readLock       sync.Mutex
	writeLock      sync.Mutex
	sessionManager *util_session.SessionManager
	token          *string
}

// getToken get auth token from web socket request
func getToken(r *http.Request) (string, error) {
	cookies := r.Cookies()
	return httputil.JoinCookies(common.AuthCookieName, cookies)
}







func (a *ArgoCDServer) newHTTPServer(ctx context.Context, port int, grpcWebHandler http.Handler, appResourceTreeFn application.AppResourceTreeFn, conn *grpc.ClientConn) *http.Server {
	endpoint := fmt.Sprintf("localhost:%d", port)
	mux := http.NewServeMux()
	httpS := http.Server{
		Addr: endpoint,
		Handler: &handlerSwitcher{
			handler: mux,
			urlToHandler: map[string]http.Handler{
				"/api/badge":          badge.NewHandler(a.AppClientset, a.settingsMgr, a.Namespace, a.ApplicationNamespaces),
				common.LogoutEndpoint: logout.NewHandler(a.AppClientset, a.settingsMgr, a.sessionMgr, a.ArgoCDServerOpts.RootPath, a.ArgoCDServerOpts.BaseHRef, a.Namespace),
			},
			contentTypeToHandler: map[string]http.Handler{
				"application/grpc-web+proto": grpcWebHandler,
			},
		},
	}

		gwMuxOpts := runtime.WithMarshalerOption(runtime.MIMEWildcard, new(grpc_util.JSONMarshaler))
	gwCookieOpts := runtime.WithForwardResponseOption(a.translateGrpcCookieHeader)
	gwmux := runtime.NewServeMux(gwMuxOpts, gwCookieOpts)

	var handler http.Handler = gwmux
	if a.EnableGZip {
		handler = compressHandler(handler)
	}
	if len(a.ContentTypes) > 0 {
		handler = enforceContentTypes(handler, a.ContentTypes)
	} else {
		log.WithField(common.SecurityField, common.SecurityHigh).Warnf("Content-Type enforcement is disabled, which may make your API vulnerable to CSRF attacks")
	}
	mux.Handle("/api/", handler)

	terminal := application.NewHandler(a.appLister, a.Namespace, a.ApplicationNamespaces, a.db, a.enf, a.Cache, appResourceTreeFn, a.settings.ExecShells, a.sessionMgr).
		WithFeatureFlagMiddleware(a.settingsMgr.GetSettings)
	th := util_session.WithAuthMiddleware(a.DisableAuth, a.sessionMgr, terminal)
	mux.Handle("/terminal", th)

		if a.EnableProxyExtension {
				registerExtensions(mux, a)
	}

	mustRegisterGWHandler(versionpkg.RegisterVersionServiceHandler, ctx, gwmux, conn)
	mustRegisterGWHandler(clusterpkg.RegisterClusterServiceHandler, ctx, gwmux, conn)
	mustRegisterGWHandler(applicationpkg.RegisterApplicationServiceHandler, ctx, gwmux, conn)
	mustRegisterGWHandler(applicationsetpkg.RegisterApplicationSetServiceHandler, ctx, gwmux, conn)
	mustRegisterGWHandler(notificationpkg.RegisterNotificationServiceHandler, ctx, gwmux, conn)
	mustRegisterGWHandler(repositorypkg.RegisterRepositoryServiceHandler, ctx, gwmux, conn)
	mustRegisterGWHandler(repocredspkg.RegisterRepoCredsServiceHandler, ctx, gwmux, conn)
	mustRegisterGWHandler(sessionpkg.RegisterSessionServiceHandler, ctx, gwmux, conn)
	mustRegisterGWHandler(settingspkg.RegisterSettingsServiceHandler, ctx, gwmux, conn)
	mustRegisterGWHandler(projectpkg.RegisterProjectServiceHandler, ctx, gwmux, conn)
	mustRegisterGWHandler(accountpkg.RegisterAccountServiceHandler, ctx, gwmux, conn)
	mustRegisterGWHandler(certificatepkg.RegisterCertificateServiceHandler, ctx, gwmux, conn)
	mustRegisterGWHandler(gpgkeypkg.RegisterGPGKeyServiceHandler, ctx, gwmux, conn)

		swagger.ServeSwaggerUI(mux, assets.SwaggerJSON, "/swagger-ui", a.RootPath)
	healthz.ServeHealthCheck(mux, a.healthCheck)

		a.registerDexHandlers(mux)

		argoDB := db.NewDB(a.Namespace, a.settingsMgr, a.KubeClientset)
	acdWebhookHandler := webhook.NewHandler(a.Namespace, a.ArgoCDServerOpts.ApplicationNamespaces, a.AppClientset, a.settings, a.settingsMgr, repocache.NewCache(a.Cache.GetCache(), 24*time.Hour, 3*time.Minute), a.Cache, argoDB)

	mux.HandleFunc("/api/webhook", acdWebhookHandler.Handler)

		registerDownloadHandlers(mux, "/download")

		var extensionsSharedPath = "/tmp/extensions/"

	var extensionsHandler http.Handler = http.HandlerFunc(func(writer http.ResponseWriter, _ *http.Request) {
		a.serveExtensions(extensionsSharedPath, writer)
	})
	if a.ArgoCDServerOpts.EnableGZip {
		extensionsHandler = compressHandler(extensionsHandler)
	}
	mux.Handle("/extensions.js", extensionsHandler)

		var assetsHandler http.Handler = http.HandlerFunc(a.newStaticAssetsHandler())
	if a.ArgoCDServerOpts.EnableGZip {
		assetsHandler = compressHandler(assetsHandler)
	}
	mux.Handle("/", assetsHandler)
	return &httpS
}
