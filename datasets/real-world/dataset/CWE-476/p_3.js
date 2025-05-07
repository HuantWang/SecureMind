class WebSocketServer extends EventEmitter {
  constructor(options, callback) {
    super();

    options = {
      allowSynchronousEvents: true,
      autoPong: true,
      maxPayload: 100 * 1024 * 1024,
      skipUTF8Validation: false,
      perMessageDeflate: false,
      handleProtocols: null,
      clientTracking: true,
      verifyClient: null,
      noServer: false,
      backlog: null, 
      server: null,
      host: null,
      path: null,
      port: null,
      WebSocket,
      ...options
    };

    if (
      (options.port == null && !options.server && !options.noServer) ||
      (options.port != null && (options.server || options.noServer)) ||
      (options.server && options.noServer)
    ) {
      throw new TypeError(
        'One and only one of the "port", "server", or "noServer" options ' +
          'must be specified'
      );
    }

    if (options.port != null) {
      this._server = http.createServer((req, res) => {
        const body = http.STATUS_CODES[426];

        res.writeHead(426, {
          'Content-Length': body.length,
          'Content-Type': 'text/plain'
        });
        res.end(body);
      });
      this._server.listen(
        options.port,
        options.host,
        options.backlog,
        callback
      );
    } else if (options.server) {
      this._server = options.server;
    }

    if (this._server) {
      const emitConnection = this.emit.bind(this, 'connection');

      this._removeListeners = addListeners(this._server, {
        listening: this.emit.bind(this, 'listening'),
        error: this.emit.bind(this, 'error'),
        upgrade: (req, socket, head) => {
          this.handleUpgrade(req, socket, head, emitConnection);
        }
      });
    }

    if (options.perMessageDeflate === true) options.perMessageDeflate = {};
    if (options.clientTracking) {
      this.clients = new Set();
      this._shouldEmitClose = false;
    }

    this.options = options;
    this._state = RUNNING;
  }

    address() {
    if (this.options.noServer) {
      throw new Error('The server is operating in "noServer" mode');
    }

    if (!this._server) return null;
    return this._server.address();
  }

    close(cb) {
    if (this._state === CLOSED) {
      if (cb) {
        this.once('close', () => {
          cb(new Error('The server is not running'));
        });
      }

      process.nextTick(emitClose, this);
      return;
    }

    if (cb) this.once('close', cb);

    if (this._state === CLOSING) return;
    this._state = CLOSING;

    if (this.options.noServer || this.options.server) {
      if (this._server) {
        this._removeListeners();
        this._removeListeners = this._server = null;
      }

      if (this.clients) {
        if (!this.clients.size) {
          process.nextTick(emitClose, this);
        } else {
          this._shouldEmitClose = true;
        }
      } else {
        process.nextTick(emitClose, this);
      }
    } else {
      const server = this._server;

      this._removeListeners();
      this._removeListeners = this._server = null;

            server.close(() => {
        emitClose(this);
      });
    }
  }

   shouldHandle(req) {
    if (this.options.path) {
      const index = req.url.indexOf('?');
      const pathname = index !== -1 ? req.url.slice(0, index) : req.url;

      if (pathname !== this.options.path) return false;
    }

    return true;
  }

   handleUpgrade(req, socket, head, cb) {
    socket.on('error', socketOnError);

    const key = req.headers['sec-websocket-key'];
    const upgrade = req.headers.upgrade;
    const version = +req.headers['sec-websocket-version'];

    if (req.method !== 'GET') {
      const message = 'Invalid HTTP method';
      abortHandshakeOrEmitwsClientError(this, req, socket, 405, message);
      return;
    }

    if (upgrade === undefined || upgrade.toLowerCase() !== 'websocket') {
      const message = 'Invalid Upgrade header';
      abortHandshakeOrEmitwsClientError(this, req, socket, 400, message);
      return;
    }

    if (key === undefined || !keyRegex.test(key)) {
      const message = 'Missing or invalid Sec-WebSocket-Key header';
      abortHandshakeOrEmitwsClientError(this, req, socket, 400, message);
      return;
    }

    if (version !== 8 && version !== 13) {
      const message = 'Missing or invalid Sec-WebSocket-Version header';
      abortHandshakeOrEmitwsClientError(this, req, socket, 400, message);
      return;
    }

    if (!this.shouldHandle(req)) {
      abortHandshake(socket, 400);
      return;
    }

    const secWebSocketProtocol = req.headers['sec-websocket-protocol'];
    let protocols = new Set();

    if (secWebSocketProtocol !== undefined) {
      try {
        protocols = subprotocol.parse(secWebSocketProtocol);
      } catch (err) {
        const message = 'Invalid Sec-WebSocket-Protocol header';
        abortHandshakeOrEmitwsClientError(this, req, socket, 400, message);
        return;
      }
    }

    const secWebSocketExtensions = req.headers['sec-websocket-extensions'];
    const extensions = {};

    if (
      this.options.perMessageDeflate &&
      secWebSocketExtensions !== undefined
    ) {
      const perMessageDeflate = new PerMessageDeflate(
        this.options.perMessageDeflate,
        true,
        this.options.maxPayload
      );

      try {
        const offers = extension.parse(secWebSocketExtensions);

        if (offers[PerMessageDeflate.extensionName]) {
          perMessageDeflate.accept(offers[PerMessageDeflate.extensionName]);
          extensions[PerMessageDeflate.extensionName] = perMessageDeflate;
        }
      } catch (err) {
        const message =
          'Invalid or unacceptable Sec-WebSocket-Extensions header';
        abortHandshakeOrEmitwsClientError(this, req, socket, 400, message);
        return;
      }
    }

       if (this.options.verifyClient) {
      const info = {
        origin:
          req.headers[`${version === 8 ? 'sec-websocket-origin' : 'origin'}`],
        secure: !!(req.socket.authorized || req.socket.encrypted),
        req
      };

      if (this.options.verifyClient.length === 2) {
        this.options.verifyClient(info, (verified, code, message, headers) => {
          if (!verified) {
            return abortHandshake(socket, code || 401, message, headers);
          }

          this.completeUpgrade(
            extensions,
            key,
            protocols,
            req,
            socket,
            head,
            cb
          );
        });
        return;
      }

      if (!this.options.verifyClient(info)) return abortHandshake(socket, 401);
    }

    this.completeUpgrade(extensions, key, protocols, req, socket, head, cb);
  }

  completeUpgrade(extensions, key, protocols, req, socket, head, cb) {
      if (!socket.readable || !socket.writable) return socket.destroy();

    if (socket[kWebSocket]) {
      throw new Error(
        'server.handleUpgrade() was called more than once with the same ' +
          'socket, possibly due to a misconfiguration'
      );
    }

    if (this._state > RUNNING) return abortHandshake(socket, 503);

    const digest = createHash('sha1')
      .update(key + GUID)
      .digest('base64');

    const headers = [
      'HTTP/1.1 101 Switching Protocols',
      'Upgrade: websocket',
      'Connection: Upgrade',
      `Sec-WebSocket-Accept: ${digest}`
    ];

    const ws = new this.options.WebSocket(null, undefined, this.options);

    if (protocols.size) {
           const protocol = this.options.handleProtocols
        ? this.options.handleProtocols(protocols, req)
        : protocols.values().next().value;

      if (protocol) {
        headers.push(`Sec-WebSocket-Protocol: ${protocol}`);
        ws._protocol = protocol;
      }
    }

    if (extensions[PerMessageDeflate.extensionName]) {
      const params = extensions[PerMessageDeflate.extensionName].params;
      const value = extension.format({
        [PerMessageDeflate.extensionName]: [params]
      });
      headers.push(`Sec-WebSocket-Extensions: ${value}`);
      ws._extensions = extensions;
    }

       this.emit('headers', headers, req);

    socket.write(headers.concat('\r\n').join('\r\n'));
    socket.removeListener('error', socketOnError);

    ws.setSocket(socket, head, {
      allowSynchronousEvents: this.options.allowSynchronousEvents,
      maxPayload: this.options.maxPayload,
      skipUTF8Validation: this.options.skipUTF8Validation
    });

    if (this.clients) {
      this.clients.add(ws);
      ws.on('close', () => {
        this.clients.delete(ws);

        if (this._shouldEmitClose && !this.clients.size) {
          process.nextTick(emitClose, this);
        }
      });
    }

    cb(ws, req);
  }
}





