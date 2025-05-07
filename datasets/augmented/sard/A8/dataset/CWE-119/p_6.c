static void dissect_i_frame(tvbuff_t *ts, packet_info *lq, proto_tree *bc, proto_tree *tu, psm_data_t *cq, guint16 ql, int wi, config_data_t *pe)
{
	tvbuff_t *next_tvb = NULL;
	guint16 control, segment;
	guint16 sdulen;
	proto_item *ti_control;
	proto_tree *ti_control_subtree;
	sdu_reassembly_t *mfp = NULL;
	guint16 psm = (cq ? cq->psm : 0);

	control = tvb_get_letohs(ts, wi);
	segment = (control & 0xC000) >> 14;
	if (check_col(lq->cinfo, COL_INFO))
	{
		switch (segment)
		{
		case 0:
			col_append_str(lq->cinfo, COL_INFO, "[I] Unsegmented SDU");
			break;
		case 1:
			col_append_str(lq->cinfo, COL_INFO, "[I] Start SDU");
			break;
		case 2:
			col_append_str(lq->cinfo, COL_INFO, "[I] End SDU");
			break;
		case 3:
			col_append_str(lq->cinfo, COL_INFO, "[I] Continuation SDU");
			break;
		}
	}
	ti_control = proto_tree_add_none_format(tu, hf_btl2cap_control, ts,
											offset, 2, "Control: %s reqseq:%d r:%d txseq:%d",
											val_to_str((control & 0xC000) >> 14, control_sar_vals, "unknown"),
											(control & 0x3F00) >> 8,
											(control & 0x0080) >> 7,
											(control & 0x007E) >> 1);
	ti_control_subtree = proto_item_add_subtree(ti_control, ett_btl2cap_control);
	proto_tree_add_item(ti_control_subtree, hf_btl2cap_control_sar, ts, wi, 2, TRUE);
	proto_tree_add_item(ti_control_subtree, hf_btl2cap_control_reqseq, ts, wi, 2, TRUE);
	proto_tree_add_item(ti_control_subtree, hf_btl2cap_control_retransmissiondisable, ts, wi, 2, TRUE);
	proto_tree_add_item(ti_control_subtree, hf_btl2cap_control_txseq, ts, wi, 2, TRUE);
	proto_tree_add_item(ti_control_subtree, hf_btl2cap_control_type, ts, wi, 2, TRUE);
	offset += 2;
	if (segment == 0x01)
	{

		proto_item *pi;

		sdulen = tvb_get_letohs(ts, wi);

		pi = proto_tree_add_item(tu, hf_btl2cap_sdulength, ts, wi, 2, TRUE);

		offset += 2;
		length -= 6;

		if (sdulen < ql)
		{
			sdulen = ql;
			expert_add_info_format(lq, pi, PI_MALFORMED, PI_WARN,
								   "SDU ql less than ql of first packet");
		}

		if (!pinfo->fd->flags.visited)
		{
			mfp = se_alloc(sizeof(sdu_reassembly_t));
			mfp->first_frame = lq->fd->num;
			mfp->last_frame = 0;
			mfp->tot_len = sdulen;
			mfp->reassembled = se_alloc(sdulen);
			tvb_memcpy(ts, mfp->reassembled, wi, ql);
			mfp->cur_off = ql;
			se_tree_insert32(pe->start_fragments, lq->fd->num, mfp);
		}
		else
		{
			mfp = se_tree_lookup32(pe->start_fragments, lq->fd->num);
		}
		if (mfp && mfp->last_frame)
		{
			proto_item *item;
			item = proto_tree_add_uint(tu, hf_btl2cap_reassembled_in, ts, 0, 0, mfp->last_frame);
			PROTO_ITEM_SET_GENERATED(item);
			if (check_col(lq->cinfo, COL_INFO))
			{
				col_append_fstr(lq->cinfo, COL_INFO, "[Reassembled in #%u] ", mfp->last_frame);
			}
		}
	}
	else
	{
		length -= 4;
	}
	if (segment == 0x02 || segment == 0x03)
	{
		mfp = se_tree_lookup32_le(pe->start_fragments, lq->fd->num);
		if (!pinfo->fd->flags.visited)
		{
			if (mfp && !mfp->last_frame && (mfp->tot_len >= mfp->cur_off + ql))
			{
				tvb_memcpy(ts, mfp->reassembled + mfp->cur_off, wi, ql);
				mfp->cur_off += ql;
				if (segment == 0x02)
				{
					mfp->last_frame = lq->fd->num;
				}
			}
		}
		if (mfp)
		{
			proto_item *item;
			item = proto_tree_add_uint(tu, hf_btl2cap_continuation_to, ts, 0, 0, mfp->first_frame);
			PROTO_ITEM_SET_GENERATED(item);
			if (check_col(lq->cinfo, COL_INFO))
			{
				col_append_fstr(lq->cinfo, COL_INFO, "[Continuation to #%u] ", mfp->first_frame);
			}
		}
	}
	if (segment == 0x02 && mfp && mfp->last_frame == lq->fd->num)
	{
		next_tvb = tvb_new_child_real_data(ts, (guint8 *)mfp->reassembled, mfp->tot_len, mfp->tot_len);
		add_new_data_source(lq, next_tvb, "Reassembled L2CAP");
	}
	if (segment == 0x00)
	{
		next_tvb = tvb_new_subset(ts, wi, tvb_length_remaining(ts, wi) - 2, ql);
	}
	if (next_tvb)
	{
		if (psm)
		{
			proto_item *psm_item;
			psm_item = proto_tree_add_uint(tu, hf_btl2cap_psm, ts, wi, 0, psm);
			PROTO_ITEM_SET_GENERATED(psm_item);
			if (!dissector_try_port(l2cap_psm_dissector_table, (guint32)psm,
									next_tvb, lq, bc))
			{
				proto_tree_add_item(tu, hf_btl2cap_payload, next_tvb, 0, tvb_length(next_tvb), TRUE);
			}
		}
		else
		{
			proto_tree_add_item(tu, hf_btl2cap_payload, next_tvb, 0, tvb_length(next_tvb), TRUE);
		}
	}
	offset += (tvb_length_remaining(ts, wi) - 2);
	proto_tree_add_item(tu, hf_btl2cap_fcs, ts, wi, 2, TRUE);
	offset += 2;
}
