static void
dissect_ht_capability_ie(proto_tree *ee, tvbuff_t *fn, int jf,
                         guint32 ss, gboolean pt)
{
    proto_item *cap_item;
    proto_tree *cap_tree;
    guint16 capability;
    guint32 txbfcap;
    guint32 tag_val_off = 0;

    if (tag_val_off + 2 > ss)
    {
        proto_tree_add_string(ee, tag_interpretation, fn, jf, ss,
                              "Not interpreted");
        return;
    }

    if (ss != 26)
    {
        proto_tree_add_string(ee, tag_interpretation, fn, jf, ss,
                              "HT Capabilities IE content length must be exactly 26 bytes");
        return;
    }

    if (wlan_ignore_draft_ht && pt)
        return;

    capability = tvb_get_letohs(fn, jf);
    cap_item = proto_tree_add_item(ee, pt ? ht_vs_cap : ht_cap, fn,
                                   jf, 2, TRUE);
    cap_tree = proto_item_add_subtree(cap_item, ett_ht_cap_tree);
    proto_tree_add_boolean(cap_tree, ht_ldpc_coding, fn, jf, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, ht_chan_width, fn, jf, 1,
                           capability);
    proto_tree_add_uint(cap_tree, ht_sm_pwsave, fn, jf, 1,
                        capability);
    proto_tree_add_boolean(cap_tree, ht_green, fn, jf, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, ht_short20, fn, jf, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, ht_short40, fn, jf, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, ht_tx_stbc, fn, jf, 1,
                           capability);
    proto_tree_add_uint(cap_tree, ht_rx_stbc, fn, jf + 1, 1,
                        capability);
    proto_tree_add_boolean(cap_tree, ht_delayed_block_ack, fn, jf + 1, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, ht_max_amsdu, fn, jf + 1, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, ht_dss_cck_40, fn, jf + 1, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, ht_psmp, fn, jf + 1, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, ht_40_mhz_intolerant, fn, jf + 1, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, ht_l_sig, fn, jf + 1, 1,
                           capability);

    jf += 2;
    tag_val_off += 2;

    capability = tvb_get_guint8(fn, jf);
    cap_item = proto_tree_add_item(ee, pt ? ampduparam_vs : ampduparam, fn,
                                   jf, 1, TRUE);
    cap_tree = proto_item_add_subtree(cap_item, ett_ampduparam_tree);
    proto_tree_add_uint_format(cap_tree, ampduparam_mpdu, fn, jf, 1, capability, decode_numeric_bitfield(capability, 0x03, 8, "Maximum Rx A-MPDU Length: %%04.0Lf [Bytes]"), pow(2, 13 + (capability & 0x3)) - 1);
    proto_tree_add_uint(cap_tree, ampduparam_mpdu_start_spacing, fn, jf, 1, capability);
    proto_tree_add_uint(cap_tree, ampduparam_reserved, fn, jf, 1, capability);
    jf += 1;
    tag_val_off += 1;

    dissect_mcs_set(ee, fn, jf, FALSE, pt);
    jf += 16;
    tag_val_off += 16;

    capability = tvb_get_letohs(fn, jf);
    cap_item = proto_tree_add_item(ee, pt ? htex_vs_cap : htex_cap, fn,
                                   jf, 2, TRUE);
    cap_tree = proto_item_add_subtree(cap_item, ett_htex_cap_tree);
    proto_tree_add_boolean(cap_tree, htex_pco, fn, jf, 1,
                           capability);
    proto_tree_add_uint(cap_tree, htex_transtime, fn, jf, 1,
                        capability);
    proto_tree_add_uint(cap_tree, htex_mcs, fn, jf + 1, 1,
                        capability);
    proto_tree_add_boolean(cap_tree, htex_htc_support, fn, jf + 1, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, htex_rd_responder, fn, jf + 1, 1,
                           capability);

    jf += 2;
    tag_val_off += 2;

    txbfcap = tvb_get_letohl(fn, jf);
    cap_item = proto_tree_add_item(ee, pt ? txbf_vs : txbf, fn,
                                   jf, 4, TRUE);
    cap_tree = proto_item_add_subtree(cap_item, ett_txbf_tree);
    proto_tree_add_boolean(cap_tree, txbf_cap, fn, jf, 1,
                           txbfcap);
    proto_tree_add_boolean(cap_tree, txbf_rcv_ssc, fn, jf, 1,
                           txbfcap);
    proto_tree_add_boolean(cap_tree, txbf_tx_ssc, fn, jf, 1,
                           txbfcap);
    proto_tree_add_boolean(cap_tree, txbf_rcv_ndp, fn, jf, 1,
                           txbfcap);
    proto_tree_add_boolean(cap_tree, txbf_tx_ndp, fn, jf, 1,
                           txbfcap);
    proto_tree_add_boolean(cap_tree, txbf_impl_txbf, fn, jf, 1,
                           txbfcap);
    proto_tree_add_uint(cap_tree, txbf_calib, fn, jf, 1,
                        txbfcap);
    proto_tree_add_boolean(cap_tree, txbf_expl_csi, fn, jf + 1, 1,
                           txbfcap);
    proto_tree_add_boolean(cap_tree, txbf_expl_uncomp_fm, fn, jf + 1, 1,
                           txbfcap);
    proto_tree_add_boolean(cap_tree, txbf_expl_comp_fm, fn, jf + 1, 1,
                           txbfcap);
    proto_tree_add_uint(cap_tree, txbf_expl_bf_csi, fn, jf + 1, 1,
                        txbfcap);
    proto_tree_add_uint(cap_tree, txbf_expl_uncomp_fm_feed, fn, jf + 1, 1,
                        txbfcap);
    proto_tree_add_uint(cap_tree, txbf_expl_comp_fm_feed, fn, jf + 1, 2,
                        txbfcap);
    proto_tree_add_uint(cap_tree, txbf_min_group, fn, jf + 2, 1,
                        txbfcap);
    proto_tree_add_uint(cap_tree, txbf_csi_num_bf_ant, fn, jf + 2, 1,
                        txbfcap);
    proto_tree_add_uint(cap_tree, txbf_uncomp_sm_bf_ant, fn, jf + 2, 1,
                        txbfcap);
    proto_tree_add_uint(cap_tree, txbf_comp_sm_bf_ant, fn, jf + 2, 2,
                        txbfcap);
    proto_tree_add_uint(cap_tree, txbf_csi_max_rows_bf, fn, jf + 3, 1,
                        txbfcap);
    proto_tree_add_uint(cap_tree, txbf_chan_est, fn, jf + 3, 1,
                        txbfcap);
    proto_tree_add_uint(cap_tree, txbf_resrv, fn, jf + 3, 1,
                        txbfcap);

    jf += 4;
    tag_val_off += 4;

    capability = tvb_get_guint8(fn, jf);
    cap_item = proto_tree_add_item(ee, pt ? antsel_vs : antsel, fn,
                                   jf, 1, TRUE);
    cap_tree = proto_item_add_subtree(cap_item, ett_antsel_tree);
    proto_tree_add_boolean(cap_tree, antsel_b0, fn, jf, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, antsel_b1, fn, jf, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, antsel_b2, fn, jf, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, antsel_b3, fn, jf, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, antsel_b4, fn, jf, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, antsel_b5, fn, jf, 1,
                           capability);
    proto_tree_add_boolean(cap_tree, antsel_b6, fn, jf, 1,
                           capability);
    proto_tree_add_uint(cap_tree, antsel_b7, fn, jf, 1,
                        capability);

    jf += 1;
    tag_val_off += 1;

    if (tag_val_off < ss)
        proto_tree_add_string(ee, tag_interpretation, fn, jf,
                              ss - tag_val_off, "Not interpreted");
}