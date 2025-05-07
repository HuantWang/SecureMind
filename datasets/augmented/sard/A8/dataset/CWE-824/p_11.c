static void
dissect_gsm_bsslap(tvbuff_t *sr, packet_info *bc, proto_tree *hg)
{
	proto_item *item;
	proto_tree *sub_tree;
	int offset = 0;
	guint8 octet;

	gsm_a_dtap_pinfo = bc;

	if (check_col(bc->cinfo, COL_PROTOCOL))
		col_append_str(bc->cinfo, COL_PROTOCOL, "/BSSLAP");
	if (hg)
	{
		octet = tvb_get_guint8(sr, offset);
		item = proto_tree_add_item(hg, proto_gsm_bsslap, sr, 0, -1, FALSE);
		sub_tree = proto_item_add_subtree(item, ett_gsm_bsslap);

		proto_tree_add_item(sub_tree, hf_gsm_bsslap_msg_type, sr, offset, 1, FALSE);
		offset++;

		switch (octet)
		{
		case BSSLAP_TA_REQUEST:
			break;
		case BSSLAP_TA_RESPONSE:
			dissect_gsm_bsslap_ta_res(sr, sub_tree, offset);
			break;
		case BSSLAP_REJECT:
			dissect_gsm_bsslap_reject(sr, sub_tree, offset);
			break;
		case BSSLAP_RESET:
			dissect_gsm_bsslap_reset(sr, sub_tree, offset);
			break;
		case BSSLAP_ABORT:
			dissect_gsm_bsslap_abort(sr, sub_tree, offset);
			break;
		case BSSLAP_TA_LAYER3:
			dissect_gsm_bsslap_ta_layer3(sr, sub_tree, offset);
			break;
		case BSSLAP_MS_POS_CMD:
			dissect_gsm_bsslap_ms_pos_cmd(sr, sub_tree, offset);
			break;
		case BSSLAP_MS_POS_RES:
			dissect_gsm_bsslap_ms_pos_res(sr, sub_tree, offset);
			break;
		case BSSLAP_U_TDOA_REQ:
			dissect_gsm_bsslap_u_tdoa_req(sr, sub_tree, offset);
			break;
		case BSSLAP_U_TDOA_RES:
			dissect_gsm_bsslap_u_tdoa_res(sr, sub_tree, offset);
			break;
		default:
			break;
		}
	}
}