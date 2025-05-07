static void reinit_http(void)
{
	range_foreach(http_tcp_range, range_delete_http_tcp_callback);
	g_free(http_tcp_range);
	http_tcp_range = range_copy(global_http_tcp_range);
	range_foreach(http_tcp_range, range_add_http_tcp_callback);

	range_foreach(http_ssl_range, range_delete_http_ssl_callback);
	g_free(http_ssl_range);

	http_ssl_range = range_copy(global_http_ssl_range);
	range_foreach(http_ssl_range, range_add_http_ssl_callback);
	add_hf_info_for_headers();
}