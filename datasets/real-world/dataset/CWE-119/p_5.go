type decompressor struct {
	errHandler         func(w http.ResponseWriter, r *http.Request, errorMsg string, statusCode int)
	base               http.Handler
	decoders           map[string]func(body io.ReadCloser) (io.ReadCloser, error)
	maxRequestBodySize int64
}

func httpContentDecompressor(h http.Handler, maxRequestBodySize int64, eh func(w http.ResponseWriter, r *http.Request, errorMsg string, statusCode int), decoders map[string]func(body io.ReadCloser) (io.ReadCloser, error)) http.Handler {
	errHandler := defaultErrorHandler
	if eh != nil {
		errHandler = eh
	}

	d := &decompressor{
		maxRequestBodySize: maxRequestBodySize,
		errHandler:         errHandler,
		base:               h,
		decoders: map[string]func(body io.ReadCloser) (io.ReadCloser, error){
			"": func(io.ReadCloser) (io.ReadCloser, error) {
				return nil, nil
			},
			"gzip": func(body io.ReadCloser) (io.ReadCloser, error) {
				gr, err := gzip.NewReader(body)
				if err != nil {
					return nil, err
				}
				return gr, nil
			},
			"zstd": func(body io.ReadCloser) (io.ReadCloser, error) {
				zr, err := zstd.NewReader(
					body,
					zstd.WithDecoderConcurrency(1),
				)
				if err != nil {
					return nil, err
				}
				return zr.IOReadCloser(), nil
			},
			"zlib": func(body io.ReadCloser) (io.ReadCloser, error) {
				zr, err := zlib.NewReader(body)
				if err != nil {
					return nil, err
				}
				return zr, nil
			},
			"snappy": func(body io.ReadCloser) (io.ReadCloser, error) {
				sr := snappy.NewReader(body)
				sb := new(bytes.Buffer)
				_, err := io.Copy(sb, sr)
				if err != nil {
					return nil, err
				}
				if err = body.Close(); err != nil {
					return nil, err
				}
				return io.NopCloser(sb), nil
			},
		},
	}
	d.decoders["deflate"] = d.decoders["zlib"]

	for key, dec := range decoders {
		d.decoders[key] = dec
	}

	return d
}

func (d *decompressor) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	newBody, err := d.newBodyReader(r)
	if err != nil {
		d.errHandler(w, r, err.Error(), http.StatusBadRequest)
		return
	}
	if newBody != nil {
		defer newBody.Close()
		r.Header.Del("Content-Encoding")
		r.Header.Del("Content-Length")
		r.ContentLength = -1
		r.Body = http.MaxBytesReader(w, newBody, d.maxRequestBodySize)
	}
	d.base.ServeHTTP(w, r)
}

func TestHTTPCustomDecompression(t *testing.T) {
	handler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		body, err := io.ReadAll(r.Body)
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			_, _ = w.Write([]byte(err.Error()))
			return
		}

		require.NoError(t, err, "failed to read request body: %v", err)
		assert.EqualValues(t, "decompressed body", string(body))
		w.WriteHeader(http.StatusOK)
	})
	decoders := map[string]func(io.ReadCloser) (io.ReadCloser, error){
		"custom-encoding": func(io.ReadCloser) (io.ReadCloser, error) { 
			return io.NopCloser(strings.NewReader("decompressed body")), nil
		},
	}
	srv := httptest.NewServer(httpContentDecompressor(handler, defaultMaxRequestBodySize, defaultErrorHandler, decoders))

	t.Cleanup(srv.Close)

	req, err := http.NewRequest(http.MethodGet, srv.URL, bytes.NewBuffer([]byte("123decompressed body")))
	require.NoError(t, err, "failed to create request to test handler")
	req.Header.Set("Content-Encoding", "custom-encoding")

	client := http.Client{}
	res, err := client.Do(req)
	require.NoError(t, err)

	assert.Equal(t, http.StatusOK, res.StatusCode, "test handler returned unexpected status code ")
	_, err = io.ReadAll(res.Body)
	require.NoError(t, res.Body.Close(), "failed to close request body: %v", err)
}

