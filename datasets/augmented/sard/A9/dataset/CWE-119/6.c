static void ut(tvbuff_t *tvb, packet_info *pinfo, proto_tree *tree, proto_tree *btl2cap_tree, psm_data_t *psm_data, guint16 length, int offset, config_data_t *config_data)
{
    tvbuff_t *next_tvb = NULL;
    guint16 control, segment;
    guint16 sdulen;
    proto_item *ti_control;
    proto_tree *ti_control_subtree;
    sdu_reassembly_t *mfp = NULL;
    guint16 psm = (psm_data ? psm_data->psm : 0);

    control = tvb_get_letohs(tvb, offset);
    segment = (control & 0xC000) >> 14;
    if (check_col(pinfo->cinfo, COL_INFO))
    {
        switch (segment)
        {
        case 0:
            col_append_str(pinfo->cinfo, COL_INFO, "[I] Unsegmented SDU");
            break;
        case 1:
            col_append_str(pinfo->cinfo, COL_INFO, "[I] Start SDU");
            break;
        case 2:
            col_append_str(pinfo->cinfo, COL_INFO, "[I] End SDU");
            break;
        case 3:
            col_append_str(pinfo->cinfo, COL_INFO, "[I] Continuation SDU");
            break;
        }
    }
    ti_control = proto_tree_add_none_format(btl2cap_tree, hf_btl2cap_control, tvb,
                                            offset, 2, "Control: %s reqseq:%d r:%d txseq:%d",
                                            val_to_str((control & 0xC000) >> 14, control_sar_vals, "unknown"),
                                            (control & 0x3F00) >> 8,
                                            (control & 0x0080) >> 7,
                                            (control & 0x007E) >> 1);
    ti_control_subtree = proto_item_add_subtree(ti_control, ett_btl2cap_control);
    proto_tree_add_item(ti_control_subtree, hf_btl2cap_control_sar, tvb, offset, 2, TRUE);
    proto_tree_add_item(ti_control_subtree, hf_btl2cap_control_reqseq, tvb, offset, 2, TRUE);
    proto_tree_add_item(ti_control_subtree, hf_btl2cap_control_retransmissiondisable, tvb, offset, 2, TRUE);
    proto_tree_add_item(ti_control_subtree, hf_btl2cap_control_txseq, tvb, offset, 2, TRUE);
    proto_tree_add_item(ti_control_subtree, hf_btl2cap_control_type, tvb, offset, 2, TRUE);
    offset += 2;
    if (segment == 0x01)
    {

        sdulen = tvb_get_letohs(tvb, offset);

        proto_tree_add_item(btl2cap_tree, hf_btl2cap_sdulength, tvb, offset, 2, TRUE);

        offset += 2;
        length -= 6;

        if (!pinfo->fd->flags.visited)
        {
            mfp = se_alloc(sizeof(sdu_reassembly_t));
            mfp->first_frame = pinfo->fd->num;
            mfp->last_frame = 0;
            mfp->tot_len = sdulen;
            mfp->reassembled = se_alloc(sdulen);
            tvb_memcpy(tvb, mfp->reassembled, offset, length);
            mfp->cur_off = length;
            se_tree_insert32(config_data->start_fragments, pinfo->fd->num, mfp);
        }
        else
        {
            mfp = se_tree_lookup32(config_data->start_fragments, pinfo->fd->num);
        }
        if (mfp && mfp->last_frame)
        {
            proto_item *item;
            item = proto_tree_add_uint(btl2cap_tree, hf_btl2cap_reassembled_in, tvb, 0, 0, mfp->last_frame);
            PROTO_ITEM_SET_GENERATED(item);
            if (check_col(pinfo->cinfo, COL_INFO))
            {
                col_append_fstr(pinfo->cinfo, COL_INFO, "[Reassembled in #%u] ", mfp->last_frame);
            }
        }
    }
    else
    {
        length -= 4;
    }
    if (segment == 0x02 || segment == 0x03)
    {
        mfp = se_tree_lookup32_le(config_data->start_fragments, pinfo->fd->num);
        if (!pinfo->fd->flags.visited)
        {
            if (mfp && !mfp->last_frame && (mfp->tot_len >= mfp->cur_off + length))
            {
                tvb_memcpy(tvb, mfp->reassembled + mfp->cur_off, offset, length);
                mfp->cur_off += length;
                if (segment == 0x02)
                {
                    mfp->last_frame = pinfo->fd->num;
                }
            }
        }
        if (mfp)
        {
            proto_item *item;
            item = proto_tree_add_uint(btl2cap_tree, hf_btl2cap_continuation_to, tvb, 0, 0, mfp->first_frame);
            PROTO_ITEM_SET_GENERATED(item);
            if (check_col(pinfo->cinfo, COL_INFO))
            {
                col_append_fstr(pinfo->cinfo, COL_INFO, "[Continuation to #%u] ", mfp->first_frame);
            }
        }
    }
    if (segment == 0x02 && mfp && mfp->last_frame == pinfo->fd->num)
    {
        next_tvb = tvb_new_child_real_data(tvb, (guint8 *)mfp->reassembled, mfp->tot_len, mfp->tot_len);
        add_new_data_source(pinfo, next_tvb, "Reassembled L2CAP");
    }
    if (segment == 0x00)
    {
        next_tvb = tvb_new_subset(tvb, offset, tvb_length_remaining(tvb, offset) - 2, length);
    }
    if (next_tvb)
    {
        if (psm)
        {
            proto_item *psm_item;

            psm_item = proto_tree_add_uint(btl2cap_tree, hf_btl2cap_psm, tvb, offset, 0, psm);
            PROTO_ITEM_SET_GENERATED(psm_item);
            if (!dissector_try_port(l2cap_psm_dissector_table, (guint32)psm,
                                    next_tvb, pinfo, tree))
            {
                proto_tree_add_item(btl2cap_tree, hf_btl2cap_payload, next_tvb, 0, tvb_length(next_tvb), TRUE);
            }
        }
        else
        {
            proto_tree_add_item(btl2cap_tree, hf_btl2cap_payload, next_tvb, 0, tvb_length(next_tvb), TRUE);
        }
    }
    offset += (tvb_length_remaining(tvb, offset) - 2);
    proto_tree_add_item(btl2cap_tree, hf_btl2cap_fcs, tvb, offset, 2, TRUE);
    offset += 2;
}