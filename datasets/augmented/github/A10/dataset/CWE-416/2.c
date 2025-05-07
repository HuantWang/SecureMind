void isor_reader_get_sample(ISOMChannel *ch)
{
	GF_Err e;
	Bool skip_sample = GF_FALSE;
	u32 sample_desc_index;
	if (ch->sample)
		return;

	if (ch->next_track)
	{
		ch->track = ch->next_track;
		if (!ch->owner->nodata)
			gf_isom_set_sample_alloc(ch->owner->mov, ch->track, isor_sample_alloc, ch);
		ch->next_track = 0;
	}

	if (ch->to_init)
	{
		if (!ch->owner->nodata)
			gf_isom_set_sample_alloc(ch->owner->mov, ch->track, isor_sample_alloc, ch);
		init_reader(ch);
		sample_desc_index = ch->last_sample_desc_index;
	}
	else if (ch->speed < 0)
	{
		if (ch->last_state == GF_EOS)
		{
			ch->sample = NULL;
			return;
		}

		if (ch->static_sample->IsRAP)
		{
			ch->last_rap_sample_time = ch->sample_time;
		}

		e = gf_isom_get_sample_for_movie_time(ch->owner->mov, ch->track, ch->sample_time + 1, &sample_desc_index, GF_ISOM_SEARCH_FORWARD, &ch->static_sample, &ch->sample_num, NULL);
		ch->static_sample->alloc_size = 0;

		if ((e == GF_EOS) || (ch->static_sample->IsRAP))
		{
			if (!ch->last_rap_sample_time)
			{
				e = GF_EOS;
			}
			else
			{
				e = gf_isom_get_sample_for_movie_time(ch->owner->mov, ch->track, ch->last_rap_sample_time - 1, &sample_desc_index, GF_ISOM_SEARCH_SYNC_BACKWARD, &ch->static_sample, &ch->sample_num, NULL);
				ch->static_sample->alloc_size = 0;
			}
		}

		if (e)
		{
			if ((e == GF_EOS) && !ch->owner->frag_type)
			{
				ch->last_state = GF_EOS;
			}
			ch->sample = NULL;
			return;
		}
		ch->sample = ch->static_sample;

		if (ch->sample->DTS == ch->sample_time)
		{
			if (!ch->owner->frag_type)
			{
				ch->last_state = GF_EOS;
			}
		}
		if (ch->sample)
		{
			ch->sample_time = ch->sample->DTS;
		}
	}
	else if (ch->has_edit_list)
	{
		u32 prev_sample = ch->sample_num;
		e = gf_isom_get_sample_for_movie_time(ch->owner->mov, ch->track, ch->sample_time + 1, &sample_desc_index, GF_ISOM_SEARCH_FORWARD, &ch->static_sample, &ch->sample_num, &ch->sample_data_offset);
		ch->static_sample->alloc_size = 0;

		if (e == GF_OK)
		{
			ch->sample = ch->static_sample;

			if (ch->edit_sync_frame)
			{
				ch->edit_sync_frame++;
				if (ch->edit_sync_frame < ch->sample_num)
				{
					ch->sample = gf_isom_get_sample_ex(ch->owner->mov, ch->track, ch->edit_sync_frame, &sample_desc_index, ch->static_sample, &ch->sample_data_offset);
					if (ch->sample)
					{
						ch->sample->DTS = ch->sample_time;
						ch->sample->CTS_Offset = 0;
					}
				}
				else
				{
					ch->edit_sync_frame = 0;
					if (ch->sample)
						ch->sample_time = ch->sample->DTS;
				}
			}
			else
			{
				if (prev_sample == ch->sample_num)
				{
					if (ch->owner->frag_type && (ch->sample_num == gf_isom_get_sample_count(ch->owner->mov, ch->track)))
					{
						ch->sample = NULL;
					}
					else
					{
						u32 sample_num = ch->sample_num ? ch->sample_num : 1;

						if (sample_num >= gf_isom_get_sample_count(ch->owner->mov, ch->track))
						{
						}
						else
						{
							u32 time_diff = gf_isom_get_sample_duration(ch->owner->mov, ch->track, sample_num);
							e = gf_isom_get_sample_for_movie_time(ch->owner->mov, ch->track, ch->sample_time + time_diff, &sample_desc_index, GF_ISOM_SEARCH_FORWARD, &ch->static_sample, &ch->sample_num, &ch->sample_data_offset);
							ch->static_sample->alloc_size = 0;
							if (e == GF_OK)
							{
								if (ch->sample_num == prev_sample)
								{
									ch->sample_time += time_diff;
									ch->sample = NULL;
									return;
								}
								else
								{
									ch->sample = ch->static_sample;
								}
							}
						}
					}
				}

				if (ch->sample && !ch->sample->IsRAP && ch->has_rap && (ch->sample_num != prev_sample + 1))
				{
					GF_ISOSample *found = ch->static_sample;
					u32 samp_num = ch->sample_num;
					ch->sample = NULL;
					e = gf_isom_get_sample_for_movie_time(ch->owner->mov, ch->track, ch->sample_time + 1, &sample_desc_index, GF_ISOM_SEARCH_SYNC_BACKWARD, &ch->static_sample, &ch->sample_num, &ch->sample_data_offset);

					ch->static_sample->alloc_size = 0;
					ch->sample = (e == GF_OK) ? ch->static_sample : NULL;

					/*if no sync point in the past, use the first non-sync for the given time*/
					if (!ch->sample || !ch->sample->data)
					{
						ch->sample = ch->static_sample = found;
						ch->sample_time = ch->sample->DTS;
						ch->sample_num = samp_num;
					}
					else
					{
						ch->sample = ch->static_sample;
						ch->edit_sync_frame = ch->sample_num;
						ch->sample->DTS = ch->sample_time;
						ch->sample->CTS_Offset = 0;
					}
				}
				else
				{
					if (ch->sample)
						ch->sample_time = ch->sample->DTS;
				}
			}
		}
	}
	else
	{
		Bool do_fetch = GF_TRUE;
		ch->sample_num++;
		if (ch->sample_last && (ch->sample_last < ch->sample_num))
		{
			ch->sample = NULL;
			ch->last_state = GF_EOS;
			ch->playing = 2;
			return;
		}

		if (ch->sap_only)
		{
			Bool is_rap = gf_isom_get_sample_sync(ch->owner->mov, ch->track, ch->sample_num);
			if (!is_rap)
			{
				GF_ISOSampleRollType roll_type;
				gf_isom_get_sample_rap_roll_info(ch->owner->mov, ch->track, ch->sample_num, &is_rap, &roll_type, NULL);
				if (roll_type)
					is_rap = GF_TRUE;
			}

			if (!is_rap)
			{
				do_fetch = GF_FALSE;
			}
			else if (ch->sap_only == 2)
			{
				ch->sap_only = 0;
			}
		}
		if (do_fetch)
		{
			if (ch->owner->nodata)
			{
				ch->sample = gf_isom_get_sample_info_ex(ch->owner->mov, ch->track, ch->sample_num, &sample_desc_index, &ch->sample_data_offset, ch->static_sample);
			}
			else
			{
				ch->sample = gf_isom_get_sample_ex(ch->owner->mov, ch->track, ch->sample_num, &sample_desc_index, ch->static_sample, &ch->sample_data_offset);
			}
			if (ch->sample && (ch->sample->IsRAP == RAP_REDUNDANT))
			{
				ch->sample = NULL;
				ch->sample_num++;
				if (ch->pck)
				{
					gf_filter_pck_discard(ch->pck);
					ch->pck = NULL;
				}
				isor_reader_get_sample(ch);
				return;
			}
		}
		else
		{
			skip_sample = GF_TRUE;
		}
	}

	if (ch->sample && ch->sample->IsRAP && ch->next_track)
	{
		ch->track = ch->next_track;
		ch->next_track = 0;
		ch->sample = NULL;
		if (ch->pck)
		{
			gf_filter_pck_discard(ch->pck);
			ch->pck = NULL;
		}
		isor_reader_get_sample(ch);
		return;
	}

	if (!ch->sample)
	{
		u32 sample_count = gf_isom_get_sample_count(ch->owner->mov, ch->track);
		ch->sample_data_offset = 0;
		if (gf_isom_get_missing_bytes(ch->owner->mov, ch->track))
		{
			ch->last_state = GF_ISOM_INCOMPLETE_FILE;
			if (ch->owner->mem_load_mode == 2)
				ch->owner->force_fetch = GF_TRUE;

			if (!ch->owner->input_loaded)
			{
				ch->last_state = GF_OK;
				if (!ch->has_edit_list && ch->sample_num)
					ch->sample_num--;
			}
			else
			{
				if (ch->to_init && ch->sample_num)
				{
					GF_LOG(GF_LOG_ERROR, GF_LOG_CONTAINER, ("[IsoMedia] Failed to fetch initial sample %d for track %d\n", ch->sample_num, ch->track));
					ch->last_state = GF_ISOM_INVALID_FILE;
				}
				else
				{
					if (!ch->eos_sent)
					{
						GF_LOG(GF_LOG_ERROR, GF_LOG_CONTAINER, ("[IsoMedia] File truncated, aborting read for track %d\n", ch->track));
					}
					ch->last_state = GF_EOS;
				}
			}
		}
		else if (!ch->sample_num || ((ch->speed >= 0) && (ch->sample_num >= sample_count))
#ifndef GPAC_DISABLE_ISOM_FRAGMENTS
				 || ((ch->speed < 0) && (ch->sample_time == gf_isom_get_current_tfdt(ch->owner->mov, ch->track)))
#endif
		)
		{

			if (ch->owner->frag_type == 1)
			{
				if (ch->sample_num)
					ch->sample_num--;
				ch->last_state = GF_EOS;
			}
			else if (ch->last_state != GF_EOS)
			{
				GF_LOG(GF_LOG_DEBUG, GF_LOG_CONTAINER, ("[IsoMedia] Track #%d end of stream reached\n", ch->track));
				ch->last_state = GF_EOS;
				if (ch->sample_num > sample_count)
					ch->sample_num = sample_count;
			}
			else
			{
				if (ch->sample_num > sample_count)
					ch->sample_num = sample_count;
			}
		}
		else if (!skip_sample)
		{
			e = gf_isom_last_error(ch->owner->mov);
			GF_LOG((e == GF_ISOM_INCOMPLETE_FILE) ? GF_LOG_DEBUG : GF_LOG_WARNING, GF_LOG_CONTAINER, ("[IsoMedia] Track #%d fail to fetch sample %d / %d: %s\n", ch->track, ch->sample_num, gf_isom_get_sample_count(ch->owner->mov, ch->track), gf_error_to_string(e)));

			if ((e < GF_OK) && (e != GF_ISOM_INCOMPLETE_FILE))
			{
				ch->last_state = GF_EOS;
			}
		}
		return;
	}

	if ((ch->sample_num == 1) && ch->hint_first_tfdt && ch->sample->DTS)
	{
		ch->hint_first_tfdt = 0;
	}
	ch->sample->DTS += ch->hint_first_tfdt;

	if (sample_desc_index != ch->last_sample_desc_index)
	{
		if (!ch->owner->stsd)
		{
			if (!ch->last_sample_desc_index && (sample_desc_index == 1))
			{
			}
			else
			{
				ch->needs_pid_reconfig = 1;
			}
		}
		ch->last_sample_desc_index = sample_desc_index;
	}

	ch->last_state = GF_OK;

	ch->sap_3 = GF_FALSE;
	ch->sap_4_type = 0;
	ch->roll = 0;

	if (ch->sample)
	{
		gf_isom_get_sample_rap_roll_info(ch->owner->mov, ch->track, ch->sample_num, &ch->sap_3, &ch->sap_4_type, &ch->roll);

		if ((ch->speed < 0) || (ch->start <= ch->sample->DTS + ch->sample->CTS_Offset))
		{
			ch->dts = ch->sample->DTS;
			ch->cts = ch->sample->DTS + ch->sample->CTS_Offset;
			ch->seek_flag = 0;
		}
		else
		{
			ch->cts = ch->start;
			ch->seek_flag = 1;
			ch->dts = ch->start;
		}

		if (ch->end && (ch->end < ch->sample->DTS + ch->sample->CTS_Offset + ch->sample->duration))
		{
			GF_LOG(GF_LOG_DEBUG, GF_LOG_CONTAINER, ("[IsoMedia] End of Channel " LLD " (CTS " LLD ")\n", ch->end, ch->sample->DTS + ch->sample->CTS_Offset));
			ch->sample = NULL;
			ch->last_state = GF_EOS;
			ch->playing = 2;
			return;
		}
	}

	if (ch->owner->last_sender_ntp && ch->cts == ch->owner->cts_for_last_sender_ntp)
	{
		ch->sender_ntp = ch->owner->last_sender_ntp;
		ch->ntp_at_server_ntp = ch->owner->ntp_at_last_sender_ntp;
	}
	else if (ch->owner->last_sender_ntp && ch->dts == ch->owner->cts_for_last_sender_ntp)
	{
		ch->sender_ntp = ch->owner->last_sender_ntp;
		ch->ntp_at_server_ntp = ch->owner->ntp_at_last_sender_ntp;
	}
	else
	{
		ch->sender_ntp = ch->ntp_at_server_ntp = 0;
	}

	if (!ch->sample_num)
		return;

	gf_isom_get_sample_flags(ch->owner->mov, ch->track, ch->sample_num, &ch->isLeading, &ch->dependsOn, &ch->dependedOn, &ch->redundant);

	if (ch->is_encrypted)
	{
		if (gf_isom_is_cenc_media(ch->owner->mov, ch->track, ch->last_sample_desc_index))
		{
			isor_update_cenc_info(ch, GF_FALSE);
		}
		else if (gf_isom_is_media_encrypted(ch->owner->mov, ch->track, ch->last_sample_desc_index))
		{
			ch->pck_encrypted = GF_TRUE;
		}
		else
		{
			ch->pck_encrypted = GF_FALSE;
		}
	}
	if (ch->sample && ch->sample->nb_pack)
		ch->sample_num += ch->sample->nb_pack - 1;
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
}
