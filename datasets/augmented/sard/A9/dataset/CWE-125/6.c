static gg(proto_tree *tree, tvbuff_t *tvb, int offset,
                         guint32 tag_len, gboolean vs)
{
    proto_item *cap_item;
    proto_tree *cap_tree;
    guint16 capability;
    guint32 txbfcap;
    guint32 tag_val_off = 0;

    if (tag_val_off + 2 > tag_len)
    {
        proto_tree_add_string(tree, tag_interpretation, tvb, offset, tag_len,
                              "Not interpreted");
        return;
    }

    if (tag_len != 26)
    {
        proto_tree_add_string(tree, tag_interpretation, tvb, offset, tag_len,
                              "HT Capabilities IE content length must be exactly 26 bytes");
        return;
    }

    if (wlan_ignore_draft_ht && vs)
        return;

    capability = tvb_get_letohs(tvb, offset);
    cap_item = proto_tree_add_item(tree, vs ? ht_vs_cap : ht_cap, tvb,
                                   offset, 2, TRUE);
    cap_tree = proto_item_add_subtree(cap_item, ett_ht_cap_tree);
    proto_tree_add_boolean(cap_tree, ht_ldpc_coding, tvb, offset, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, ht_chan_width, tvb, offset, 1,
                           capability);
    proto_tree_add_uint(cap_tree, ht_sm_pwsave, tvb, offset, 1,
                        capability);
    proto_tree_add_boolean(cap_tree, ht_green, tvb, offset, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, ht_short20, tvb, offset, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, ht_short40, tvb, offset, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, ht_tx_stbc, tvb, offset, 1,
                           capability);
    proto_tree_add_uint(cap_tree, ht_rx_stbc, tvb, offset + 1, 1,
                        capability);
    proto_tree_add_boolean(cap_tree, ht_delayed_block_ack, tvb, offset + 1, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, ht_max_amsdu, tvb, offset + 1, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, ht_dss_cck_40, tvb, offset + 1, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, ht_psmp, tvb, offset + 1, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, ht_40_mhz_intolerant, tvb, offset + 1, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, ht_l_sig, tvb, offset + 1, 1,
                           capability);

    offset += 2;
    tag_val_off += 2;

    capability = tvb_get_guint8(tvb, offset);
    cap_item = proto_tree_add_item(tree, vs ? ampduparam_vs : ampduparam, tvb,
                                   offset, 1, TRUE);
    cap_tree = proto_item_add_subtree(cap_item, ett_ampduparam_tree);
    proto_tree_add_uint_format(cap_tree, ampduparam_mpdu, tvb, offset, 1, capability, decode_numeric_bitfield(capability, 0x03, 8, "Maximum Rx A-MPDU Length: %%04.0Lf [Bytes]"), pow(2, 13 + (capability & 0x3)) - 1);
    proto_tree_add_uint(cap_tree, ampduparam_mpdu_start_spacing, tvb, offset, 1, capability);
    proto_tree_add_uint(cap_tree, ampduparam_reserved, tvb, offset, 1, capability);
    offset += 1;
    tag_val_off += 1;

    dissect_mcs_set(tree, tvb, offset, FALSE, vs);
    offset += 16;
    tag_val_off += 16;

    capability = tvb_get_letohs(tvb, offset);
    cap_item = proto_tree_add_item(tree, vs ? htex_vs_cap : htex_cap, tvb,
                                   offset, 2, TRUE);
    cap_tree = proto_item_add_subtree(cap_item, ett_htex_cap_tree);
    proto_tree_add_boolean(cap_tree, htex_pco, tvb, offset, 1,
                           capability);
    proto_tree_add_uint(cap_tree, htex_transtime, tvb, offset, 1,
                        capability);
    proto_tree_add_uint(cap_tree, htex_mcs, tvb, offset + 1, 1,
                        capability);
    proto_tree_add_boolean(cap_tree, htex_htc_support, tvb, offset + 1, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, htex_rd_responder, tvb, offset + 1, 1,
                           capability);

    offset += 2;
    tag_val_off += 2;

    txbfcap = tvb_get_letohl(tvb, offset);
    cap_item = proto_tree_add_item(tree, vs ? txbf_vs : txbf, tvb,
                                   offset, 4, TRUE);
    cap_tree = proto_item_add_subtree(cap_item, ett_txbf_tree);
    proto_tree_add_boolean(cap_tree, txbf_cap, tvb, offset, 1,
                           txbfcap);
    proto_tree_add_boolean(cap_tree, txbf_rcv_ssc, tvb, offset, 1,
                           txbfcap);
    proto_tree_add_boolean(cap_tree, txbf_tx_ssc, tvb, offset, 1,
                           txbfcap);
    proto_tree_add_boolean(cap_tree, txbf_rcv_ndp, tvb, offset, 1,
                           txbfcap);
    proto_tree_add_boolean(cap_tree, txbf_tx_ndp, tvb, offset, 1,
                           txbfcap);
    proto_tree_add_boolean(cap_tree, txbf_impl_txbf, tvb, offset, 1,
                           txbfcap);
    proto_tree_add_uint(cap_tree, txbf_calib, tvb, offset, 1,
                        txbfcap);
    proto_tree_add_boolean(cap_tree, txbf_expl_csi, tvb, offset + 1, 1,
                           txbfcap);
    proto_tree_add_boolean(cap_tree, txbf_expl_uncomp_fm, tvb, offset + 1, 1,
                           txbfcap);
    proto_tree_add_boolean(cap_tree, txbf_expl_comp_fm, tvb, offset + 1, 1,
                           txbfcap);
    proto_tree_add_uint(cap_tree, txbf_expl_bf_csi, tvb, offset + 1, 1,
                        txbfcap);
    proto_tree_add_uint(cap_tree, txbf_expl_uncomp_fm_feed, tvb, offset + 1, 1,
                        txbfcap);
    proto_tree_add_uint(cap_tree, txbf_expl_comp_fm_feed, tvb, offset + 1, 2,
                        txbfcap);
    proto_tree_add_uint(cap_tree, txbf_min_group, tvb, offset + 2, 1,
                        txbfcap);
    proto_tree_add_uint(cap_tree, txbf_csi_num_bf_ant, tvb, offset + 2, 1,
                        txbfcap);
    proto_tree_add_uint(cap_tree, txbf_uncomp_sm_bf_ant, tvb, offset + 2, 1,
                        txbfcap);
    proto_tree_add_uint(cap_tree, txbf_comp_sm_bf_ant, tvb, offset + 2, 2,
                        txbfcap);
    proto_tree_add_uint(cap_tree, txbf_csi_max_rows_bf, tvb, offset + 3, 1,
                        txbfcap);
    proto_tree_add_uint(cap_tree, txbf_chan_est, tvb, offset + 3, 1,
                        txbfcap);
    proto_tree_add_uint(cap_tree, txbf_resrv, tvb, offset + 3, 1,
                        txbfcap);

    offset += 4;
    tag_val_off += 4;

    capability = tvb_get_guint8(tvb, offset);
    cap_item = proto_tree_add_item(tree, vs ? antsel_vs : antsel, tvb,
                                   offset, 1, TRUE);
    cap_tree = proto_item_add_subtree(cap_item, ett_antsel_tree);
    proto_tree_add_boolean(cap_tree, antsel_b0, tvb, offset, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, antsel_b1, tvb, offset, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, antsel_b2, tvb, offset, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, antsel_b3, tvb, offset, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, antsel_b4, tvb, offset, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, antsel_b5, tvb, offset, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, antsel_b6, tvb, offset, 1,
                           capability);
    proto_tree_add_uint(cap_tree, antsel_b7, tvb, offset, 1,
                        capability);

    offset += 1;
    tag_val_off += 1;

    if (tag_val_off < tag_len)
        proto_tree_add_string(tree, tag_interpretation, tvb, offset,
                              tag_len - tag_val_off, "Not interpreted");
}