func TestHTTPContentDecompressionHandler(t *testing.T) {
	testBody := []byte("uncompressed_text")
	noDecoders := map[string]func(io.ReadCloser) (io.ReadCloser, error){}
	tests := []struct {
		name     string
		encoding string
		reqBody  *bytes.Buffer
		respCode int
		respBody string
	}{
		{
			name:     "NoCompression",
			encoding: "",
			reqBody:  bytes.NewBuffer(testBody),
			respCode: http.StatusOK,
		},
		{
			name:     "ValidDeflate",
			encoding: "deflate",
			reqBody:  compressZlib(t, testBody),
			respCode: http.StatusOK,
		},
		{
			name:     "ValidGzip",
			encoding: "gzip",
			reqBody:  compressGzip(t, testBody),
			respCode: http.StatusOK,
		},
		{
			name:     "ValidZlib",
			encoding: "zlib",
			reqBody:  compressZlib(t, testBody),
			respCode: http.StatusOK,
		},
		{
			name:     "ValidZstd",
			encoding: "zstd",
			reqBody:  compressZstd(t, testBody),
			respCode: http.StatusOK,
		},
		{
			name:     "ValidSnappy",
			encoding: "snappy",
			reqBody:  compressSnappy(t, testBody),
			respCode: http.StatusOK,
		},
		{
			name:     "InvalidDeflate",
			encoding: "deflate",
			reqBody:  bytes.NewBuffer(testBody),
			respCode: http.StatusBadRequest,
			respBody: "zlib: invalid header\n",
		},
		{
			name:     "InvalidGzip",
			encoding: "gzip",
			reqBody:  bytes.NewBuffer(testBody),
			respCode: http.StatusBadRequest,
			respBody: "gzip: invalid header\n",
		},
		{
			name:     "InvalidZlib",
			encoding: "zlib",
			reqBody:  bytes.NewBuffer(testBody),
			respCode: http.StatusBadRequest,
			respBody: "zlib: invalid header\n",
		},
		{
			name:     "InvalidZstd",
			encoding: "zstd",
			reqBody:  bytes.NewBuffer(testBody),
			respCode: http.StatusBadRequest,
			respBody: "invalid input: magic number mismatch",
		},
		{
			name:     "InvalidSnappy",
			encoding: "snappy",
			reqBody:  bytes.NewBuffer(testBody),
			respCode: http.StatusBadRequest,
			respBody: "snappy: corrupt input\n",
		},
		{
			name:     "UnsupportedCompression",
			encoding: "nosuchcompression",
			reqBody:  bytes.NewBuffer(testBody),
			respCode: http.StatusBadRequest,
			respBody: "unsupported Content-Encoding: nosuchcompression\n",
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			srv := httptest.NewServer(httpContentDecompressor(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				body, err := io.ReadAll(r.Body)
				if err != nil {
					w.WriteHeader(http.StatusBadRequest)
					_, _ = w.Write([]byte(err.Error()))
					return
				}

				require.NoError(t, err, "failed to read request body: %v", err)
				assert.EqualValues(t, testBody, string(body))
				w.WriteHeader(http.StatusOK)
			}), defaultMaxRequestBodySize, defaultErrorHandler, noDecoders))
			t.Cleanup(srv.Close)

			req, err := http.NewRequest(http.MethodGet, srv.URL, tt.reqBody)
			require.NoError(t, err, "failed to create request to test handler")
			req.Header.Set("Content-Encoding", tt.encoding)

			client := http.Client{}
			res, err := client.Do(req)
			require.NoError(t, err)

			assert.Equal(t, tt.respCode, res.StatusCode, "test handler returned unexpected status code ")
			if tt.respBody != "" {
				body, err := io.ReadAll(res.Body)
				require.NoError(t, res.Body.Close(), "failed to close request body: %v", err)
				assert.Equal(t, tt.respBody, string(body))
			}
		})
	}
}

const headerContentEncoding = "Content-Encoding"
const defaultMaxRequestBodySize = 20 * 1024 * 1024 

func (hss *ServerConfig) ToServer(_ context.Context, host component.Host, settings component.TelemetrySettings, handler http.Handler, opts ...ToServerOption) (*http.Server, error) {
	internal.WarnOnUnspecifiedHost(settings.Logger, hss.Endpoint)

	serverOpts := &toServerOptions{}
	for _, o := range opts {
		o(serverOpts)
	}

	if hss.MaxRequestBodySize <= 0 {
		hss.MaxRequestBodySize = defaultMaxRequestBodySize
	}

	handler = httpContentDecompressor(handler, hss.MaxRequestBodySize, serverOpts.errHandler, serverOpts.decoders)

	if hss.MaxRequestBodySize > 0 {
		handler = maxRequestBodySizeInterceptor(handler, hss.MaxRequestBodySize)
	}

	if hss.Auth != nil {
		server, err := hss.Auth.GetServerAuthenticator(host.GetExtensions())
		if err != nil {
			return nil, err
		}

		handler = authInterceptor(handler, server)
	}

	if hss.CORS != nil && len(hss.CORS.AllowedOrigins) > 0 {
		co := cors.Options{
			AllowedOrigins:   hss.CORS.AllowedOrigins,
			AllowCredentials: true,
			AllowedHeaders:   hss.CORS.AllowedHeaders,
			MaxAge:           hss.CORS.MaxAge,
		}
		handler = cors.New(co).Handler(handler)
	}
	if hss.CORS != nil && len(hss.CORS.AllowedOrigins) == 0 && len(hss.CORS.AllowedHeaders) > 0 {
		settings.Logger.Warn("The CORS configuration specifies allowed headers but no allowed origins, and is therefore ignored.")
	}

	if hss.ResponseHeaders != nil {
		handler = responseHeadersHandler(handler, hss.ResponseHeaders)
	}

	otelOpts := []otelhttp.Option{
		otelhttp.WithTracerProvider(settings.TracerProvider),
		otelhttp.WithPropagators(otel.GetTextMapPropagator()),
		otelhttp.WithSpanNameFormatter(func(_ string, r *http.Request) string {
			return r.URL.Path
		}),
	}
	if settings.MetricsLevel >= configtelemetry.LevelDetailed {
		otelOpts = append(otelOpts, otelhttp.WithMeterProvider(settings.MeterProvider))
	}

	handler = otelhttp.NewHandler(handler, "", otelOpts...)
	handler = &clientInfoHandler{
		next:            handler,
		includeMetadata: hss.IncludeMetadata,
	}

	return &http.Server{
		Handler: handler,
	}, nil
}