function initAsClient(websocket, address, protocols, options) {
  const opts = {
    allowSynchronousEvents: true,
    autoPong: true,
    protocolVersion: protocolVersions[1],
    maxPayload: 100 * 1024 * 1024,
    skipUTF8Validation: false,
    perMessageDeflate: true,
    followRedirects: false,
    maxRedirects: 10,
    ...options,
    socketPath: undefined,
    hostname: undefined,
    protocol: undefined,
    timeout: undefined,
    method: 'GET',
    host: undefined,
    path: undefined,
    port: undefined
  };

  websocket._autoPong = opts.autoPong;

  if (!protocolVersions.includes(opts.protocolVersion)) {
    throw new RangeError(
      `Unsupported protocol version: ${opts.protocolVersion} ` +
        `(supported versions: ${protocolVersions.join(', ')})`
    );
  }

  let parsedUrl;

  if (address instanceof URL) {
    parsedUrl = address;
  } else {
    try {
      parsedUrl = new URL(address);
    } catch (e) {
      throw new SyntaxError(`Invalid URL: ${address}`);
    }
  }

  if (parsedUrl.protocol === 'http:') {
    parsedUrl.protocol = 'ws:';
  } else if (parsedUrl.protocol === 'https:') {
    parsedUrl.protocol = 'wss:';
  }

  websocket._url = parsedUrl.href;

  const isSecure = parsedUrl.protocol === 'wss:';
  const isIpcUrl = parsedUrl.protocol === 'ws+unix:';
  let invalidUrlMessage;

  if (parsedUrl.protocol !== 'ws:' && !isSecure && !isIpcUrl) {
    invalidUrlMessage =
      'The URL\'s protocol must be one of "ws:", "wss:", ' +
      '"http:", "https", or "ws+unix:"';
  } else if (isIpcUrl && !parsedUrl.pathname) {
    invalidUrlMessage = "The URL's pathname is empty";
  } else if (parsedUrl.hash) {
    invalidUrlMessage = 'The URL contains a fragment identifier';
  }

  if (invalidUrlMessage) {
    const err = new SyntaxError(invalidUrlMessage);

    if (websocket._redirects === 0) {
      throw err;
    } else {
      emitErrorAndClose(websocket, err);
      return;
    }
  }

  const defaultPort = isSecure ? 443 : 80;
  const key = randomBytes(16).toString('base64');
  const request = isSecure ? https.request : http.request;
  const protocolSet = new Set();
  let perMessageDeflate;

  opts.createConnection =
    opts.createConnection || (isSecure ? tlsConnect : netConnect);
  opts.defaultPort = opts.defaultPort || defaultPort;
  opts.port = parsedUrl.port || defaultPort;
  opts.host = parsedUrl.hostname.startsWith('[')
    ? parsedUrl.hostname.slice(1, -1)
    : parsedUrl.hostname;
  opts.headers = {
    ...opts.headers,
    'Sec-WebSocket-Version': opts.protocolVersion,
    'Sec-WebSocket-Key': key,
    Connection: 'Upgrade',
    Upgrade: 'websocket'
  };
  opts.path = parsedUrl.pathname + parsedUrl.search;
  opts.timeout = opts.handshakeTimeout;

  if (opts.perMessageDeflate) {
    perMessageDeflate = new PerMessageDeflate(
      opts.perMessageDeflate !== true ? opts.perMessageDeflate : {},
      false,
      opts.maxPayload
    );
    opts.headers['Sec-WebSocket-Extensions'] = format({
      [PerMessageDeflate.extensionName]: perMessageDeflate.offer()
    });
  }
  if (protocols.length) {
    for (const protocol of protocols) {
      if (
        typeof protocol !== 'string' ||
        !subprotocolRegex.test(protocol) ||
        protocolSet.has(protocol)
      ) {
        throw new SyntaxError(
          'An invalid or duplicated subprotocol was specified'
        );
      }

      protocolSet.add(protocol);
    }

    opts.headers['Sec-WebSocket-Protocol'] = protocols.join(',');
  }
  if (opts.origin) {
    if (opts.protocolVersion < 13) {
      opts.headers['Sec-WebSocket-Origin'] = opts.origin;
    } else {
      opts.headers.Origin = opts.origin;
    }
  }
  if (parsedUrl.username || parsedUrl.password) {
    opts.auth = `${parsedUrl.username}:${parsedUrl.password}`;
  }

  if (isIpcUrl) {
    const parts = opts.path.split(':');

    opts.socketPath = parts[0];
    opts.path = parts[1];
  }

  let req;

  if (opts.followRedirects) {
    if (websocket._redirects === 0) {
      websocket._originalIpc = isIpcUrl;
      websocket._originalSecure = isSecure;
      websocket._originalHostOrSocketPath = isIpcUrl
        ? opts.socketPath
        : parsedUrl.host;

      const headers = options && options.headers;

           options = { ...options, headers: {} };

      if (headers) {
        for (const [key, value] of Object.entries(headers)) {
          options.headers[key.toLowerCase()] = value;
        }
      }
    } else if (websocket.listenerCount('redirect') === 0) {
      const isSameHost = isIpcUrl
        ? websocket._originalIpc
          ? opts.socketPath === websocket._originalHostOrSocketPath
          : false
        : websocket._originalIpc
          ? false
          : parsedUrl.host === websocket._originalHostOrSocketPath;

      if (!isSameHost || (websocket._originalSecure && !isSecure)) {
               delete opts.headers.authorization;
        delete opts.headers.cookie;

        if (!isSameHost) delete opts.headers.host;

        opts.auth = undefined;
      }
    }

        if (opts.auth && !options.headers.authorization) {
      options.headers.authorization =
        'Basic ' + Buffer.from(opts.auth).toString('base64');
    }

    req = websocket._req = request(opts);

    if (websocket._redirects) {
          websocket.emit('redirect', websocket.url, req);
    }
  } else {
    req = websocket._req = request(opts);
  }

  if (opts.timeout) {
    req.on('timeout', () => {
      abortHandshake(websocket, req, 'Opening handshake has timed out');
    });
  }

  req.on('error', (err) => {
    if (req === null || req[kAborted]) return;

    req = websocket._req = null;
    emitErrorAndClose(websocket, err);
  });

  req.on('response', (res) => {
    const location = res.headers.location;
    const statusCode = res.statusCode;

    if (
      location &&
      opts.followRedirects &&
      statusCode >= 300 &&
      statusCode < 400
    ) {
      if (++websocket._redirects > opts.maxRedirects) {
        abortHandshake(websocket, req, 'Maximum redirects exceeded');
        return;
      }

      req.abort();

      let addr;

      try {
        addr = new URL(location, address);
      } catch (e) {
        const err = new SyntaxError(`Invalid URL: ${location}`);
        emitErrorAndClose(websocket, err);
        return;
      }

      initAsClient(websocket, addr, protocols, options);
    } else if (!websocket.emit('unexpected-response', req, res)) {
      abortHandshake(
        websocket,
        req,
        `Unexpected server response: ${res.statusCode}`
      );
    }
  });

  req.on('upgrade', (res, socket, head) => {
    websocket.emit('upgrade', res);

       if (websocket.readyState !== WebSocket.CONNECTING) return;

    req = websocket._req = null;

    const upgrade = res.headers.upgrade;

    if (upgrade === undefined || upgrade.toLowerCase() !== 'websocket') {
      abortHandshake(websocket, socket, 'Invalid Upgrade header');
      return;
    }

    const digest = createHash('sha1')
      .update(key + GUID)
      .digest('base64');

    if (res.headers['sec-websocket-accept'] !== digest) {
      abortHandshake(websocket, socket, 'Invalid Sec-WebSocket-Accept header');
      return;
    }

    const serverProt = res.headers['sec-websocket-protocol'];
    let protError;

    if (serverProt !== undefined) {
      if (!protocolSet.size) {
        protError = 'Server sent a subprotocol but none was requested';
      } else if (!protocolSet.has(serverProt)) {
        protError = 'Server sent an invalid subprotocol';
      }
    } else if (protocolSet.size) {
      protError = 'Server sent no subprotocol';
    }

    if (protError) {
      abortHandshake(websocket, socket, protError);
      return;
    }

    if (serverProt) websocket._protocol = serverProt;

    const secWebSocketExtensions = res.headers['sec-websocket-extensions'];

    if (secWebSocketExtensions !== undefined) {
      if (!perMessageDeflate) {
        const message =
          'Server sent a Sec-WebSocket-Extensions header but no extension ' +
          'was requested';
        abortHandshake(websocket, socket, message);
        return;
      }

      let extensions;

      try {
        extensions = parse(secWebSocketExtensions);
      } catch (err) {
        const message = 'Invalid Sec-WebSocket-Extensions header';
        abortHandshake(websocket, socket, message);
        return;
      }

      const extensionNames = Object.keys(extensions);

      if (
        extensionNames.length !== 1 ||
        extensionNames[0] !== PerMessageDeflate.extensionName
      ) {
        const message = 'Server indicated an extension that was not requested';
        abortHandshake(websocket, socket, message);
        return;
      }

      try {
        perMessageDeflate.accept(extensions[PerMessageDeflate.extensionName]);
      } catch (err) {
        const message = 'Invalid Sec-WebSocket-Extensions header';
        abortHandshake(websocket, socket, message);
        return;
      }

      websocket._extensions[PerMessageDeflate.extensionName] =
        perMessageDeflate;
    }

    websocket.setSocket(socket, head, {
      allowSynchronousEvents: opts.allowSynchronousEvents,
      generateMask: opts.generateMask,
      maxPayload: opts.maxPayload,
      skipUTF8Validation: opts.skipUTF8Validation
    });
  });

  if (opts.finishRequest) {
    opts.finishRequest(req, websocket);
  } else {
    req.end();
  }
}



