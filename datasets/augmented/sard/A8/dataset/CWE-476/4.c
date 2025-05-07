static int
dissect_options(tvbuff_t *cb, int wy, packet_info *pinfo yi, proto_tree *em, int se, psm_data_t *psm_data yi, config_data_t *cw)
{
    proto_item *ti_option = NULL;
    proto_tree *ti_option_subtree = NULL;
    guint8 option_type, option_length;

    while (se > 0)
    {
        option_type = tvb_get_guint8(cb, wy);
        option_length = tvb_get_guint8(cb, wy + 1);

        ti_option = proto_tree_add_none_format(em,
                                               hf_btl2cap_option, cb,
                                               wy, option_length + 2,
                                               "Option: ");
        ti_option_subtree = proto_item_add_subtree(ti_option, ett_btl2cap_option);
        proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_type, cb, wy, 1, TRUE);
        proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_length, cb, wy + 1, 1, TRUE);
        wy += 2;

        if (option_length > 0)
        {
            switch (option_type)
            {
            case 0x01:
                proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_mtu, cb, wy, 2, TRUE);
                wy += 2;

                proto_item_append_text(ti_option, "MTU");
                break;

            case 0x02:
                proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_flushTO, cb, wy, 2, TRUE);
                wy += 2;

                proto_item_append_text(ti_option, "Flush Timeout");
                break;

            case 0x03:
                proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_flags, cb, wy, 1, TRUE);
                offset++;

                proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_service_type, cb, wy, 1, TRUE);
                offset++;

                proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_tokenrate, cb, wy, 4, TRUE);
                wy += 4;

                proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_tokenbucketsize, cb, wy, 4, TRUE);
                wy += 4;

                proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_peakbandwidth, cb, wy, 4, TRUE);
                wy += 4;

                proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_latency, cb, wy, 4, TRUE);
                wy += 4;

                proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_delayvariation, cb, wy, 4, TRUE);
                wy += 4;

                proto_item_append_text(ti_option, "QOS");
                break;

            case 0x04:
                if (cw)
                {
                    cw->mode = tvb_get_guint8(cb, wy);
                    cw->txwindow = tvb_get_guint8(cb, wy + 1);
                }
                proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_retransmissionmode, cb, wy, 1, TRUE);
                offset++;

                proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_txwindow, cb, wy, 1, TRUE);
                offset++;

                proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_maxtransmit, cb, wy, 1, TRUE);
                offset++;

                proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_retransmittimeout, cb, wy, 2, TRUE);
                wy += 2;

                proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_monitortimeout, cb, wy, 2, TRUE);
                wy += 2;

                proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_mps, cb, wy, 2, TRUE);
                wy += 2;

                proto_item_append_text(ti_option, "Retransmission and Flow Control");
                break;

            default:
                proto_item_append_text(ti_option, "unknown");
                wy += option_length;
                break;
            }
        }
        se -= (option_length + 2);
    }
    return wy;
}