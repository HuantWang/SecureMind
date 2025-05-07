void handle_add_plugin(nng_aio *aio)
{
    neu_plugin_t *plugin = neu_rest_get_plugin();

    NEU_PROCESS_HTTP_REQUEST_VALIDATE_JWT(
        aio, neu_json_add_plugin_req_t, neu_json_decode_add_plugin_req, {
            int overflow = 0;
            neu_reqresp_head_t header = {0};
            neu_req_add_plugin_t cmd = {0};

            header.ctx = aio;
            header.type = NEU_REQ_ADD_PLUGIN;
            header.otel_trace_type = NEU_OTEL_TRACE_TYPE_REST_COMM;
            strcpy(cmd.library, req->library);
            cmd.schema_file = req->schema_file;
            cmd.so_file = req->so_file;
            overflow = neu_plugin_op(plugin, header, &cmd);
            if (overflow != 0)
            {
                NEU_JSON_RESPONSE_ERROR(NEU_ERR_IS_BUSY, {
                    neu_http_response(aio, NEU_ERR_IS_BUSY, result_error);
                });
            }
        })
}

void handle_update_plugin(nng_aio *aio)
{
    neu_plugin_t *plugin = neu_rest_get_plugin();

    NEU_PROCESS_HTTP_REQUEST_VALIDATE_JWT(
        aio, neu_json_update_plugin_req_t, neu_json_decode_add_plugin_req, {
            int overflow = 0;
            neu_reqresp_head_t header = {0};
            neu_req_update_plugin_t cmd = {0};

            header.ctx = aio;
            header.type = NEU_REQ_UPDATE_PLUGIN;
            header.otel_trace_type = NEU_OTEL_TRACE_TYPE_REST_COMM;
            strcpy(cmd.library, req->library);
            cmd.schema_file = req->schema_file;
            cmd.so_file = req->so_file;
            overflow = neu_plugin_op(plugin, header, &cmd);
            if (overflow != 0)
            {
                NEU_JSON_RESPONSE_ERROR(NEU_ERR_IS_BUSY, {
                    neu_http_response(aio, NEU_ERR_IS_BUSY, result_error);
                });
            }
        })
}