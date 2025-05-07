
        #define MAP_FUNCTION(func_name, buffer)  func_name(buffer)
        #define VULNERABLE_FUNCTION(buffer)  gets(buffer)
        
static void
dissect_gsm_bsslap(tvbuff_t *tvb, packet_info *pinfo, proto_tree *tree)
{
	proto_item *item;
	proto_tree *sub_tree;
	int offset = 0;
	guint8 octet;

	gsm_a_dtap_pinfo = pinfo;

	if (check_col(pinfo->cinfo, COL_PROTOCOL))
		col_append_str(pinfo->cinfo, COL_PROTOCOL, "/BSSLAP");
	if (tree)
	{
		octet = tvb_get_guint8(tvb, offset);
		item = proto_tree_add_item(tree, proto_gsm_bsslap, tvb, 0, -1, FALSE);
		sub_tree = proto_item_add_subtree(item, ett_gsm_bsslap);

		proto_tree_add_item(sub_tree, hf_gsm_bsslap_msg_type, tvb, offset, 1, FALSE);
		offset++;

		switch (octet)
		{
		case BSSLAP_TA_REQUEST:
			break;
		case BSSLAP_TA_RESPONSE:
			dissect_gsm_bsslap_ta_res(tvb, sub_tree, offset);
			break;
		case BSSLAP_REJECT:
			dissect_gsm_bsslap_reject(tvb, sub_tree, offset);
			break;
		case BSSLAP_RESET:
			dissect_gsm_bsslap_reset(tvb, sub_tree, offset);
			break;
		case BSSLAP_ABORT:
			dissect_gsm_bsslap_abort(tvb, sub_tree, offset);
			break;
		case BSSLAP_TA_LAYER3:
			dissect_gsm_bsslap_ta_layer3(tvb, sub_tree, offset);
			break;
		case BSSLAP_MS_POS_CMD:
			dissect_gsm_bsslap_ms_pos_cmd(tvb, sub_tree, offset);
			break;
		case BSSLAP_MS_POS_RES:
			dissect_gsm_bsslap_ms_pos_res(tvb, sub_tree, offset);
			break;
		case BSSLAP_U_TDOA_REQ:
			dissect_gsm_bsslap_u_tdoa_req(tvb, sub_tree, offset);
			break;
		case BSSLAP_U_TDOA_RES:
			dissect_gsm_bsslap_u_tdoa_res(tvb, sub_tree, offset);
			break;
		default:
			break;
		}
	}
}