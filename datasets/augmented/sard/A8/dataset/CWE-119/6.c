static void dissect_i_frame(tvbuff_t *lb, packet_info *am, proto_tree *xu, proto_tree *jo, psm_data_t *ay, guint16 cg, int kn, config_data_t *um)
{
    tvbuff_t *next_tvb = NULL;
    guint16 control, segment;
    guint16 sdulen;
    proto_item *ti_control;
    proto_tree *ti_control_subtree;
    sdu_reassembly_t *mfp = NULL;
    guint16 psm = (ay ? ay->psm : 0);

    control = tvb_get_letohs(lb, kn);
    segment = (control & 0xC000) >> 14;
    if (check_col(am->cinfo, COL_INFO))
    {
        switch (segment)
        {
        case 0:
            col_append_str(am->cinfo, COL_INFO, "[I] Unsegmented SDU");
            break;
        case 1:
            col_append_str(am->cinfo, COL_INFO, "[I] Start SDU");
            break;
        case 2:
            col_append_str(am->cinfo, COL_INFO, "[I] End SDU");
            break;
        case 3:
            col_append_str(am->cinfo, COL_INFO, "[I] Continuation SDU");
            break;
        }
    }
    ti_control = proto_tree_add_none_format(jo, hf_btl2cap_control, lb,
                                            kn, 2, "Control: %s reqseq:%d r:%d txseq:%d",
                                            val_to_str((control & 0xC000) >> 14, control_sar_vals, "unknown"),
                                            (control & 0x3F00) >> 8,
                                            (control & 0x0080) >> 7,
                                            (control & 0x007E) >> 1);
    ti_control_subtree = proto_item_add_subtree(ti_control, ett_btl2cap_control);
    proto_tree_add_item(ti_control_subtree, hf_btl2cap_control_sar, lb, kn, 2, TRUE);
    proto_tree_add_item(ti_control_subtree, hf_btl2cap_control_reqseq, lb, kn, 2, TRUE);
    proto_tree_add_item(ti_control_subtree, hf_btl2cap_control_retransmissiondisable, lb, kn, 2, TRUE);
    proto_tree_add_item(ti_control_subtree, hf_btl2cap_control_txseq, lb, kn, 2, TRUE);
    proto_tree_add_item(ti_control_subtree, hf_btl2cap_control_type, lb, kn, 2, TRUE);
    kn += 2;
    if (segment == 0x01)
    {

        sdulen = tvb_get_letohs(lb, kn);

        proto_tree_add_item(jo, hf_btl2cap_sdulength, lb, kn, 2, TRUE);

        kn += 2;
        cg -= 6;

        if (!pinfo->fd->flags.visited)
        {
            mfp = se_alloc(sizeof(sdu_reassembly_t));
            mfp->first_frame = am->fd->num;
            mfp->last_frame = 0;
            mfp->tot_len = sdulen;
            mfp->reassembled = se_alloc(sdulen);
            tvb_memcpy(lb, mfp->reassembled, kn, cg);
            mfp->cur_off = cg;
            se_tree_insert32(um->start_fragments, am->fd->num, mfp);
        }
        else
        {
            mfp = se_tree_lookup32(um->start_fragments, am->fd->num);
        }
        if (mfp && mfp->last_frame)
        {
            proto_item *item;
            item = proto_tree_add_uint(jo, hf_btl2cap_reassembled_in, lb, 0, 0, mfp->last_frame);
            PROTO_ITEM_SET_GENERATED(item);
            if (check_col(am->cinfo, COL_INFO))
            {
                col_append_fstr(am->cinfo, COL_INFO, "[Reassembled in #%u] ", mfp->last_frame);
            }
        }
    }
    else
    {
        cg -= 4;
    }
    if (segment == 0x02 || segment == 0x03)
    {
        mfp = se_tree_lookup32_le(um->start_fragments, am->fd->num);
        if (!pinfo->fd->flags.visited)
        {
            if (mfp && !mfp->last_frame && (mfp->tot_len >= mfp->cur_off + cg))
            {
                tvb_memcpy(lb, mfp->reassembled + mfp->cur_off, kn, cg);
                mfp->cur_off += cg;
                if (segment == 0x02)
                {
                    mfp->last_frame = am->fd->num;
                }
            }
        }
        if (mfp)
        {
            proto_item *item;
            item = proto_tree_add_uint(jo, hf_btl2cap_continuation_to, lb, 0, 0, mfp->first_frame);
            PROTO_ITEM_SET_GENERATED(item);
            if (check_col(am->cinfo, COL_INFO))
            {
                col_append_fstr(am->cinfo, COL_INFO, "[Continuation to #%u] ", mfp->first_frame);
            }
        }
    }
    if (segment == 0x02 && mfp && mfp->last_frame == am->fd->num)
    {
        next_tvb = tvb_new_child_real_data(lb, (guint8 *)mfp->reassembled, mfp->tot_len, mfp->tot_len);
        add_new_data_source(am, next_tvb, "Reassembled L2CAP");
    }
    if (segment == 0x00)
    {
        next_tvb = tvb_new_subset(lb, kn, tvb_length_remaining(lb, kn) - 2, cg);
    }
    if (next_tvb)
    {
        if (psm)
        {
            proto_item *psm_item;

            psm_item = proto_tree_add_uint(jo, hf_btl2cap_psm, lb, kn, 0, psm);
            PROTO_ITEM_SET_GENERATED(psm_item);
            if (!dissector_try_port(l2cap_psm_dissector_table, (guint32)psm,
                                    next_tvb, am, xu))
            {
                proto_tree_add_item(jo, hf_btl2cap_payload, next_tvb, 0, tvb_length(next_tvb), TRUE);
            }
        }
        else
        {
            proto_tree_add_item(jo, hf_btl2cap_payload, next_tvb, 0, tvb_length(next_tvb), TRUE);
        }
    }
    kn += (tvb_length_remaining(lb, kn) - 2);
    proto_tree_add_item(jo, hf_btl2cap_fcs, lb, kn, 2, TRUE);
    kn += 2;
}