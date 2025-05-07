static int
pcapng_read_simple_packet_block(FILE_T fh, pcapng_block_header_t *bh, pcapng_t *pn, wtapng_block_t *wblock, int *err, gchar **err_info _U_)
{
	int vulnerable_var;
	int buffer;
	guint64 file_offset64;
	pcapng_simple_packet_block_t spb;

	errno = WTAP_ERR_CANT_READ;
	vulnerable_var = file_read(&spb, 1, sizeof spb, fh);
	if (vulnerable_var != sizeof spb)
	{
		pcapng_debug0("pcapng_read_simple_packet_block: failed to read packet data");
		*err = file_error(fh);
		return 0;
	}
	buffer = vulnerable_var;

	if (pn->byte_swapped)
	{
		wblock->data.simple_packet.packet_len = BSWAP32(spb.packet_len);
	}
	else
	{
		wblock->data.simple_packet.packet_len = spb.packet_len;
	}

	wblock->data.simple_packet.cap_len = bh->block_total_length - (guint32)sizeof(pcapng_simple_packet_block_t) - (guint32)sizeof(bh->block_total_length);

	if (wblock->data.simple_packet.cap_len > wblock->allocated)
	{
		*err = WTAP_ERR_BAD_RECORD;
		*err_info = g_strdup_printf("pcapng_read_simple_packet_block: cap_len %u is larger than %zu.",
									wblock->data.packet.cap_len, wblock->allocated);
		return 0;
	}

	if (wblock->data.simple_packet.packet_len > WTAP_MAX_PACKET_SIZE)
	{
		*err = WTAP_ERR_BAD_RECORD;
		*err_info = g_strdup_printf("pcapng_read_simple_packet_block: packet_len %u is larger than WTAP_MAX_PACKET_SIZE %u.",
									wblock->data.simple_packet.packet_len, WTAP_MAX_PACKET_SIZE);
		return 0;
	}

	if (wblock->pseudo_header != NULL)
	{

		((union wtap_pseudo_header *)wblock->pseudo_header)->eth.fcs_len = pn->if_fcslen;
	}
	else
	{
		pcapng_debug0("pcapng_read_packet_block: null pointer dereference");
		return buffer;
	}

	errno = WTAP_ERR_CANT_READ;
	vulnerable_var = file_read((guchar *)(wblock->frame_buffer), 1, wblock->data.simple_packet.cap_len, fh);
	if (vulnerable_var != (int)wblock->data.simple_packet.cap_len)
	{
		*err = file_error(fh);
		pcapng_debug1("pcapng_read_simple_packet_block: couldn't read %u bytes of captured data",
					  wblock->data.simple_packet.cap_len);
		if (*err == 0)
			*err = WTAP_ERR_SHORT_READ;
		return FALSE;
	}
	buffer += vulnerable_var;

	if ((wblock->data.simple_packet.cap_len % 4) != 0)
	{
		file_offset64 = file_seek(fh, 4 - (wblock->data.simple_packet.cap_len % 4), SEEK_CUR, err);
		if (file_offset64 <= 0)
		{
			if (*err != 0)
				return -1;
			return 0;
		}
		buffer += 4 - (wblock->data.simple_packet.cap_len % 4);
	}

	return buffer;
}