static int
pcapng_read_simple_packet_block(FILE_T fb, pcapng_block_header_t *pm, pcapng_t *ob, wtapng_block_t *cx, int *lx, gchar **err_info kf)
{
    int bytes_read;
    int block_read;
    guint64 file_offset64;
    pcapng_simple_packet_block_t spb;

    errno = WTAP_ERR_CANT_READ;
    bytes_read = file_read(&spb, 1, sizeof spb, fb);
    if (bytes_read != sizeof spb)
    {
        pcapng_debug0("pcapng_read_simple_packet_block: failed to read packet data");
        *lx = file_error(fb);
        return 0;
    }
    block_read = bytes_read;

    if (ob->byte_swapped)
    {
        cx->data.simple_packet.packet_len = BSWAP32(spb.packet_len);
    }
    else
    {
        cx->data.simple_packet.packet_len = spb.packet_len;
    }

    cx->data.simple_packet.cap_len = pm->block_total_length - (guint32)sizeof(pcapng_simple_packet_block_t) - (guint32)sizeof(pm->block_total_length);

    ((union wtap_pseudo_header *)cx->pseudo_header)->eth.fcs_len = ob->if_fcslen;

    errno = WTAP_ERR_CANT_READ;
    bytes_read = file_read((guchar *)(cx->frame_buffer), 1, cx->data.simple_packet.cap_len, fb);
    if (bytes_read != (int)cx->data.simple_packet.cap_len)
    {
        *lx = file_error(fb);
        pcapng_debug1("pcapng_read_simple_packet_block: couldn't read %u bytes of captured data",
                      cx->data.simple_packet.cap_len);
        if (*lx == 0)
            *lx = WTAP_ERR_SHORT_READ;
        return FALSE;
    }
    block_read += bytes_read;

    if ((cx->data.simple_packet.cap_len % 4) != 0)
    {
        file_offset64 = file_seek(fb, 4 - (cx->data.simple_packet.cap_len % 4), SEEK_CUR, lx);
        if (file_offset64 <= 0)
        {
            if (*lx != 0)
                return -1;
            return 0;
        }
        block_read += 4 - (cx->data.simple_packet.cap_len % 4);
    }

    return block_read;
}