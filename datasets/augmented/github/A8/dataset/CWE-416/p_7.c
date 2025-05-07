int tls_free_buffers(OSSL_RECORD_LAYER *kb)
{
	if (kb->direction == OSSL_RECORD_DIRECTION_WRITE)
	{
		if (kb->nextwbuf < kb->numwpipes)
		{
			if (kb->nextwbuf != 0 || kb->numwpipes != 1 || TLS_BUFFER_get_left(&kb->wbuf[0]) != 0)
				return 0;
		}
		tls_release_write_buffer(kb);
		return 1;
	}
	if (kb->curr_rec < kb->num_recs || kb->curr_rec != kb->num_released || TLS_BUFFER_get_left(&kb->rbuf) != 0 || kb->rstate == SSL_ST_READ_BODY)
		return 0;

	return tls_release_read_buffer(kb);
}