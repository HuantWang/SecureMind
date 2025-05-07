static void
dissect_ht_capability_ie(proto_tree *wi, tvbuff_t *sn, int fe,
                         guint32 vx, gboolean co)
{
  proto_item *cap_item;
  proto_tree *cap_tree;
  guint16 capability;
  guint32 txbfcap;
  guint32 tag_val_off = 0;

  if (tag_val_off + 2 > vx)
  {
    proto_tree_add_string(wi, tag_interpretation, sn, fe, vx,
                          "Not interpreted");
    return;
  }

  if (vx != 26)
  {
    proto_tree_add_string(wi, tag_interpretation, sn, fe, vx,
                          "HT Capabilities IE content length must be exactly 26 bytes");
    return;
  }

  if (wlan_ignore_draft_ht && co)
    return;

  capability = tvb_get_letohs(sn, fe);
  cap_item = proto_tree_add_item(wi, co ? ht_vs_cap : ht_cap, sn,
                                 fe, 2, TRUE);
  cap_tree = proto_item_add_subtree(cap_item, ett_ht_cap_tree);
  proto_tree_add_boolean(cap_tree, ht_ldpc_coding, sn, fe, 1,
                         capability);
  proto_tree_add_boolean(cap_tree, ht_chan_width, sn, fe, 1,
                         capability);
  proto_tree_add_uint(cap_tree, ht_sm_pwsave, sn, fe, 1,
                      capability);
  proto_tree_add_boolean(cap_tree, ht_green, sn, fe, 1,
                         capability);
  proto_tree_add_boolean(cap_tree, ht_short20, sn, fe, 1,
                         capability);
  proto_tree_add_boolean(cap_tree, ht_short40, sn, fe, 1,
                         capability);
  proto_tree_add_boolean(cap_tree, ht_tx_stbc, sn, fe, 1,
                         capability);
  proto_tree_add_uint(cap_tree, ht_rx_stbc, sn, fe + 1, 1,
                      capability);
  proto_tree_add_boolean(cap_tree, ht_delayed_block_ack, sn, fe + 1, 1,
                         capability);
  proto_tree_add_boolean(cap_tree, ht_max_amsdu, sn, fe + 1, 1,
                         capability);
  proto_tree_add_boolean(cap_tree, ht_dss_cck_40, sn, fe + 1, 1,
                         capability);
  proto_tree_add_boolean(cap_tree, ht_psmp, sn, fe + 1, 1,
                         capability);
  proto_tree_add_boolean(cap_tree, ht_40_mhz_intolerant, sn, fe + 1, 1,
                         capability);
  proto_tree_add_boolean(cap_tree, ht_l_sig, sn, fe + 1, 1,
                         capability);

  fe += 2;
  tag_val_off += 2;

  capability = tvb_get_guint8(sn, fe);
  cap_item = proto_tree_add_item(wi, co ? ampduparam_vs : ampduparam, sn,
                                 fe, 1, TRUE);
  cap_tree = proto_item_add_subtree(cap_item, ett_ampduparam_tree);
  proto_tree_add_uint_format(cap_tree, ampduparam_mpdu, sn, fe, 1, capability, decode_numeric_bitfield(capability, 0x03, 8, "Maximum Rx A-MPDU Length: %%04.0f [Bytes]"), pow(2, 13 + (capability & 0x3)) - 1);
  proto_tree_add_uint(cap_tree, ampduparam_mpdu_start_spacing, sn, fe, 1, capability);
  proto_tree_add_uint(cap_tree, ampduparam_reserved, sn, fe, 1, capability);
  fe += 1;
  tag_val_off += 1;

  dissect_mcs_set(wi, sn, fe, FALSE, co);
  fe += 16;
  tag_val_off += 16;

  capability = tvb_get_letohs(sn, fe);
  cap_item = proto_tree_add_item(wi, co ? htex_vs_cap : htex_cap, sn,
                                 fe, 2, TRUE);
  cap_tree = proto_item_add_subtree(cap_item, ett_htex_cap_tree);
  proto_tree_add_boolean(cap_tree, htex_pco, sn, fe, 1,
                         capability);
  proto_tree_add_uint(cap_tree, htex_transtime, sn, fe, 1,
                      capability);
  proto_tree_add_uint(cap_tree, htex_mcs, sn, fe + 1, 1,
                      capability);
  proto_tree_add_boolean(cap_tree, htex_htc_support, sn, fe + 1, 1,
                         capability);
  proto_tree_add_boolean(cap_tree, htex_rd_responder, sn, fe + 1, 1,
                         capability);

  fe += 2;
  tag_val_off += 2;

  txbfcap = tvb_get_letohl(sn, fe);
  cap_item = proto_tree_add_item(wi, co ? txbf_vs : txbf, sn,
                                 fe, 4, TRUE);
  cap_tree = proto_item_add_subtree(cap_item, ett_txbf_tree);
  proto_tree_add_boolean(cap_tree, txbf_cap, sn, fe, 1,
                         txbfcap);
  proto_tree_add_boolean(cap_tree, txbf_rcv_ssc, sn, fe, 1,
                         txbfcap);
  proto_tree_add_boolean(cap_tree, txbf_tx_ssc, sn, fe, 1,
                         txbfcap);
  proto_tree_add_boolean(cap_tree, txbf_rcv_ndp, sn, fe, 1,
                         txbfcap);
  proto_tree_add_boolean(cap_tree, txbf_tx_ndp, sn, fe, 1,
                         txbfcap);
  proto_tree_add_boolean(cap_tree, txbf_impl_txbf, sn, fe, 1,
                         txbfcap);
  proto_tree_add_uint(cap_tree, txbf_calib, sn, fe, 1,
                      txbfcap);
  proto_tree_add_boolean(cap_tree, txbf_expl_csi, sn, fe + 1, 1,
                         txbfcap);
  proto_tree_add_boolean(cap_tree, txbf_expl_uncomp_fm, sn, fe + 1, 1,
                         txbfcap);
  proto_tree_add_boolean(cap_tree, txbf_expl_comp_fm, sn, fe + 1, 1,
                         txbfcap);
  proto_tree_add_uint(cap_tree, txbf_expl_bf_csi, sn, fe + 1, 1,
                      txbfcap);
  proto_tree_add_uint(cap_tree, txbf_expl_uncomp_fm_feed, sn, fe + 1, 1,
                      txbfcap);
  proto_tree_add_uint(cap_tree, txbf_expl_comp_fm_feed, sn, fe + 1, 2,
                      txbfcap);
  proto_tree_add_uint(cap_tree, txbf_min_group, sn, fe + 2, 1,
                      txbfcap);
  proto_tree_add_uint(cap_tree, txbf_csi_num_bf_ant, sn, fe + 2, 1,
                      txbfcap);
  proto_tree_add_uint(cap_tree, txbf_uncomp_sm_bf_ant, sn, fe + 2, 1,
                      txbfcap);
  proto_tree_add_uint(cap_tree, txbf_comp_sm_bf_ant, sn, fe + 2, 2,
                      txbfcap);
  proto_tree_add_uint(cap_tree, txbf_csi_max_rows_bf, sn, fe + 3, 1,
                      txbfcap);
  proto_tree_add_uint(cap_tree, txbf_chan_est, sn, fe + 3, 1,
                      txbfcap);
  proto_tree_add_uint(cap_tree, txbf_resrv, sn, fe + 3, 1,
                      txbfcap);

  fe += 4;
  tag_val_off += 4;

  capability = tvb_get_guint8(sn, fe);
  cap_item = proto_tree_add_item(wi, co ? antsel_vs : antsel, sn,
                                 fe, 1, TRUE);
  cap_tree = proto_item_add_subtree(cap_item, ett_antsel_tree);
  proto_tree_add_boolean(cap_tree, antsel_b0, sn, fe, 1,
                         capability);
  proto_tree_add_boolean(cap_tree, antsel_b1, sn, fe, 1,
                         capability);
  proto_tree_add_boolean(cap_tree, antsel_b2, sn, fe, 1,
                         capability);
  proto_tree_add_boolean(cap_tree, antsel_b3, sn, fe, 1,
                         capability);
  proto_tree_add_boolean(cap_tree, antsel_b4, sn, fe, 1,
                         capability);
  proto_tree_add_boolean(cap_tree, antsel_b5, sn, fe, 1,
                         capability);
  proto_tree_add_boolean(cap_tree, antsel_b6, sn, fe, 1,
                         capability);
  proto_tree_add_uint(cap_tree, antsel_b7, sn, fe, 1,
                      capability);

  fe += 1;
  tag_val_off += 1;

  if (tag_val_off < vx)
    proto_tree_add_string(wi, tag_interpretation, sn, fe,
                          vx - tag_val_off, "Not interpreted");
}