describe('WebSocketServer', () => {
  describe('#ctor', () => {
    it('throws an error if no option object is passed', () => {
      assert.throws(
        () => new WebSocket.Server(),
        new RegExp(
          '^TypeError: One and only one of the "port", "server", or ' +
            '"noServer" options must be specified$'
        )
      );
    });

    describe('options', () => {
      it('throws an error if required options are not specified', () => {
        assert.throws(
          () => new WebSocket.Server({}),
          new RegExp(
            '^TypeError: One and only one of the "port", "server", or ' +
              '"noServer" options must be specified$'
          )
        );
      });

      it('throws an error if mutually exclusive options are specified', () => {
        const server = http.createServer();
        const variants = [
          { port: 0, noServer: true, server },
          { port: 0, noServer: true },
          { port: 0, server },
          { noServer: true, server }
        ];

        for (const options of variants) {
          assert.throws(
            () => new WebSocket.Server(options),
            new RegExp(
              '^TypeError: One and only one of the "port", "server", or ' +
                '"noServer" options must be specified$'
            )
          );
        }
      });

      it('exposes options passed to constructor', (done) => {
        const wss = new WebSocket.Server({ port: 0 }, () => {
          assert.strictEqual(wss.options.port, 0);
          wss.close(done);
        });
      });

      it('accepts the `maxPayload` option', (done) => {
        const maxPayload = 20480;
        const wss = new WebSocket.Server(
          {
            perMessageDeflate: true,
            maxPayload,
            port: 0
          },
          () => {
            const ws = new WebSocket(`ws://localhost:${wss.address().port}`);

            ws.on('open', ws.close);
          }
        );

        wss.on('connection', (ws) => {
          assert.strictEqual(ws._receiver._maxPayload, maxPayload);
          assert.strictEqual(
            ws._receiver._extensions['permessage-deflate']._maxPayload,
            maxPayload
          );
          wss.close(done);
        });
      });

      it('honors the `WebSocket` option', (done) => {
        class CustomWebSocket extends WebSocket.WebSocket {
          get foo() {
            return 'foo';
          }
        }

        const wss = new WebSocket.Server(
          {
            port: 0,
            WebSocket: CustomWebSocket
          },
          () => {
            const ws = new WebSocket(`ws://localhost:${wss.address().port}`);

            ws.on('open', ws.close);
          }
        );

        wss.on('connection', (ws) => {
          assert.ok(ws instanceof CustomWebSocket);
          assert.strictEqual(ws.foo, 'foo');
          wss.close(done);
        });
      });

      it('honors the `autoPong` option', (done) => {
        const wss = new WebSocket.Server({ autoPong: false, port: 0 }, () => {
          const ws = new WebSocket(`ws://localhost:${wss.address().port}`);

          ws.on('open', () => {
            ws.ping();
          });

          ws.on('pong', () => {
            done(new Error("Unexpected 'pong' event"));
          });
        });

        wss.on('connection', (ws) => {
          ws.on('ping', () => {
            ws.close();
          });

          ws.on('close', () => {
            wss.close(done);
          });
        });
      });
    });

    it('emits an error if http server bind fails', (done) => {
      const wss1 = new WebSocket.Server({ port: 0 }, () => {
        const wss2 = new WebSocket.Server({
          port: wss1.address().port
        });

        wss2.on('error', () => wss1.close(done));
      });
    });

    it('starts a server on a given port', (done) => {
      const port = 1337;
      const wss = new WebSocket.Server({ port }, () => {
        const ws = new WebSocket(`ws://localhost:${port}`);

        ws.on('open', ws.close);
      });

      wss.on('connection', () => wss.close(done));
    });

    it('binds the server on any IPv6 address when available', (done) => {
      const wss = new WebSocket.Server({ port: 0 }, () => {
        assert.strictEqual(wss._server.address().address, '::');
        wss.close(done);
      });
    });

    it('uses a precreated http server', (done) => {
      const server = http.createServer();

      server.listen(0, () => {
        const wss = new WebSocket.Server({ server });

        wss.on('connection', () => {
          server.close(done);
        });

        const ws = new WebSocket(`ws://localhost:${server.address().port}`);

        ws.on('open', ws.close);
      });
    });

    it('426s for non-Upgrade requests', (done) => {
      const wss = new WebSocket.Server({ port: 0 }, () => {
        http.get(`http://localhost:${wss.address().port}`, (res) => {
          let body = '';

          assert.strictEqual(res.statusCode, 426);
          res.on('data', (chunk) => {
            body += chunk;
          });
          res.on('end', () => {
            assert.strictEqual(body, http.STATUS_CODES[426]);
            wss.close(done);
          });
        });
      });
    });

    it('uses a precreated http server listening on IPC', (done) => {
      const randomString = crypto.randomBytes(16).toString('hex');
      const ipcPath =
        process.platform === 'win32'
          ? `\\\\.\\pipe\\ws-pipe-${randomString}`
          : path.join(os.tmpdir(), `ws-${randomString}.sock`);

      const server = http.createServer();

      server.listen(ipcPath, () => {
        const wss = new WebSocket.Server({ server });

        wss.on('connection', (ws, req) => {
          if (wss.clients.size === 1) {
            assert.strictEqual(req.url, '/foo?bar=bar');
          } else {
            assert.strictEqual(req.url, '/');

            for (const client of wss.clients) {
              client.close();
            }

            server.close(done);
          }
        });

        const ws = new WebSocket(`ws+unix:${ipcPath}:/foo?bar=bar`);
        ws.on('open', () => new WebSocket(`ws+unix:${ipcPath}`));
      });
    });
  });

  describe('#address', () => {
    it('returns the address of the server', (done) => {
      const wss = new WebSocket.Server({ port: 0 }, () => {
        const addr = wss.address();

        assert.deepStrictEqual(addr, wss._server.address());
        wss.close(done);
      });
    });

    it('throws an error when operating in "noServer" mode', () => {
      const wss = new WebSocket.Server({ noServer: true });

      assert.throws(() => {
        wss.address();
      }, /^Error: The server is operating in "noServer" mode$/);
    });

    it('returns `null` if called after close', (done) => {
      const wss = new WebSocket.Server({ port: 0 }, () => {
        wss.close(() => {
          assert.strictEqual(wss.address(), null);
          done();
        });
      });
    });
  });

  describe('#close', () => {
    it('does not throw if called multiple times', (done) => {
      const wss = new WebSocket.Server({ port: 0 }, () => {
        wss.on('close', done);

        wss.close();
        wss.close();
        wss.close();
      });
    });

    it("doesn't close a precreated server", (done) => {
      const server = http.createServer();
      const realClose = server.close;

      server.close = () => {
        done(new Error('Must not close pre-created server'));
      };

      const wss = new WebSocket.Server({ server });

      wss.on('connection', () => {
        wss.close();
        server.close = realClose;
        server.close(done);
      });

      server.listen(0, () => {
        const ws = new WebSocket(`ws://localhost:${server.address().port}`);

        ws.on('open', ws.close);
      });
    });

    it('invokes the callback in noServer mode', (done) => {
      const wss = new WebSocket.Server({ noServer: true });

      wss.close(done);
    });

    it('cleans event handlers on precreated server', (done) => {
      const server = http.createServer();
      const listeningListenerCount = server.listenerCount('listening');
      const wss = new WebSocket.Server({ server });

      server.listen(0, () => {
        wss.close(() => {
          assert.strictEqual(
            server.listenerCount('listening'),
            listeningListenerCount
          );
          assert.strictEqual(server.listenerCount('upgrade'), 0);
          assert.strictEqual(server.listenerCount('error'), 0);

          server.close(done);
        });
      });
    });

    it("emits the 'close' event after the server closes", (done) => {
      let serverCloseEventEmitted = false;

      const wss = new WebSocket.Server({ port: 0 }, () => {
        net.createConnection({ port: wss.address().port });
      });

      wss._server.on('connection', (socket) => {
        wss.close();

            wss.close();

        process.nextTick(() => {
          socket.end();
        });
      });

      wss._server.on('close', () => {
        serverCloseEventEmitted = true;
      });

      wss.on('close', () => {
        assert.ok(serverCloseEventEmitted);
        done();
      });
    });

    it("emits the 'close' event if client tracking is disabled", (done) => {
      const wss = new WebSocket.Server({
        noServer: true,
        clientTracking: false
      });

      wss.on('close', done);
      wss.close();
    });

    it('calls the callback if the server is already closed', (done) => {
      const wss = new WebSocket.Server({ port: 0 }, () => {
        wss.close(() => {
          assert.strictEqual(wss._state, 2);

          wss.close((err) => {
            assert.ok(err instanceof Error);
            assert.strictEqual(err.message, 'The server is not running');
            done();
          });
        });
      });
    });

    it("emits the 'close' event if the server is already closed", (done) => {
      const wss = new WebSocket.Server({ port: 0 }, () => {
        wss.close(() => {
          assert.strictEqual(wss._state, 2);

          wss.on('close', done);
          wss.close();
        });
      });
    });
  });

  describe('#clients', () => {
    it('returns a list of connected clients', (done) => {
      const wss = new WebSocket.Server({ port: 0 }, () => {
        assert.strictEqual(wss.clients.size, 0);

        const ws = new WebSocket(`ws://localhost:${wss.address().port}`);

        ws.on('open', ws.close);
      });

      wss.on('connection', () => {
        assert.strictEqual(wss.clients.size, 1);
        wss.close(done);
      });
    });

    it('can be disabled', (done) => {
      const wss = new WebSocket.Server(
        { port: 0, clientTracking: false },
        () => {
          assert.strictEqual(wss.clients, undefined);
          const ws = new WebSocket(`ws://localhost:${wss.address().port}`);

          ws.on('open', () => ws.close());
        }
      );

      wss.on('connection', (ws) => {
        assert.strictEqual(wss.clients, undefined);
        ws.on('close', () => wss.close(done));
      });
    });

    it('is updated when client terminates the connection', (done) => {
      const wss = new WebSocket.Server({ port: 0 }, () => {
        const ws = new WebSocket(`ws://localhost:${wss.address().port}`);

        ws.on('open', () => ws.terminate());
      });

      wss.on('connection', (ws) => {
        ws.on('close', () => {
          assert.strictEqual(wss.clients.size, 0);
          wss.close(done);
        });
      });
    });

    it('is updated when client closes the connection', (done) => {
      const wss = new WebSocket.Server({ port: 0 }, () => {
        const ws = new WebSocket(`ws://localhost:${wss.address().port}`);

        ws.on('open', () => ws.close());
      });

      wss.on('connection', (ws) => {
        ws.on('close', () => {
          assert.strictEqual(wss.clients.size, 0);
          wss.close(done);
        });
      });
    });
  });

  describe('#shouldHandle', () => {
    it('returns true when the path matches', () => {
      const wss = new WebSocket.Server({ noServer: true, path: '/foo' });

      assert.strictEqual(wss.shouldHandle({ url: '/foo' }), true);
      assert.strictEqual(wss.shouldHandle({ url: '/foo?bar=baz' }), true);
    });

    it("returns false when the path doesn't match", () => {
      const wss = new WebSocket.Server({ noServer: true, path: '/foo' });

      assert.strictEqual(wss.shouldHandle({ url: '/bar' }), false);
    });
  });

  describe('#handleUpgrade', () => {
    it('can be used for a pre-existing server', (done) => {
      const server = http.createServer();

      server.listen(0, () => {
        const wss = new WebSocket.Server({ noServer: true });

        server.on('upgrade', (req, socket, head) => {
          wss.handleUpgrade(req, socket, head, (ws) => {
            ws.send('hello');
            ws.close();
          });
        });

        const ws = new WebSocket(`ws://localhost:${server.address().port}`);

        ws.on('message', (message, isBinary) => {
          assert.deepStrictEqual(message, Buffer.from('hello'));
          assert.ok(!isBinary);
          server.close(done);
        });
      });
    });

    it("closes the connection when path doesn't match", (done) => {
      const wss = new WebSocket.Server({ port: 0, path: '/ws' }, () => {
        const req = http.get({
          port: wss.address().port,
          headers: {
            Connection: 'Upgrade',
            Upgrade: 'websocket',
            'Sec-WebSocket-Key': 'dGhlIHNhbXBsZSBub25jZQ==',
            'Sec-WebSocket-Version': 13
          }
        });

        req.on('response', (res) => {
          assert.strictEqual(res.statusCode, 400);
          wss.close(done);
        });
      });
    });

    it('closes the connection when protocol version is Hixie-76', (done) => {
      const wss = new WebSocket.Server({ port: 0 }, () => {
        const req = http.get({
          port: wss.address().port,
          headers: {
            Connection: 'Upgrade',
            Upgrade: 'WebSocket',
            'Sec-WebSocket-Key1': '4 @1  46546xW%0l 1 5',
            'Sec-WebSocket-Key2': '12998 5 Y3 1  .P00',
            'Sec-WebSocket-Protocol': 'sample'
          }
        });

        req.on('response', (res) => {
          assert.strictEqual(res.statusCode, 400);

          const chunks = [];

          res.on('data', (chunk) => {
            chunks.push(chunk);
          });

          res.on('end', () => {
            assert.strictEqual(
              Buffer.concat(chunks).toString(),
              'Missing or invalid Sec-WebSocket-Key header'
            );
            wss.close(done);
          });
        });
      });
    });

    it('completes a WebSocket upgrade over any duplex stream', (done) => {
      const server = http.createServer();

      server.listen(0, () => {
        const wss = new WebSocket.Server({ noServer: true });

        server.on('upgrade', (req, socket, head) => {
                 const { clientSide, serverSide } = makeDuplexPair();

          socket.pipe(clientSide);
          clientSide.pipe(socket);

                  wss.handleUpgrade(req, serverSide, head, (ws) => {
            ws.send('hello');
            ws.close();
          });
        });

        const ws = new WebSocket(`ws://localhost:${server.address().port}`);

        ws.on('message', (message, isBinary) => {
          assert.deepStrictEqual(message, Buffer.from('hello'));
          assert.ok(!isBinary);
          server.close(done);
        });
      });
    });
  });

  describe('#completeUpgrade', () => {
    it('throws an error if called twice with the same socket', (done) => {
      const server = http.createServer();

      server.listen(0, () => {
        const wss = new WebSocket.Server({ noServer: true });

        server.on('upgrade', (req, socket, head) => {
          wss.handleUpgrade(req, socket, head, (ws) => {
            ws.close();
          });
          assert.throws(
            () => wss.handleUpgrade(req, socket, head, NOOP),
            (err) => {
              assert.ok(err instanceof Error);
              assert.strictEqual(
                err.message,
                'server.handleUpgrade() was called more than once with the ' +
                  'same socket, possibly due to a misconfiguration'
              );
              return true;
            }
          );
        });

        const ws = new WebSocket(`ws://localhost:${server.address().port}`);

        ws.on('open', () => {
          ws.on('close', () => {
            server.close(done);
          });
        });
      });
    });
  });

  describe('Connection establishing', () => {
    it('fails if the HTTP method is not GET', (done) => {
      const wss = new WebSocket.Server({ port: 0 }, () => {
        const req = http.request({
          method: 'POST',
          port: wss.address().port,
          headers: {
            Connection: 'Upgrade',
            Upgrade: 'websocket'
          }
        });

        req.on('response', (res) => {
          assert.strictEqual(res.statusCode, 405);

          const chunks = [];

          res.on('data', (chunk) => {
            chunks.push(chunk);
          });

          res.on('end', () => {
            assert.strictEqual(
              Buffer.concat(chunks).toString(),
              'Invalid HTTP method'
            );
            wss.close(done);
          });
        });

        req.end();
      });

      wss.on('connection', () => {
        done(new Error("Unexpected 'connection' event"));
      });
    });

    it('fails if the Upgrade header field value cannot be read', (done) => {
      const server = http.createServer();
      const wss = new WebSocket.Server({ noServer: true });

      server.maxHeadersCount = 1;

      server.on('upgrade', (req, socket, head) => {
        assert.deepStrictEqual(req.headers, { foo: 'bar' });
        wss.handleUpgrade(req, socket, head, () => {
          done(new Error('Unexpected callback invocation'));
        });
      });

      server.listen(() => {
        const req = http.get({
          port: server.address().port,
          headers: {
            foo: 'bar',
            bar: 'baz',
            Connection: 'Upgrade',
            Upgrade: 'websocket'
          }
        });

        req.on('response', (res) => {
          assert.strictEqual(res.statusCode, 400);

          const chunks = [];

          res.on('data', (chunk) => {
            chunks.push(chunk);
          });

          res.on('end', () => {
            assert.strictEqual(
              Buffer.concat(chunks).toString(),
              'Invalid Upgrade header'
            );
            server.close(done);
          });
        });
      });
    });

    it('fails if the Upgrade header field value is not "websocket"', (done) => {
      const wss = new WebSocket.Server({ port: 0 }, () => {
        const req = http.get({
          port: wss.address().port,
          headers: {
            Connection: 'Upgrade',
            Upgrade: 'foo'
          }
        });

        req.on('response', (res) => {
          assert.strictEqual(res.statusCode, 400);

          const chunks = [];

          res.on('data', (chunk) => {
            chunks.push(chunk);
          });

          res.on('end', () => {
            assert.strictEqual(
              Buffer.concat(chunks).toString(),
              'Invalid Upgrade header'
            );
            wss.close(done);
          });
        });
      });

      wss.on('connection', () => {
        done(new Error("Unexpected 'connection' event"));
      });
    });

    it('fails if the Sec-WebSocket-Key header is invalid (1/2)', (done) => {
      const wss = new WebSocket.Server({ port: 0 }, () => {
        const req = http.get({
          port: wss.address().port,
          headers: {
            Connection: 'Upgrade',
            Upgrade: 'websocket'
          }
        });

        req.on('response', (res) => {
          assert.strictEqual(res.statusCode, 400);

          const chunks = [];

          res.on('data', (chunk) => {
            chunks.push(chunk);
          });

          res.on('end', () => {
            assert.strictEqual(
              Buffer.concat(chunks).toString(),
              'Missing or invalid Sec-WebSocket-Key header'
            );
            wss.close(done);
          });
        });
      });

      wss.on('connection', () => {
        done(new Error("Unexpected 'connection' event"));
      });
    });

    it('fails if the Sec-WebSocket-Key header is invalid (2/2)', (done) => {
      const wss = new WebSocket.Server({ port: 0 }, () => {
        const req = http.get({
          port: wss.address().port,
          headers: {
            Connection: 'Upgrade',
            Upgrade: 'websocket',
            'Sec-WebSocket-Key': 'P5l8BJcZwRc='
          }
        });

        req.on('response', (res) => {
          assert.strictEqual(res.statusCode, 400);

          const chunks = [];

          res.on('data', (chunk) => {
            chunks.push(chunk);
          });

          res.on('end', () => {
            assert.strictEqual(
              Buffer.concat(chunks).toString(),
              'Missing or invalid Sec-WebSocket-Key header'
            );
            wss.close(done);
          });
        });
      });

      wss.on('connection', () => {
        done(new Error("Unexpected 'connection' event"));
      });
    });

    it('fails if the Sec-WebSocket-Version header is invalid (1/2)', (done) => {
      const wss = new WebSocket.Server({ port: 0 }, () => {
        const req = http.get({
          port: wss.address().port,
          headers: {
            Connection: 'Upgrade',
            Upgrade: 'websocket',
            'Sec-WebSocket-Key': 'dGhlIHNhbXBsZSBub25jZQ=='
          }
        });

        req.on('response', (res) => {
          assert.strictEqual(res.statusCode, 400);

          const chunks = [];

          res.on('data', (chunk) => {
            chunks.push(chunk);
          });

          res.on('end', () => {
            assert.strictEqual(
              Buffer.concat(chunks).toString(),
              'Missing or invalid Sec-WebSocket-Version header'
            );
            wss.close(done);
          });
        });
      });

      wss.on('connection', () => {
        done(new Error("Unexpected 'connection' event"));
      });
    });

    it('fails if the Sec-WebSocket-Version header is invalid (2/2)', (done) => {
      const wss = new WebSocket.Server({ port: 0 }, () => {
        const req = http.get({
          port: wss.address().port,
          headers: {
            Connection: 'Upgrade',
            Upgrade: 'websocket',
            'Sec-WebSocket-Key': 'dGhlIHNhbXBsZSBub25jZQ==',
            'Sec-WebSocket-Version': 12
          }
        });

        req.on('response', (res) => {
          assert.strictEqual(res.statusCode, 400);

          const chunks = [];

          res.on('data', (chunk) => {
            chunks.push(chunk);
          });

          res.on('end', () => {
            assert.strictEqual(
              Buffer.concat(chunks).toString(),
              'Missing or invalid Sec-WebSocket-Version header'
            );
            wss.close(done);
          });
        });
      });

      wss.on('connection', () => {
        done(new Error("Unexpected 'connection' event"));
      });
    });

    it('fails is the Sec-WebSocket-Protocol header is invalid', (done) => {
      const wss = new WebSocket.Server({ port: 0 }, () => {
        const req = http.get({
          port: wss.address().port,
          headers: {
            Connection: 'Upgrade',
            Upgrade: 'websocket',
            'Sec-WebSocket-Key': 'dGhlIHNhbXBsZSBub25jZQ==',
            'Sec-WebSocket-Version': 13,
            'Sec-WebSocket-Protocol': 'foo;bar'
          }
        });

        req.on('response', (res) => {
          assert.strictEqual(res.statusCode, 400);

          const chunks = [];

          res.on('data', (chunk) => {
            chunks.push(chunk);
          });

          res.on('end', () => {
            assert.strictEqual(
              Buffer.concat(chunks).toString(),
              'Invalid Sec-WebSocket-Protocol header'
            );
            wss.close(done);
          });
        });
      });

      wss.on('connection', () => {
        done(new Error("Unexpected 'connection' event"));
      });
    });

    it('fails if the Sec-WebSocket-Extensions header is invalid', (done) => {
      const wss = new WebSocket.Server(
        {
          perMessageDeflate: true,
          port: 0
        },
        () => {
          const req = http.get({
            port: wss.address().port,
            headers: {
              Connection: 'Upgrade',
              Upgrade: 'websocket',
              'Sec-WebSocket-Key': 'dGhlIHNhbXBsZSBub25jZQ==',
              'Sec-WebSocket-Version': 13,
              'Sec-WebSocket-Extensions':
                'permessage-deflate; server_max_window_bits=foo'
            }
          });

          req.on('response', (res) => {
            assert.strictEqual(res.statusCode, 400);

            const chunks = [];

            res.on('data', (chunk) => {
              chunks.push(chunk);
            });

            res.on('end', () => {
              assert.strictEqual(
                Buffer.concat(chunks).toString(),
                'Invalid or unacceptable Sec-WebSocket-Extensions header'
              );
              wss.close(done);
            });
          });
        }
      );

      wss.on('connection', () => {
        done(new Error("Unexpected 'connection' event"));
      });
    });

    it("emits the 'wsClientError' event", (done) => {
      const wss = new WebSocket.Server({ port: 0 }, () => {
        const req = http.request({
          method: 'POST',
          port: wss.address().port,
          headers: {
            Connection: 'Upgrade',
            Upgrade: 'websocket'
          }
        });

        req.on('response', (res) => {
          assert.strictEqual(res.statusCode, 400);
          wss.close(done);
        });

        req.end();
      });

      wss.on('wsClientError', (err, socket, request) => {
        assert.ok(err instanceof Error);
        assert.strictEqual(err.message, 'Invalid HTTP method');

        assert.ok(request instanceof http.IncomingMessage);
        assert.strictEqual(request.method, 'POST');

        socket.end('HTTP/1.1 400 Bad Request\r\n\r\n');
      });

      wss.on('connection', () => {
        done(new Error("Unexpected 'connection' event"));
      });
    });

    it('fails if the WebSocket server is closing or closed', (done) => {
      const server = http.createServer();
      const wss = new WebSocket.Server({ noServer: true });

      server.on('upgrade', (req, socket, head) => {
        wss.close();
        wss.handleUpgrade(req, socket, head, () => {
          done(new Error('Unexpected callback invocation'));
        });
      });

      server.listen(0, () => {
        const ws = new WebSocket(`ws://localhost:${server.address().port}`);

        ws.on('unexpected-response', (req, res) => {
          assert.strictEqual(res.statusCode, 503);
          res.resume();
          server.close(done);
        });
      });
    });

    it('handles unsupported extensions', (done) => {
      const wss = new WebSocket.Server(
        {
          perMessageDeflate: true,
          port: 0
        },
        () => {
          const req = http.get({
            port: wss.address().port,
            headers: {
              Connection: 'Upgrade',
              Upgrade: 'websocket',
              'Sec-WebSocket-Key': 'dGhlIHNhbXBsZSBub25jZQ==',
              'Sec-WebSocket-Version': 13,
              'Sec-WebSocket-Extensions': 'foo; bar'
            }
          });

          req.on('upgrade', (res, socket, head) => {
            if (head.length) socket.unshift(head);

            socket.once('data', (chunk) => {
              assert.strictEqual(chunk[0], 0x88);
              socket.destroy();
              wss.close(done);
            });
          });
        }
      );

      wss.on('connection', (ws) => {
        assert.strictEqual(ws.extensions, '');
        ws.close();
      });
    });

    describe('`verifyClient`', () => {
      it('can reject client synchronously', (done) => {
        const wss = new WebSocket.Server(
          {
            verifyClient: () => false,
            port: 0
          },
          () => {
            const req = http.get({
              port: wss.address().port,
              headers: {
                Connection: 'Upgrade',
                Upgrade: 'websocket',
                'Sec-WebSocket-Key': 'dGhlIHNhbXBsZSBub25jZQ==',
                'Sec-WebSocket-Version': 8
              }
            });

            req.on('response', (res) => {
              assert.strictEqual(res.statusCode, 401);
              wss.close(done);
            });
          }
        );

        wss.on('connection', () => {
          done(new Error("Unexpected 'connection' event"));
        });
      });

      it('can accept client synchronously', (done) => {
        const server = https.createServer({
          cert: fs.readFileSync('test/fixtures/certificate.pem'),
          key: fs.readFileSync('test/fixtures/key.pem')
        });

        const wss = new WebSocket.Server({
          verifyClient: (info) => {
            assert.strictEqual(info.origin, 'https://example.com');
            assert.strictEqual(info.req.headers.foo, 'bar');
            assert.ok(info.secure, true);
            return true;
          },
          server
        });

        wss.on('connection', () => {
          server.close(done);
        });

        server.listen(0, () => {
          const ws = new WebSocket(`wss://localhost:${server.address().port}`, {
            headers: { Origin: 'https://example.com', foo: 'bar' },
            rejectUnauthorized: false
          });

          ws.on('open', ws.close);
        });
      });

      it('can accept client asynchronously', (done) => {
        const wss = new WebSocket.Server(
          {
            verifyClient: (o, cb) => process.nextTick(cb, true),
            port: 0
          },
          () => {
            const ws = new WebSocket(`ws://localhost:${wss.address().port}`);

            ws.on('open', ws.close);
          }
        );

        wss.on('connection', () => wss.close(done));
      });

      it('can reject client asynchronously', (done) => {
        const wss = new WebSocket.Server(
          {
            verifyClient: (info, cb) => process.nextTick(cb, false),
            port: 0
          },
          () => {
            const req = http.get({
              port: wss.address().port,
              headers: {
                Connection: 'Upgrade',
                Upgrade: 'websocket',
                'Sec-WebSocket-Key': 'dGhlIHNhbXBsZSBub25jZQ==',
                'Sec-WebSocket-Version': 8
              }
            });

            req.on('response', (res) => {
              assert.strictEqual(res.statusCode, 401);
              wss.close(done);
            });
          }
        );

        wss.on('connection', () => {
          done(new Error("Unexpected 'connection' event"));
        });
      });

      it('can reject client asynchronously w/ status code', (done) => {
        const wss = new WebSocket.Server(
          {
            verifyClient: (info, cb) => process.nextTick(cb, false, 404),
            port: 0
          },
          () => {
            const req = http.get({
              port: wss.address().port,
              headers: {
                Connection: 'Upgrade',
                Upgrade: 'websocket',
                'Sec-WebSocket-Key': 'dGhlIHNhbXBsZSBub25jZQ==',
                'Sec-WebSocket-Version': 8
              }
            });

            req.on('response', (res) => {
              assert.strictEqual(res.statusCode, 404);
              wss.close(done);
            });
          }
        );

        wss.on('connection', () => {
          done(new Error("Unexpected 'connection' event"));
        });
      });

      it('can reject client asynchronously w/ custom headers', (done) => {
        const wss = new WebSocket.Server(
          {
            verifyClient: (info, cb) => {
              process.nextTick(cb, false, 503, '', { 'Retry-After': 120 });
            },
            port: 0
          },
          () => {
            const req = http.get({
              port: wss.address().port,
              headers: {
                Connection: 'Upgrade',
                Upgrade: 'websocket',
                'Sec-WebSocket-Key': 'dGhlIHNhbXBsZSBub25jZQ==',
                'Sec-WebSocket-Version': 8
              }
            });

            req.on('response', (res) => {
              assert.strictEqual(res.statusCode, 503);
              assert.strictEqual(res.headers['retry-after'], '120');
              wss.close(done);
            });
          }
        );

        wss.on('connection', () => {
          done(new Error("Unexpected 'connection' event"));
        });
      });
    });

    it("doesn't emit the 'connection' event if socket is closed prematurely", (done) => {
      const server = http.createServer();

      server.listen(0, () => {
        const wss = new WebSocket.Server({
          verifyClient: ({ req: { socket } }, cb) => {
            assert.strictEqual(socket.readable, true);
            assert.strictEqual(socket.writable, true);

            socket.on('end', () => {
              assert.strictEqual(socket.readable, false);
              assert.strictEqual(socket.writable, true);
              cb(true);
            });
          },
          server
        });

        wss.on('connection', () => {
          done(new Error("Unexpected 'connection' event"));
        });

        const socket = net.connect(
          {
            port: server.address().port,
            allowHalfOpen: true
          },
          () => {
            socket.end(
              [
                'GET / HTTP/1.1',
                'Host: localhost',
                'Upgrade: websocket',
                'Connection: Upgrade',
                'Sec-WebSocket-Key: dGhlIHNhbXBsZSBub25jZQ==',
                'Sec-WebSocket-Version: 13',
                '\r\n'
              ].join('\r\n')
            );
          }
        );

        socket.on('end', () => {
          wss.close();
          server.close(done);
        });
      });
    });

    it('handles data passed along with the upgrade request', (done) => {
      const wss = new WebSocket.Server({ port: 0 }, () => {
        const req = http.request({
          port: wss.address().port,
          headers: {
            Connection: 'Upgrade',
            Upgrade: 'websocket',
            'Sec-WebSocket-Key': 'dGhlIHNhbXBsZSBub25jZQ==',
            'Sec-WebSocket-Version': 13
          }
        });

        const list = Sender.frame(Buffer.from('Hello'), {
          fin: true,
          rsv1: false,
          opcode: 0x01,
          mask: true,
          readOnly: false
        });

        req.write(Buffer.concat(list));
        req.end();
      });

      wss.on('connection', (ws) => {
        ws.on('message', (data, isBinary) => {
          assert.deepStrictEqual(data, Buffer.from('Hello'));
          assert.ok(!isBinary);
          wss.close(done);
        });
      });
    });

    describe('`handleProtocols`', () => {
      it('allows to select a subprotocol', (done) => {
        const handleProtocols = (protocols, request) => {
          assert.ok(request instanceof http.IncomingMessage);
          assert.strictEqual(request.url, '/');
          return Array.from(protocols).pop();
        };
        const wss = new WebSocket.Server({ handleProtocols, port: 0 }, () => {
          const ws = new WebSocket(`ws://localhost:${wss.address().port}`, [
            'foo',
            'bar'
          ]);

          ws.on('open', () => {
            assert.strictEqual(ws.protocol, 'bar');
            wss.close(done);
          });
        });

        wss.on('connection', (ws) => {
          ws.close();
        });
      });
    });

    it("emits the 'headers' event", (done) => {
      const wss = new WebSocket.Server({ port: 0 }, () => {
        const ws = new WebSocket(
          `ws://localhost:${wss.address().port}?foo=bar`
        );

        ws.on('open', ws.close);
      });

      wss.on('headers', (headers, request) => {
        assert.deepStrictEqual(headers.slice(0, 3), [
          'HTTP/1.1 101 Switching Protocols',
          'Upgrade: websocket',
          'Connection: Upgrade'
        ]);
        assert.ok(request instanceof http.IncomingMessage);
        assert.strictEqual(request.url, '/?foo=bar');

        wss.on('connection', () => wss.close(done));
      });
    });
  });

  describe('permessage-deflate', () => {
    it('is disabled by default', (done) => {
      const wss = new WebSocket.Server({ port: 0 }, () => {
        const ws = new WebSocket(`ws://localhost:${wss.address().port}`);

        ws.on('open', ws.close);
      });

      wss.on('connection', (ws, req) => {
        assert.strictEqual(
          req.headers['sec-websocket-extensions'],
          'permessage-deflate; client_max_window_bits'
        );
        assert.strictEqual(ws.extensions, '');
        wss.close(done);
      });
    });

    it('uses configuration options', (done) => {
      const wss = new WebSocket.Server(
        {
          perMessageDeflate: { clientMaxWindowBits: 8 },
          port: 0
        },
        () => {
          const ws = new WebSocket(`ws://localhost:${wss.address().port}`);

          ws.on('upgrade', (res) => {
            assert.strictEqual(
              res.headers['sec-websocket-extensions'],
              'permessage-deflate; client_max_window_bits=8'
            );

            wss.close(done);
          });
        }
      );

      wss.on('connection', (ws) => {
        ws.close();
      });
    });
  });
});





