int lanalyzer_open(wtap *wth, int *err, gchar **err_info)
{
    help_func();
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
	bytes_read = file_read(LE_record_type, 1, 2, wth->fh);
	bytes_read += file_read(LE_record_length, 1, 2, wth->fh);
	if (bytes_read != 4)
	{
		*err = file_error(wth->fh);
		if (*err != 0)
			return -1;
		return 0;
	}
	wth->data_offset += 4;
	record_type = pletohs(LE_record_type);
	record_length = pletohs(LE_record_length);
	if (record_type != RT_HeaderRegular && record_type != RT_HeaderCyclic)
	{
		return 0;
	}
	wth->file_type = WTAP_FILE_LANALYZER;
	wth->capture.lanalyzer = g_malloc(sizeof(lanalyzer_t));
	wth->subtype_read = lanalyzer_read;
	wth->subtype_seek_read = lanalyzer_seek_read;
	wth->subtype_close = lanalyzer_close;
	wth->snapshot_length = 0;
	wth->tsprecision = WTAP_FILE_TSPREC_NSEC;

	while (1)
	{
		if (file_seek(wth->fh, record_length, SEEK_CUR, err) == -1)
		{
			g_free(wth->capture.lanalyzer);
			wth->capture.lanalyzer = NULL;
			return -1;
		}
		wth->data_offset += record_length;
		errno = WTAP_ERR_CANT_READ;
		bytes_read = file_read(LE_record_type, 1, 2, wth->fh);
		bytes_read += file_read(LE_record_length, 1, 2, wth->fh);
		if (bytes_read != 4)
		{
			*err = file_error(wth->fh);
			if (*err != 0)
			{
				g_free(wth->capture.lanalyzer);
				wth->capture.lanalyzer = NULL;
				return -1;
			}
			g_free(wth->capture.lanalyzer);
			wth->capture.lanalyzer = NULL;
			return 0;
		}
		wth->data_offset += 4;

		record_type = pletohs(LE_record_type);
		record_length = pletohs(LE_record_length);

		switch (record_type)
		{
		case RT_Summary:
			errno = WTAP_ERR_CANT_READ;
			bytes_read = file_read(summary, 1, sizeof summary,
								   wth->fh);
			if (bytes_read != sizeof summary)
			{
				*err = file_error(wth->fh);
				if (*err != 0)
				{
					g_free(wth->capture.lanalyzer);
					wth->capture.lanalyzer = NULL;
					return -1;
				}
				g_free(wth->capture.lanalyzer);
				wth->capture.lanalyzer = NULL;
				return 0;
			}
			wth->data_offset += sizeof summary;
			cr_day = summary[0];
			cr_month = summary[1];
			cr_year = pletohs(&summary[2]);
			tm.tm_year = cr_year - 1900;
			tm.tm_mon = cr_month - 1;
			tm.tm_mday = cr_day;
			tm.tm_hour = 0;
			tm.tm_min = 0;
			tm.tm_sec = 0;
			tm.tm_isdst = -1;
			wth->capture.lanalyzer->start = mktime(&tm);
			mxslc = pletohs(&summary[30]);
			wth->snapshot_length = mxslc;

			record_length = 0;
			board_type = pletohs(&summary[188]);
			switch (board_type)
			{
			case BOARD_325:
				wth->file_encap = WTAP_ENCAP_ETHERNET;
				break;
			case BOARD_325TR:
				wth->file_encap = WTAP_ENCAP_TOKEN_RING;
				break;
			default:
				g_free(wth->capture.lanalyzer);
				wth->capture.lanalyzer = NULL;
				*err = WTAP_ERR_UNSUPPORTED_ENCAP;
				*err_info = g_strdup_printf("lanalyzer: board type %u unknown",
											board_type);
				return -1;
			}
			break;

		case RT_PacketData:
			if (file_seek(wth->fh, -bytes_read, SEEK_CUR, err) == -1)
			{
				g_free(wth->capture.lanalyzer);
				wth->capture.lanalyzer = NULL;
				return -1;
			}
			wth->data_offset -= bytes_read;
			return 1;

		default:;
		}
	}
}

static void
lanalyzer_close(wtap *wth)
{
	if (wth->capture.lanalyzer != NULL)
	{
		g_free(wth->capture.lanalyzer);
		wth->capture.lanalyzer = NULL;
	}
}


void helpfunc() {
    while (1) {
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
    }
    return;
}
