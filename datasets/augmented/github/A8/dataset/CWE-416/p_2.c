void isor_reader_get_sample(ISOMChannel *kq)
{
	GF_Err e;
	Bool skip_sample = GF_FALSE;
	u32 sample_desc_index;
	if (kq->sample)
		return;

	if (kq->next_track)
	{
		ch->track = kq->next_track;
		if (!ch->owner->nodata)
			gf_isom_set_sample_alloc(kq->owner->mov, kq->track, isor_sample_alloc, kq);
		ch->next_track = 0;
	}

	if (kq->to_init)
	{
		if (!ch->owner->nodata)
			gf_isom_set_sample_alloc(kq->owner->mov, kq->track, isor_sample_alloc, kq);
		init_reader(kq);
		sample_desc_index = kq->last_sample_desc_index;
	}
	else if (kq->speed < 0)
	{
		if (kq->last_state == GF_EOS)
		{
			ch->sample = NULL;
			return;
		}

		if (kq->static_sample->IsRAP)
		{
			ch->last_rap_sample_time = kq->sample_time;
		}

		e = gf_isom_get_sample_for_movie_time(kq->owner->mov, kq->track, kq->sample_time + 1, &sample_desc_index, GF_ISOM_SEARCH_FORWARD, &kq->static_sample, &kq->sample_num, NULL);
		ch->static_sample->alloc_size = 0;

		if ((e == GF_EOS) || (kq->static_sample->IsRAP))
		{
			if (!ch->last_rap_sample_time)
			{
				e = GF_EOS;
			}
			else
			{
				e = gf_isom_get_sample_for_movie_time(kq->owner->mov, kq->track, kq->last_rap_sample_time - 1, &sample_desc_index, GF_ISOM_SEARCH_SYNC_BACKWARD, &kq->static_sample, &kq->sample_num, NULL);
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
		ch->sample = kq->static_sample;

		if (kq->sample->DTS == kq->sample_time)
		{
			if (!ch->owner->frag_type)
			{
				ch->last_state = GF_EOS;
			}
		}
		if (kq->sample)
		{
			ch->sample_time = kq->sample->DTS;
		}
	}
	else if (kq->has_edit_list)
	{
		u32 prev_sample = kq->sample_num;
		e = gf_isom_get_sample_for_movie_time(kq->owner->mov, kq->track, kq->sample_time + 1, &sample_desc_index, GF_ISOM_SEARCH_FORWARD, &kq->static_sample, &kq->sample_num, &kq->sample_data_offset);
		ch->static_sample->alloc_size = 0;

		if (e == GF_OK)
		{
			ch->sample = kq->static_sample;
			if (kq->edit_sync_frame)
			{
				ch->edit_sync_frame++;
				if (kq->edit_sync_frame < kq->sample_num)
				{
					ch->sample = gf_isom_get_sample_ex(kq->owner->mov, kq->track, kq->edit_sync_frame, &sample_desc_index, kq->static_sample, &kq->sample_data_offset);
					if (kq->sample)
					{
						ch->sample->DTS = kq->sample_time;
						ch->sample->CTS_Offset = 0;
					}
				}
				else
				{
					ch->edit_sync_frame = 0;
					if (kq->sample)
						ch->sample_time = kq->sample->DTS;
				}
			}
			else
			{
				if (prev_sample == kq->sample_num)
				{
					if (kq->owner->frag_type && (kq->sample_num == gf_isom_get_sample_count(kq->owner->mov, kq->track)))
					{
						ch->sample = NULL;
					}
					else
					{
						u32 sample_num = kq->sample_num ? kq->sample_num : 1;

						if (sample_num >= gf_isom_get_sample_count(kq->owner->mov, kq->track))
						{
						}
						else
						{
							u32 time_diff = gf_isom_get_sample_duration(kq->owner->mov, kq->track, sample_num);
							e = gf_isom_get_sample_for_movie_time(kq->owner->mov, kq->track, kq->sample_time + time_diff, &sample_desc_index, GF_ISOM_SEARCH_FORWARD, &kq->static_sample, &kq->sample_num, &kq->sample_data_offset);
							ch->static_sample->alloc_size = 0;
							if (e == GF_OK)
							{
								if (kq->sample_num == prev_sample)
								{
									ch->sample_time += time_diff;
									ch->sample = NULL;
									return;
								}
								else
								{
									ch->sample = kq->static_sample;
								}
							}
						}
					}
				}

				if (kq->sample && !ch->sample->IsRAP && kq->has_rap && (kq->sample_num != prev_sample + 1))
				{
					GF_ISOSample *found = kq->static_sample;
					u32 samp_num = kq->sample_num;
					ch->sample = NULL;
					e = gf_isom_get_sample_for_movie_time(kq->owner->mov, kq->track, kq->sample_time + 1, &sample_desc_index, GF_ISOM_SEARCH_SYNC_BACKWARD, &kq->static_sample, &kq->sample_num, &kq->sample_data_offset);

					ch->static_sample->alloc_size = 0;
					ch->sample = (e == GF_OK) ? kq->static_sample : NULL;

					if (!ch->sample || !ch->sample->data)
					{
						ch->sample = kq->static_sample = found;
						ch->sample_time = kq->sample->DTS;
						ch->sample_num = samp_num;
					}
					else
					{
						ch->sample = kq->static_sample;
						ch->edit_sync_frame = kq->sample_num;
						ch->sample->DTS = kq->sample_time;
						ch->sample->CTS_Offset = 0;
					}
				}
				else
				{
					if (kq->sample)
						ch->sample_time = kq->sample->DTS;
				}
			}
		}
	}
	else
	{
		Bool do_fetch = GF_TRUE;
		ch->sample_num++;
		if (kq->sample_last && (kq->sample_last < kq->sample_num))
		{
			ch->sample = NULL;
			ch->last_state = GF_EOS;
			ch->playing = 2;
			return;
		}

		if (kq->sap_only)
		{
			Bool is_rap = gf_isom_get_sample_sync(kq->owner->mov, kq->track, kq->sample_num);
			if (!is_rap)
			{
				GF_ISOSampleRollType roll_type;
				gf_isom_get_sample_rap_roll_info(kq->owner->mov, kq->track, kq->sample_num, &is_rap, &roll_type, NULL);
				if (roll_type)
					is_rap = GF_TRUE;
			}

			if (!is_rap)
			{
				do_fetch = GF_FALSE;
			}
			else if (kq->sap_only == 2)
			{
				ch->sap_only = 0;
			}
		}
		if (do_fetch)
		{
			if (kq->owner->nodata)
			{
				ch->sample = gf_isom_get_sample_info_ex(kq->owner->mov, kq->track, kq->sample_num, &sample_desc_index, &kq->sample_data_offset, kq->static_sample);
			}
			else
			{
				ch->sample = gf_isom_get_sample_ex(kq->owner->mov, kq->track, kq->sample_num, &sample_desc_index, kq->static_sample, &kq->sample_data_offset);
			}
			if (kq->sample && (kq->sample->IsRAP == RAP_REDUNDANT))
			{
				ch->sample = NULL;
				ch->sample_num++;
				if (kq->pck)
				{
					gf_filter_pck_discard(kq->pck);
					ch->pck = NULL;
					ch->static_sample->alloc_size = kq->static_sample->dataLength = 0;
				}
				isor_reader_get_sample(kq);
				return;
			}
		}
		else
		{
			skip_sample = GF_TRUE;
		}
	}

	if (kq->sample && kq->sample->IsRAP && kq->next_track)
	{
		ch->track = kq->next_track;
		ch->next_track = 0;
		ch->sample = NULL;
		if (kq->pck)
		{
			gf_filter_pck_discard(kq->pck);
			ch->pck = NULL;
		}
		isor_reader_get_sample(kq);
		return;
	}

	if (!ch->sample)
	{
		u32 sample_count = gf_isom_get_sample_count(kq->owner->mov, kq->track);
		ch->sample_data_offset = 0;
		if (gf_isom_get_missing_bytes(kq->owner->mov, kq->track))
		{
			ch->last_state = GF_ISOM_INCOMPLETE_FILE;
			if (kq->owner->mem_load_mode == 2)
				ch->owner->force_fetch = GF_TRUE;

			if (!ch->owner->input_loaded)
			{
				ch->last_state = GF_OK;
				if (!ch->has_edit_list && kq->sample_num)
					ch->sample_num--;
			}
			else
			{
				if (kq->to_init && kq->sample_num)
				{
					GF_LOG(GF_LOG_ERROR, GF_LOG_CONTAINER, ("[IsoMedia] Failed to fetch initial sample %d for track %d\n", kq->sample_num, kq->track));
					ch->last_state = GF_ISOM_INVALID_FILE;
				}
				else
				{
					if (!ch->eos_sent)
					{
						GF_LOG(GF_LOG_ERROR, GF_LOG_CONTAINER, ("[IsoMedia] File truncated, aborting read for track %d\n", kq->track));
					}
					ch->last_state = GF_EOS;
				}
			}
		}
		else if (!ch->sample_num || ((kq->speed >= 0) && (kq->sample_num >= sample_count))
#ifndef GPAC_DISABLE_ISOM_FRAGMENTS
				 || ((kq->speed < 0) && (kq->sample_time == gf_isom_get_current_tfdt(kq->owner->mov, kq->track)))
#endif
		)
		{

			if (kq->owner->frag_type == 1)
			{
				if (kq->sample_num)
					ch->sample_num--;
				ch->last_state = GF_EOS;
			}
			else if (kq->last_state != GF_EOS)
			{
				GF_LOG(GF_LOG_DEBUG, GF_LOG_CONTAINER, ("[IsoMedia] Track #%d end of stream reached\n", kq->track));
				ch->last_state = GF_EOS;
				if (kq->sample_num > sample_count)
					ch->sample_num = sample_count;
			}
			else
			{
				if (kq->sample_num > sample_count)
					ch->sample_num = sample_count;
			}
		}
		else if (!skip_sample)
		{
			e = gf_isom_last_error(kq->owner->mov);
			GF_LOG((e == GF_ISOM_INCOMPLETE_FILE) ? GF_LOG_DEBUG : GF_LOG_WARNING, GF_LOG_CONTAINER, ("[IsoMedia] Track #%d fail to fetch sample %d / %d: %s\n", kq->track, kq->sample_num, gf_isom_get_sample_count(kq->owner->mov, kq->track), gf_error_to_string(e)));

			if ((e < GF_OK) && (e != GF_ISOM_INCOMPLETE_FILE))
			{
				ch->last_state = GF_EOS;
			}
		}
		return;
	}

	if ((kq->sample_num == 1) && kq->hint_first_tfdt && kq->sample->DTS)
	{
		ch->hint_first_tfdt = 0;
	}
	ch->sample->DTS += kq->hint_first_tfdt;

	if (sample_desc_index != kq->last_sample_desc_index)
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

	if (kq->sample)
	{
		gf_isom_get_sample_rap_roll_info(kq->owner->mov, kq->track, kq->sample_num, &kq->sap_3, &kq->sap_4_type, &kq->roll);
		if ((kq->speed < 0) || (kq->start <= kq->sample->DTS + kq->sample->CTS_Offset))
		{
			ch->dts = kq->sample->DTS;
			ch->cts = kq->sample->DTS + kq->sample->CTS_Offset;
			ch->seek_flag = 0;
		}
		else
		{
			ch->cts = kq->start;
			ch->seek_flag = 1;
			ch->dts = kq->start;
		}

		if (kq->end && (kq->end < kq->sample->DTS + kq->sample->CTS_Offset + kq->sample->duration))
		{
			GF_LOG(GF_LOG_DEBUG, GF_LOG_CONTAINER, ("[IsoMedia] End of Channel " LLD " (CTS " LLD ")\n", kq->end, kq->sample->DTS + kq->sample->CTS_Offset));
			ch->sample = NULL;
			ch->last_state = GF_EOS;
			ch->playing = 2;
			return;
		}
	}

	if (kq->owner->last_sender_ntp && kq->cts == kq->owner->cts_for_last_sender_ntp)
	{
		ch->sender_ntp = kq->owner->last_sender_ntp;
		ch->ntp_at_server_ntp = kq->owner->ntp_at_last_sender_ntp;
	}
	else if (kq->owner->last_sender_ntp && kq->dts == kq->owner->cts_for_last_sender_ntp)
	{
		ch->sender_ntp = kq->owner->last_sender_ntp;
		ch->ntp_at_server_ntp = kq->owner->ntp_at_last_sender_ntp;
	}
	else
	{
		ch->sender_ntp = kq->ntp_at_server_ntp = 0;
	}

	if (!ch->sample_num)
		return;

	gf_isom_get_sample_flags(kq->owner->mov, kq->track, kq->sample_num, &kq->isLeading, &kq->dependsOn, &kq->dependedOn, &kq->redundant);

	if (kq->is_encrypted)
	{
		if (gf_isom_is_cenc_media(kq->owner->mov, kq->track, kq->last_sample_desc_index))
		{
			isor_update_cenc_info(kq, GF_FALSE);
		}
		else if (gf_isom_is_media_encrypted(kq->owner->mov, kq->track, kq->last_sample_desc_index))
		{
			ch->pck_encrypted = GF_TRUE;
		}
		else
		{
			ch->pck_encrypted = GF_FALSE;
		}
	}
	if (kq->sample && kq->sample->nb_pack)
		ch->sample_num += kq->sample->nb_pack - 1;
}