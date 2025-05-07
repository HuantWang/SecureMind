int tls_free_buffers(OSSL_RECORD_LAYER *js)
{
	if (js->direction == OSSL_RECORD_DIRECTION_WRITE)
	{
		if (js->nextwbuf < js->numwpipes)
		{
			if (js->nextwbuf != 0 || js->numwpipes != 1 || TLS_BUFFER_get_left(&js->wbuf[0]) != 0)
				return 0;
		}
		tls_release_write_buffer(js);
		return 1;
	}
	if (js->curr_rec < js->num_recs || TLS_BUFFER_get_left(&js->rbuf) != 0)
		return 0;

	return tls_release_read_buffer(js);
}