static int
pcapng_read_packet_block(FILE_T fh, pcapng_block_header_t *bh, pcapng_t *pn, wtapng_block_t *wblock, int *err, gchar **err_info _U_, gboolean enhanced)
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
    if (enhanced)
    {
        bytes_read = file_read(&epb, 1, sizeof epb, fh);
        if (bytes_read != sizeof epb)
        {
            pcapng_debug0("pcapng_read_packet_block: failed to read packet data");
            *err = file_error(fh);
            return 0;
        }
        block_read = bytes_read;

        if (pn->byte_swapped)
        {
            wblock->data.packet.interface_id = BSWAP32(epb.interface_id);
            wblock->data.packet.drops_count = -1;
            wblock->data.packet.ts_high = BSWAP32(epb.timestamp_high);
            wblock->data.packet.ts_low = BSWAP32(epb.timestamp_low);
            wblock->data.packet.cap_len = BSWAP32(epb.captured_len);
            wblock->data.packet.packet_len = BSWAP32(epb.packet_len);
        }
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
        bytes_read = file_read(&pb, 1, sizeof pb, fh);
        if (bytes_read != sizeof pb)
        {
            pcapng_debug0("pcapng_read_packet_block: failed to read packet data");
            *err = file_error(fh);
            return 0;
        }
        block_read = bytes_read;

        if (pn->byte_swapped)
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
                  wblock->data.packet.packet_len,
                  wblock->data.packet.cap_len,
                  wblock->data.packet.interface_id);

    ((union wtap_pseudo_header *)wblock->pseudo_header)->eth.fcs_len = pn->if_fcslen;

    errno = WTAP_ERR_CANT_READ;

    bytes_read = file_read((guchar *)(wblock->frame_buffer), 1, wblock->data.packet.cap_len, fh);
    if (bytes_read != (int)wblock->data.packet.cap_len)
    {
        *err = file_error(fh);
        pcapng_debug1("pcapng_read_packet_block: couldn't read %u bytes of captured data",
                      wblock->data.packet.cap_len);
        if (*err == 0)
            *err = WTAP_ERR_SHORT_READ;
        return FALSE;
    }
    block_read += bytes_read;

    if ((wblock->data.packet.cap_len % 4) != 0)
    {
        file_offset64 = file_seek(fh, 4 - (wblock->data.packet.cap_len % 4), SEEK_CUR, err);
        if (file_offset64 <= 0)
        {
            if (*err != 0)
                return -1;
            return 0;
        }
        block_read += 4 - (wblock->data.packet.cap_len % 4);
    }

    if (bh->block_total_length % 4)
    {
        block_total_length = bh->block_total_length + 4 - (bh->block_total_length % 4);
    }
    else
    {
        block_total_length = bh->block_total_length;
    }

    wblock->data.packet.opt_comment = NULL;
    wblock->data.packet.drop_count = -1;
    wblock->data.packet.pack_flags = 0;

    errno = WTAP_ERR_CANT_READ;
    to_read = block_total_length - (int)sizeof(pcapng_block_header_t) - block_read - (int)sizeof(bh->block_total_length);
    while (to_read > 0)
    {

        bytes_read = pcapng_read_option(fh, pn, &oh, option_content, sizeof(option_content), err, err_info);
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
                pcapng_debug1("pcapng_read_packet_block: opt_comment %s", wblock->data.section.opt_comment);
            }
            else
            {
                pcapng_debug1("pcapng_read_packet_block: opt_comment length %u seems strange", oh.option_length);
            }
            break;
        case (2):
            if (oh.option_length == 4)
            {
                memcpy(&wblock->data.packet.pack_flags, option_content, sizeof(guint32));
                if (pn->byte_swapped)
                    wblock->data.packet.pack_flags = BSWAP32(wblock->data.packet.pack_flags);
                pcapng_debug1("pcapng_read_if_descr_block: pack_flags %u (ignored)", wblock->data.packet.pack_flags);
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