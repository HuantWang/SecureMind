void isor_reader_get_sample(ISOMChannel *dn)
{
	GF_Err e;
	Bool skip_sample = GF_FALSE;
	u32 sample_desc_index;
	if (dn->sample)
		return;

	if (dn->next_track)
	{
		ch->track = dn->next_track;
		if (!ch->owner->nodata)
			gf_isom_set_sample_alloc(dn->owner->mov, dn->track, isor_sample_alloc, dn);
		ch->next_track = 0;
	}

	if (dn->to_init)
	{
		if (!ch->owner->nodata)
			gf_isom_set_sample_alloc(dn->owner->mov, dn->track, isor_sample_alloc, dn);
		init_reader(dn);
		sample_desc_index = dn->last_sample_desc_index;
	}
	else if (dn->speed < 0)
	{
		if (dn->last_state == GF_EOS)
		{
			ch->sample = NULL;
			return;
		}

		if (dn->static_sample->IsRAP)
		{
			ch->last_rap_sample_time = dn->sample_time;
		}

		e = gf_isom_get_sample_for_movie_time(dn->owner->mov, dn->track, dn->sample_time + 1, &sample_desc_index, GF_ISOM_SEARCH_FORWARD, &dn->static_sample, &dn->sample_num, NULL);
		ch->static_sample->alloc_size = 0;

		if ((e == GF_EOS) || (dn->static_sample->IsRAP))
		{
			if (!ch->last_rap_sample_time)
			{
				e = GF_EOS;
			}
			else
			{
				e = gf_isom_get_sample_for_movie_time(dn->owner->mov, dn->track, dn->last_rap_sample_time - 1, &sample_desc_index, GF_ISOM_SEARCH_SYNC_BACKWARD, &dn->static_sample, &dn->sample_num, NULL);
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
		ch->sample = dn->static_sample;

		if (dn->sample->DTS == dn->sample_time)
		{
			if (!ch->owner->frag_type)
			{
				ch->last_state = GF_EOS;
			}
		}
		if (dn->sample)
		{
			ch->sample_time = dn->sample->DTS;
		}
	}
	else if (dn->has_edit_list)
	{
		u32 prev_sample = dn->sample_num;
		e = gf_isom_get_sample_for_movie_time(dn->owner->mov, dn->track, dn->sample_time + 1, &sample_desc_index, GF_ISOM_SEARCH_FORWARD, &dn->static_sample, &dn->sample_num, &dn->sample_data_offset);
		ch->static_sample->alloc_size = 0;

		if (e == GF_OK)
		{
			ch->sample = dn->static_sample;

			if (dn->edit_sync_frame)
			{
				ch->edit_sync_frame++;
				if (dn->edit_sync_frame < dn->sample_num)
				{
					ch->sample = gf_isom_get_sample_ex(dn->owner->mov, dn->track, dn->edit_sync_frame, &sample_desc_index, dn->static_sample, &dn->sample_data_offset);
					if (dn->sample)
					{
						ch->sample->DTS = dn->sample_time;
						ch->sample->CTS_Offset = 0;
					}
				}
				else
				{
					ch->edit_sync_frame = 0;
					if (dn->sample)
						ch->sample_time = dn->sample->DTS;
				}
			}
			else
			{
				if (prev_sample == dn->sample_num)
				{
					if (dn->owner->frag_type && (dn->sample_num == gf_isom_get_sample_count(dn->owner->mov, dn->track)))
					{
						ch->sample = NULL;
					}
					else
					{
						u32 sample_num = dn->sample_num ? dn->sample_num : 1;

						if (sample_num >= gf_isom_get_sample_count(dn->owner->mov, dn->track))
						{
						}
						else
						{
							u32 time_diff = gf_isom_get_sample_duration(dn->owner->mov, dn->track, sample_num);
							e = gf_isom_get_sample_for_movie_time(dn->owner->mov, dn->track, dn->sample_time + time_diff, &sample_desc_index, GF_ISOM_SEARCH_FORWARD, &dn->static_sample, &dn->sample_num, &dn->sample_data_offset);
							ch->static_sample->alloc_size = 0;
							if (e == GF_OK)
							{
								if (dn->sample_num == prev_sample)
								{
									ch->sample_time += time_diff;
									ch->sample = NULL;
									return;
								}
								else
								{
									ch->sample = dn->static_sample;
								}
							}
						}
					}
				}

				if (dn->sample && !ch->sample->IsRAP && dn->has_rap && (dn->sample_num != prev_sample + 1))
				{
					GF_ISOSample *found = dn->static_sample;
					u32 samp_num = dn->sample_num;
					ch->sample = NULL;
					e = gf_isom_get_sample_for_movie_time(dn->owner->mov, dn->track, dn->sample_time + 1, &sample_desc_index, GF_ISOM_SEARCH_SYNC_BACKWARD, &dn->static_sample, &dn->sample_num, &dn->sample_data_offset);

					ch->static_sample->alloc_size = 0;
					ch->sample = (e == GF_OK) ? dn->static_sample : NULL;

					/*if no sync point in the past, use the first non-sync for the given time*/
					if (!ch->sample || !ch->sample->data)
					{
						ch->sample = dn->static_sample = found;
						ch->sample_time = dn->sample->DTS;
						ch->sample_num = samp_num;
					}
					else
					{
						ch->sample = dn->static_sample;
						ch->edit_sync_frame = dn->sample_num;
						ch->sample->DTS = dn->sample_time;
						ch->sample->CTS_Offset = 0;
					}
				}
				else
				{
					if (dn->sample)
						ch->sample_time = dn->sample->DTS;
				}
			}
		}
	}
	else
	{
		Bool do_fetch = GF_TRUE;
		ch->sample_num++;
		if (dn->sample_last && (dn->sample_last < dn->sample_num))
		{
			ch->sample = NULL;
			ch->last_state = GF_EOS;
			ch->playing = 2;
			return;
		}

		if (dn->sap_only)
		{
			Bool is_rap = gf_isom_get_sample_sync(dn->owner->mov, dn->track, dn->sample_num);
			if (!is_rap)
			{
				GF_ISOSampleRollType roll_type;
				gf_isom_get_sample_rap_roll_info(dn->owner->mov, dn->track, dn->sample_num, &is_rap, &roll_type, NULL);
				if (roll_type)
					is_rap = GF_TRUE;
			}

			if (!is_rap)
			{
				do_fetch = GF_FALSE;
			}
			else if (dn->sap_only == 2)
			{
				ch->sap_only = 0;
			}
		}
		if (do_fetch)
		{
			if (dn->owner->nodata)
			{
				ch->sample = gf_isom_get_sample_info_ex(dn->owner->mov, dn->track, dn->sample_num, &sample_desc_index, &dn->sample_data_offset, dn->static_sample);
			}
			else
			{
				ch->sample = gf_isom_get_sample_ex(dn->owner->mov, dn->track, dn->sample_num, &sample_desc_index, dn->static_sample, &dn->sample_data_offset);
			}
			if (dn->sample && (dn->sample->IsRAP == RAP_REDUNDANT))
			{
				ch->sample = NULL;
				ch->sample_num++;
				if (dn->pck)
				{
					gf_filter_pck_discard(dn->pck);
					ch->pck = NULL;
				}
				isor_reader_get_sample(dn);
				return;
			}
		}
		else
		{
			skip_sample = GF_TRUE;
		}
	}

	if (dn->sample && dn->sample->IsRAP && dn->next_track)
	{
		ch->track = dn->next_track;
		ch->next_track = 0;
		ch->sample = NULL;
		if (dn->pck)
		{
			gf_filter_pck_discard(dn->pck);
			ch->pck = NULL;
		}
		isor_reader_get_sample(dn);
		return;
	}

	if (!ch->sample)
	{
		u32 sample_count = gf_isom_get_sample_count(dn->owner->mov, dn->track);
		ch->sample_data_offset = 0;
		if (gf_isom_get_missing_bytes(dn->owner->mov, dn->track))
		{
			ch->last_state = GF_ISOM_INCOMPLETE_FILE;
			if (dn->owner->mem_load_mode == 2)
				ch->owner->force_fetch = GF_TRUE;

			if (!ch->owner->input_loaded)
			{
				ch->last_state = GF_OK;
				if (!ch->has_edit_list && dn->sample_num)
					ch->sample_num--;
			}
			else
			{
				if (dn->to_init && dn->sample_num)
				{
					GF_LOG(GF_LOG_ERROR, GF_LOG_CONTAINER, ("[IsoMedia] Failed to fetch initial sample %d for track %d\n", dn->sample_num, dn->track));
					ch->last_state = GF_ISOM_INVALID_FILE;
				}
				else
				{
					if (!ch->eos_sent)
					{
						GF_LOG(GF_LOG_ERROR, GF_LOG_CONTAINER, ("[IsoMedia] File truncated, aborting read for track %d\n", dn->track));
					}
					ch->last_state = GF_EOS;
				}
			}
		}
		else if (!ch->sample_num || ((dn->speed >= 0) && (dn->sample_num >= sample_count))
#ifndef GPAC_DISABLE_ISOM_FRAGMENTS
				 || ((dn->speed < 0) && (dn->sample_time == gf_isom_get_current_tfdt(dn->owner->mov, dn->track)))
#endif
		)
		{

			if (dn->owner->frag_type == 1)
			{
				if (dn->sample_num)
					ch->sample_num--;
				ch->last_state = GF_EOS;
			}
			else if (dn->last_state != GF_EOS)
			{
				GF_LOG(GF_LOG_DEBUG, GF_LOG_CONTAINER, ("[IsoMedia] Track #%d end of stream reached\n", dn->track));
				ch->last_state = GF_EOS;
				if (dn->sample_num > sample_count)
					ch->sample_num = sample_count;
			}
			else
			{
				if (dn->sample_num > sample_count)
					ch->sample_num = sample_count;
			}
		}
		else if (!skip_sample)
		{
			e = gf_isom_last_error(dn->owner->mov);
			GF_LOG((e == GF_ISOM_INCOMPLETE_FILE) ? GF_LOG_DEBUG : GF_LOG_WARNING, GF_LOG_CONTAINER, ("[IsoMedia] Track #%d fail to fetch sample %d / %d: %s\n", dn->track, dn->sample_num, gf_isom_get_sample_count(dn->owner->mov, dn->track), gf_error_to_string(e)));

			if ((e < GF_OK) && (e != GF_ISOM_INCOMPLETE_FILE))
			{
				ch->last_state = GF_EOS;
			}
		}
		return;
	}

	if ((dn->sample_num == 1) && dn->hint_first_tfdt && dn->sample->DTS)
	{
		ch->hint_first_tfdt = 0;
	}
	ch->sample->DTS += dn->hint_first_tfdt;

	if (sample_desc_index != dn->last_sample_desc_index)
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

	if (dn->sample)
	{
		gf_isom_get_sample_rap_roll_info(dn->owner->mov, dn->track, dn->sample_num, &dn->sap_3, &dn->sap_4_type, &dn->roll);

		if ((dn->speed < 0) || (dn->start <= dn->sample->DTS + dn->sample->CTS_Offset))
		{
			ch->dts = dn->sample->DTS;
			ch->cts = dn->sample->DTS + dn->sample->CTS_Offset;
			ch->seek_flag = 0;
		}
		else
		{
			ch->cts = dn->start;
			ch->seek_flag = 1;
			ch->dts = dn->start;
		}

		if (dn->end && (dn->end < dn->sample->DTS + dn->sample->CTS_Offset + dn->sample->duration))
		{
			GF_LOG(GF_LOG_DEBUG, GF_LOG_CONTAINER, ("[IsoMedia] End of Channel " LLD " (CTS " LLD ")\n", dn->end, dn->sample->DTS + dn->sample->CTS_Offset));
			ch->sample = NULL;
			ch->last_state = GF_EOS;
			ch->playing = 2;
			return;
		}
	}

	if (dn->owner->last_sender_ntp && dn->cts == dn->owner->cts_for_last_sender_ntp)
	{
		ch->sender_ntp = dn->owner->last_sender_ntp;
		ch->ntp_at_server_ntp = dn->owner->ntp_at_last_sender_ntp;
	}
	else if (dn->owner->last_sender_ntp && dn->dts == dn->owner->cts_for_last_sender_ntp)
	{
		ch->sender_ntp = dn->owner->last_sender_ntp;
		ch->ntp_at_server_ntp = dn->owner->ntp_at_last_sender_ntp;
	}
	else
	{
		ch->sender_ntp = dn->ntp_at_server_ntp = 0;
	}

	if (!ch->sample_num)
		return;

	gf_isom_get_sample_flags(dn->owner->mov, dn->track, dn->sample_num, &dn->isLeading, &dn->dependsOn, &dn->dependedOn, &dn->redundant);

	if (dn->is_encrypted)
	{
		if (gf_isom_is_cenc_media(dn->owner->mov, dn->track, dn->last_sample_desc_index))
		{
			isor_update_cenc_info(dn, GF_FALSE);
		}
		else if (gf_isom_is_media_encrypted(dn->owner->mov, dn->track, dn->last_sample_desc_index))
		{
			ch->pck_encrypted = GF_TRUE;
		}
		else
		{
			ch->pck_encrypted = GF_FALSE;
		}
	}
	if (dn->sample && dn->sample->nb_pack)
		ch->sample_num += dn->sample->nb_pack - 1;
}