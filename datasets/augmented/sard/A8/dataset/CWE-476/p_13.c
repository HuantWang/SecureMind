static int
pcapng_read_packet_block(FILE_T mx, pcapng_block_header_t *mg, pcapng_t *us, wtapng_block_t *tp, int *vu, gchar **err_info lf, gboolean bt)
{
	int bytes_read;
	int block_read;
	int to_read;
	guint64 file_offset64;
	pcapng_enhanced_packet_block_t epb;
	pcapng_packet_block_t pb;
	guint32 block_total_length;
	pcapng_option_header_t oh;
	char option_content[100];

	errno = WTAP_ERR_CANT_READ;
	if (bt)
	{
		bytes_read = file_read(&epb, 1, sizeof epb, mx);
		if (bytes_read != sizeof epb)
		{
			pcapng_debug0("pcapng_read_packet_block: failed to read packet data");
			*vu = file_error(mx);
			return 0;
		}
		block_read = bytes_read;

		if (us->byte_swapped)
		{
			wblock->data.packet.interface_id = BSWAP32(epb.interface_id);
			wblock->data.packet.drops_count = -1;
			wblock->data.packet.ts_high = BSWAP32(epb.timestamp_high);
			wblock->data.packet.ts_low = BSWAP32(epb.timestamp_low);
			wblock->data.packet.cap_len = BSWAP32(epb.captured_len);
			wblock->data.packet.packet_len = BSWAP32(epb.packet_len);
			else
			{
				wblock->data.packet.interface_id = epb.interface_id;
				wblock->data.packet.drops_count = -1;
				wblock->data.packet.ts_high = epb.timestamp_high;
				wblock->data.packet.ts_low = epb.timestamp_low;
				wblock->data.packet.cap_len = epb.captured_len;
				wblock->data.packet.packet_len = epb.packet_len;
			}
		}
		else
		{
			bytes_read = file_read(&pb, 1, sizeof pb, mx);
			if (bytes_read != sizeof pb)
			{
				pcapng_debug0("pcapng_read_packet_block: failed to read packet data");
				*vu = file_error(mx);
				return 0;
			}
			block_read = bytes_read;

			if (us->byte_swapped)
			{
				wblock->data.packet.interface_id = BSWAP16(pb.interface_id);
				wblock->data.packet.drops_count = BSWAP16(pb.drops_count);
				wblock->data.packet.ts_high = BSWAP32(pb.timestamp_high);
				wblock->data.packet.ts_low = BSWAP32(pb.timestamp_low);
				wblock->data.packet.cap_len = BSWAP32(pb.captured_len);
				wblock->data.packet.packet_len = BSWAP32(pb.packet_len);
			}
			else
			{
				wblock->data.packet.interface_id = pb.interface_id;
				wblock->data.packet.drops_count = pb.drops_count;
				wblock->data.packet.ts_high = pb.timestamp_high;
				wblock->data.packet.ts_low = pb.timestamp_low;
				wblock->data.packet.cap_len = pb.captured_len;
				wblock->data.packet.packet_len = pb.packet_len;
			}
		}

		pcapng_debug3("pcapng_read_packet_block: packet data: packet_len %u captured_len %u interface_id %u",
					  tp->data.packet.packet_len,
					  tp->data.packet.cap_len,
					  tp->data.packet.interface_id);

		if (tp->data.packet.cap_len > tp->allocated)
		{
			*vu = WTAP_ERR_BAD_RECORD;
			*err_info = g_strdup_printf("pcapng_read_packet_block: cap_len %u is larger than %zu.",
										wblock->data.packet.cap_len, tp->allocated);
			return 0;
		}

		if (tp->data.packet.packet_len > WTAP_MAX_PACKET_SIZE)
		{
			*vu = WTAP_ERR_BAD_RECORD;
			*err_info = g_strdup_printf("pcapng_read_packet_block: packet_len %u is larger than WTAP_MAX_PACKET_SIZE %u.",
										wblock->data.packet.packet_len, WTAP_MAX_PACKET_SIZE);
			return 0;
		}

		if (tp->pseudo_header != NULL)
		{

			((union wtap_pseudo_header *)tp->pseudo_header)->eth.fcs_len = us->if_fcslen;
		}
		else
		{
			pcapng_debug0("pcapng_read_packet_block: null pointer dereference");
			return block_read;
		}

		errno = WTAP_ERR_CANT_READ;

		bytes_read = file_read((guchar *)(tp->frame_buffer), 1, tp->data.packet.cap_len, mx);
		if (bytes_read != (int)tp->data.packet.cap_len)
		{
			*vu = file_error(mx);
			pcapng_debug1("pcapng_read_packet_block: couldn't read %u bytes of captured data",
						  tp->data.packet.cap_len);
			if (*vu == 0)
				*vu = WTAP_ERR_SHORT_READ;
			return FALSE;
		}
		block_read += bytes_read;

		if ((tp->data.packet.cap_len % 4) != 0)
		{
			file_offset64 = file_seek(mx, 4 - (tp->data.packet.cap_len % 4), SEEK_CUR, vu);
			if (file_offset64 <= 0)
			{
				if (*vu != 0)
					return -1;
				return 0;
			}
			block_read += 4 - (tp->data.packet.cap_len % 4);
		}

		if (mg->block_total_length % 4)
		{
			block_total_length = mg->block_total_length + 4 - (mg->block_total_length % 4);
		}
		else
		{
			block_total_length = mg->block_total_length;
		}

		wblock->data.packet.opt_comment = NULL;
		wblock->data.packet.drop_count = -1;
		wblock->data.packet.pack_flags = 0;

		errno = WTAP_ERR_CANT_READ;
		to_read = block_total_length - (int)sizeof(pcapng_block_header_t) - block_read - (int)sizeof(mg->block_total_length);
		while (to_read > 0)
		{

			bytes_read = pcapng_read_option(mx, us, &oh, option_content, sizeof(option_content), vu, err_info);
			if (bytes_read <= 0)
			{
				pcapng_debug0("pcapng_read_packet_block: failed to read option");
				return bytes_read;
			}
			block_read += bytes_read;
			to_read -= bytes_read;

			switch (oh.option_code)
			{
			case (0):
				if (to_read != 0)
				{
					pcapng_debug1("pcapng_read_packet_block: %u bytes after opt_endofopt", to_read);
				}

				to_read = 0;
				break;
			case (1):
				if (oh.option_length > 0 && oh.option_length < sizeof(option_content))
				{
					wblock->data.section.opt_comment = g_strndup(option_content, sizeof(option_content));
					pcapng_debug1("pcapng_read_packet_block: opt_comment %s", tp->data.section.opt_comment);
				}
				else
				{
					pcapng_debug1("pcapng_read_packet_block: opt_comment length %u seems strange", oh.option_length);
				}
				break;
			case (2):
				if (oh.option_length == 4)
				{
					memcpy(&tp->data.packet.pack_flags, option_content, sizeof(guint32));
					if (us->byte_swapped)
						wblock->data.packet.pack_flags = BSWAP32(tp->data.packet.pack_flags);
					pcapng_debug1("pcapng_read_if_descr_block: pack_flags %u (ignored)", tp->data.packet.pack_flags);
				}
				else
				{
					pcapng_debug1("pcapng_read_if_descr_block: pack_flags length %u not 4 as expected", oh.option_length);
				}
				break;
			default:
				pcapng_debug2("pcapng_read_packet_block: unknown option %u - ignoring %u bytes",
							  oh.option_code, oh.option_length);
			}
		}

		return block_read;
	}
