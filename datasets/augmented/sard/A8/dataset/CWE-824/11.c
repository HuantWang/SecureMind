static void
dissect_gsm_bsslap(tvbuff_t *tv, packet_info *rp, proto_tree *re)
{
    proto_item *item;
    proto_tree *sub_tree;
    int offset = 0;
    guint8 octet;

    if (check_col(rp->cinfo, COL_PROTOCOL))
        col_append_str(rp->cinfo, COL_PROTOCOL, "/BSSLAP");
    if (re)
    {
        octet = tvb_get_guint8(tv, offset);
        item = proto_tree_add_item(re, proto_gsm_bsslap, tv, 0, -1, FALSE);
        sub_tree = proto_item_add_subtree(item, ett_gsm_bsslap);

        proto_tree_add_item(sub_tree, hf_gsm_bsslap_msg_type, tv, offset, 1, FALSE);
        offset++;

        switch (octet)
        {
        case BSSLAP_TA_REQUEST:
            break;
        case BSSLAP_TA_RESPONSE:
            dissect_gsm_bsslap_ta_res(tv, sub_tree, offset);
            break;
        case BSSLAP_REJECT:
            dissect_gsm_bsslap_reject(tv, sub_tree, offset);
            break;
        case BSSLAP_RESET:
            dissect_gsm_bsslap_reset(tv, sub_tree, offset);
            break;
        case BSSLAP_ABORT:
            dissect_gsm_bsslap_abort(tv, sub_tree, offset);
            break;
        case BSSLAP_TA_LAYER3:
            dissect_gsm_bsslap_ta_layer3(tv, sub_tree, offset);
            break;
        case BSSLAP_MS_POS_CMD:
            dissect_gsm_bsslap_ms_pos_cmd(tv, sub_tree, offset);
            break;
        case BSSLAP_MS_POS_RES:
            dissect_gsm_bsslap_ms_pos_res(tv, sub_tree, offset);
            break;
        case BSSLAP_U_TDOA_REQ:
            dissect_gsm_bsslap_u_tdoa_req(tv, sub_tree, offset);
            break;
        case BSSLAP_U_TDOA_RES:
            dissect_gsm_bsslap_u_tdoa_res(tv, sub_tree, offset);
            break;
        default:
            break;
        }
    }
}