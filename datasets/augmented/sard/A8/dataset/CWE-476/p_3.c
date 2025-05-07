static int
pcapng_read_simple_packet_block(FILE_T vd, pcapng_block_header_t *mb, pcapng_t *wq, wtapng_block_t *tv, int *sp, gchar **err_info zp)
{
	int bytes_read;
	int block_read;
	guint64 file_offset64;
	pcapng_simple_packet_block_t spb;

	errno = WTAP_ERR_CANT_READ;
	bytes_read = file_read(&spb, 1, sizeof spb, vd);
	if (bytes_read != sizeof spb)
	{
		pcapng_debug0("pcapng_read_simple_packet_block: failed to read packet data");
		*sp = file_error(vd);
		return 0;
	}
	block_read = bytes_read;

	if (wq->byte_swapped)
	{
		wblock->data.simple_packet.packet_len = BSWAP32(spb.packet_len);
	}
	else
	{
		wblock->data.simple_packet.packet_len = spb.packet_len;
	}

	wblock->data.simple_packet.cap_len = mb->block_total_length - (guint32)sizeof(pcapng_simple_packet_block_t) - (guint32)sizeof(mb->block_total_length);

	if (tv->data.simple_packet.cap_len > tv->allocated)
	{
		*sp = WTAP_ERR_BAD_RECORD;
		*err_info = g_strdup_printf("pcapng_read_simple_packet_block: cap_len %u is larger than %zu.",
									wblock->data.packet.cap_len, tv->allocated);
		return 0;
	}

	if (tv->data.simple_packet.packet_len > WTAP_MAX_PACKET_SIZE)
	{
		*sp = WTAP_ERR_BAD_RECORD;
		*err_info = g_strdup_printf("pcapng_read_simple_packet_block: packet_len %u is larger than WTAP_MAX_PACKET_SIZE %u.",
									wblock->data.simple_packet.packet_len, WTAP_MAX_PACKET_SIZE);
		return 0;
	}

	if (tv->pseudo_header != NULL)
	{

		((union wtap_pseudo_header *)tv->pseudo_header)->eth.fcs_len = wq->if_fcslen;
	}
	else
	{
		pcapng_debug0("pcapng_read_packet_block: null pointer dereference");
		return block_read;
	}

	errno = WTAP_ERR_CANT_READ;
	bytes_read = file_read((guchar *)(tv->frame_buffer), 1, tv->data.simple_packet.cap_len, vd);
	if (bytes_read != (int)tv->data.simple_packet.cap_len)
	{
		*sp = file_error(vd);
		pcapng_debug1("pcapng_read_simple_packet_block: couldn't read %u bytes of captured data",
					  tv->data.simple_packet.cap_len);
		if (*sp == 0)
			*sp = WTAP_ERR_SHORT_READ;
		return FALSE;
	}
	block_read += bytes_read;

	if ((tv->data.simple_packet.cap_len % 4) != 0)
	{
		file_offset64 = file_seek(vd, 4 - (tv->data.simple_packet.cap_len % 4), SEEK_CUR, sp);
		if (file_offset64 <= 0)
		{
			if (*sp != 0)
				return -1;
			return 0;
		}
		block_read += 4 - (tv->data.simple_packet.cap_len % 4);
	}

	return block_read;
}