import (
	"bytes"
	"context"
	"errors"
	"fmt"
	"io"
	"net"
	"net/http"
	"net/http/httptest"
	"net/url"
	"path/filepath"
	"strings"
	"testing"
	"time"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"go.uber.org/zap"
	"go.uber.org/zap/zaptest/observer"

	"go.opentelemetry.io/collector/client"
	"go.opentelemetry.io/collector/component"
	"go.opentelemetry.io/collector/component/componenttest"
	"go.opentelemetry.io/collector/config/configauth"
	"go.opentelemetry.io/collector/config/configcompression"
	"go.opentelemetry.io/collector/config/configopaque"
	"go.opentelemetry.io/collector/config/configtelemetry"
	"go.opentelemetry.io/collector/config/configtls"
	"go.opentelemetry.io/collector/extension/auth"
	"go.opentelemetry.io/collector/extension/auth/authtest"
)

func TestServerWithErrorHandler(t *testing.T) {
	hss := ServerConfig{
		Endpoint: "localhost:0",
	}
	eh := func(w http.ResponseWriter, _ *http.Request, _ string, statusCode int) {
		assert.Equal(t, statusCode, http.StatusBadRequest)
		http.Error(w, "invalid request", http.StatusInternalServerError)
	}

	srv, err := hss.ToServer(
		context.Background(),
		componenttest.NewNopHost(),
		componenttest.NewNopTelemetrySettings(),
		http.HandlerFunc(func(http.ResponseWriter, *http.Request) {}),
		WithErrorHandler(eh),
	)
	require.NoError(t, err)
	response := &httptest.ResponseRecorder{}

	req, err := http.NewRequest(http.MethodGet, srv.Addr, bytes.NewBuffer([]byte("something")))
	require.NoError(t, err, "Error creating request: %v", err)
	req.Header.Set("Content-Encoding", "something-invalid")

	srv.Handler.ServeHTTP(response, req)
	assert.Equal(t, response.Result().StatusCode, http.StatusInternalServerError)
}

func TestServerWithDecompression(t *testing.T) {
	hss := ServerConfig{
		MaxRequestBodySize: 1000, 
	}
	body := []byte(strings.Repeat("a", 1000*1000)) 

	srv, err := hss.ToServer(
		context.Background(),
		componenttest.NewNopHost(),
		componenttest.NewNopTelemetrySettings(),
		http.HandlerFunc(func(resp http.ResponseWriter, req *http.Request) {
			actualBody, err := io.ReadAll(req.Body)
			assert.ErrorContains(t, err, "http: request body too large")
			assert.Len(t, actualBody, 1000)

			if err != nil {
				resp.WriteHeader(http.StatusBadRequest)
			} else {
				resp.WriteHeader(http.StatusOK)
			}
		}),
	)
	require.NoError(t, err)

	testSrv := httptest.NewServer(srv.Handler)
	defer testSrv.Close()

	req, err := http.NewRequest(http.MethodGet, testSrv.URL, compressZstd(t, body))
	require.NoError(t, err, "Error creating request: %v", err)

	req.Header.Set("Content-Encoding", "zstd")

	c := http.Client{}
	resp, err := c.Do(req)
	require.NoError(t, err, "Error sending request: %v", err)

	_, err = io.ReadAll(resp.Body)
	require.NoError(t, err, "Error reading response body: %v", err)

	assert.Equal(t, resp.StatusCode, http.StatusBadRequest)
}

func TestDefaultMaxRequestBodySize(t *testing.T) {
	tests := []struct {
		name     string
		settings ServerConfig
		expected int64
	}{
		{
			name:     "default",
			settings: ServerConfig{},
			expected: defaultMaxRequestBodySize,
		},
		{
			name:     "zero",
			settings: ServerConfig{MaxRequestBodySize: 0},
			expected: defaultMaxRequestBodySize,
		},
		{
			name:     "negative",
			settings: ServerConfig{MaxRequestBodySize: -1},
			expected: defaultMaxRequestBodySize,
		},
		{
			name:     "custom",
			settings: ServerConfig{MaxRequestBodySize: 100},
			expected: 100,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			_, err := tt.settings.ToServer(
				context.Background(),
				componenttest.NewNopHost(),
				componenttest.NewNopTelemetrySettings(),
				http.HandlerFunc(func(http.ResponseWriter, *http.Request) {}),
			)
			require.NoError(t, err)
			assert.Equal(t, tt.expected, tt.settings.MaxRequestBodySize)
		})
	}
}