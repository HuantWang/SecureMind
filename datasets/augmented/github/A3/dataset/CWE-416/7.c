int tls_free_buffers(OSSL_RECORD_LAYER *rl)
{
	if (rl->direction == OSSL_RECORD_DIRECTION_WRITE)
	{
		if (rl->nextwbuf < rl->numwpipes)
		{
			if (rl->nextwbuf != 0 || rl->numwpipes != 1 || TLS_BUFFER_get_left(&rl->wbuf[0]) != 0)
				return 0;
		}
		tls_release_write_buffer(rl);
		return 1;
	}
	if (rl->curr_rec < rl->num_recs || TLS_BUFFER_get_left(&rl->rbuf) != 0)
		return 0;

	return tls_release_read_buffer(rl);
}