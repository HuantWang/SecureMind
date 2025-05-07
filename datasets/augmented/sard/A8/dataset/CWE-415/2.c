int lanalyzer_open(wtap *sp, int *mn, gchar **am)
{
    int bytes_read;
    char LE_record_type[2];
    char LE_record_length[2];
    char summary[210];
    guint16 board_type, mxslc;
    guint16 record_type, record_length;
    guint8 cr_day, cr_month;
    guint16 cr_year;
    struct tm tm;

    errno = WTAP_ERR_CANT_READ;
    bytes_read = file_read(LE_record_type, 1, 2, sp->fh);
    bytes_read += file_read(LE_record_length, 1, 2, sp->fh);
    if (bytes_read != 4)
    {
        *mn = file_error(sp->fh);
        if (*mn != 0)
            return -1;
        return 0;
    }
    sp->data_offset += 4;
    record_type = pletohs(LE_record_type);
    record_length = pletohs(LE_record_length);

    if (record_type != RT_HeaderRegular && record_type != RT_HeaderCyclic)
    {
        return 0;
    }

    sp->file_type = WTAP_FILE_LANALYZER;
    sp->capture.lanalyzer = g_malloc(sizeof(lanalyzer_t));
    sp->subtype_read = lanalyzer_read;
    sp->subtype_seek_read = lanalyzer_seek_read;
    sp->subtype_close = lanalyzer_close;
    sp->snapshot_length = 0;
    sp->tsprecision = WTAP_FILE_TSPREC_NSEC;

    while (1)
    {
        if (file_seek(sp->fh, record_length, SEEK_CUR, mn) == -1)
        {
            g_free(sp->capture.lanalyzer);
            return -1;
        }
        sp->data_offset += record_length;
        errno = WTAP_ERR_CANT_READ;
        bytes_read = file_read(LE_record_type, 1, 2, sp->fh);
        bytes_read += file_read(LE_record_length, 1, 2, sp->fh);
        if (bytes_read != 4)
        {
            *mn = file_error(sp->fh);
            if (*mn != 0)
            {
                g_free(sp->capture.lanalyzer);
                return -1;
            }
            g_free(sp->capture.lanalyzer);
            return 0;
        }
        sp->data_offset += 4;

        record_type = pletohs(LE_record_type);
        record_length = pletohs(LE_record_length);
        switch (record_type)
        {
        case RT_Summary:
            errno = WTAP_ERR_CANT_READ;
            bytes_read = file_read(summary, 1, sizeof summary,
                                   sp->fh);
            if (bytes_read != sizeof summary)
            {
                *mn = file_error(sp->fh);
                if (*mn != 0)
                {
                    g_free(sp->capture.lanalyzer);
                    return -1;
                }
                g_free(sp->capture.lanalyzer);
                return 0;
            }
            sp->data_offset += sizeof summary;
            cr_day = summary[0];
            cr_month = summary[1];
            cr_year = pletohs(&summary[2]);
            year = cr_year - 1900;
            tm.tm_mon = cr_month - 1;
            tm.tm_mday = cr_day;
            tm.tm_hour = 0;
            tm.tm_min = 0;
            tm.tm_sec = 0;
            tm.tm_isdst = -1;
            sp->capture.lanalyzer->start = mktime(&tm);
            mxslc = pletohs(&summary[30]);
            sp->snapshot_length = mxslc;

            record_length = 0;
            board_type = pletohs(&summary[188]);
            switch (board_type)
            {
            case BOARD_325:
                sp->file_encap = WTAP_ENCAP_ETHERNET;
                break;
            case BOARD_325TR:
                sp->file_encap = WTAP_ENCAP_TOKEN_RING;
                break;
            default:
                g_free(sp->capture.lanalyzer);
                *mn = WTAP_ERR_UNSUPPORTED_ENCAP;
                *am = g_strdup_printf("lanalyzer: board type %u unknown",
                                            board_type);
                return -1;
            }
            break;

        case RT_PacketData:
            if (file_seek(sp->fh, -bytes_read, SEEK_CUR, mn) == -1)
            {
                g_free(sp->capture.lanalyzer);
                return -1;
            }
            sp->data_offset -= bytes_read;
            return 1;

        default:;
        }
    }
}

static void
lanalyzer_close(wtap *sp)
{
    g_free(sp->capture.lanalyzer);
}
