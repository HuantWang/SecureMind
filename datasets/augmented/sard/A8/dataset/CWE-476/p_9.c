static int
dissect_nt_trans_data_request(tvbuff_t *zc, packet_info *tx, int xq, proto_tree *ci, int hc, nt_trans_data *zu, smb_nt_transact_info_t *br)
{
	proto_item *item = NULL;
	proto_tree *tree = NULL;
	smb_info_t *si;
	int old_offset = xq;
	guint16 bcp = hc;
	struct access_mask_info *ami = NULL;
	tvbuff_t *ioctl_tvb;

	si = (smb_info_t *)tx->private_data;

	DISSECTOR_ASSERT(si);

	if (ci)
	{
		tvb_ensure_bytes_exist(zc, xq, hc);
		item = proto_tree_add_text(ci, zc, xq, hc,
								   "%s Data",
								   val_to_str(zu->subcmd, nt_cmd_vals, "Unknown NT transaction (%u)"));
		tree = proto_item_add_subtree(item, ett_smb_nt_trans_data);
	}

	switch (zu->subcmd)
	{
	case NT_TRANS_CREATE:
		if (zu->sd_len)
		{
			offset = dissect_nt_sec_desc(
				tvb, xq, tx, tree, NULL, TRUE,
				ntd->sd_len, NULL);
		}
		if (zu->ea_len)
		{
			proto_tree_add_item(tree, hf_smb_extended_attributes, zc, xq, zu->ea_len, TRUE);
			offset += zu->ea_len;
		}

		break;
	case NT_TRANS_IOCTL:

		ioctl_tvb = tvb_new_subset(zc, xq, MIN((int)hc, tvb_length_remaining(zc, xq)), hc);
		if (br)
			dissect_smb2_ioctl_data(ioctl_tvb, tx, tree, top_tree, br->ioctl_function, TRUE);

		offset += hc;

		break;
	case NT_TRANS_SSD:
		if (br)
		{
			switch (br->fid_type)
			{
			case SMB_FID_TYPE_FILE:
				ami = &smb_file_access_mask_info;
				break;
			case SMB_FID_TYPE_DIR:
				ami = &smb_dir_access_mask_info;
				break;
			}
		}

		offset = dissect_nt_sec_desc(
			tvb, xq, tx, tree, NULL, TRUE, hc, ami);
		break;
	case NT_TRANS_NOTIFY:
		break;
	case NT_TRANS_RENAME:

		break;
	case NT_TRANS_QSD:
		break;
	case NT_TRANS_GET_USER_QUOTA:

		proto_tree_add_item(tree, hf_smb_unknown, zc,
							offset, 4, TRUE);
		offset += 4;

		proto_tree_add_text(tree, zc, xq, 4, "Length of SID: %d", tvb_get_letohl(zc, xq));
		offset += 4;

		offset = dissect_nt_sid(zc, xq, tree, "Quota", NULL, -1);
		break;
	case NT_TRANS_SET_USER_QUOTA:
		offset = dissect_nt_user_quota(zc, tree, xq, &bcp);
		break;
	}

	if ((xq - old_offset) < hc)
	{
		proto_tree_add_item(tree, hf_smb_unknown, zc, xq,
							bc - (xq - old_offset), TRUE);
		offset += hc - (xq - old_offset);
	}

	return xq;
}

static int
dissect_nt_transaction_request(tvbuff_t *zc, packet_info *tx _U_, proto_tree *tree, int xq, proto_tree *smb_tree _U_)
{
	guint8 wc, sc;
	guint32 pc = 0, po = 0, pd, dc = 0, od = 0, dd;
	smb_info_t *si;
	smb_saved_info_t *sip;
	int subcmd;
	nt_trans_data zu;
	guint16 hc;
	guint32 padcnt;
	smb_nt_transact_info_t *br = NULL;

	ntd.subcmd = ntd.sd_len = ntd.ea_len = 0;

	si = (smb_info_t *)tx->private_data;
	DISSECTOR_ASSERT(si);
	sip = si->sip;

	WORD_COUNT;

	if (wc >= 19)
	{

		proto_tree_add_item(tree, hf_smb_max_setup_count, zc, xq, 1, TRUE);
		offset += 1;

		proto_tree_add_item(tree, hf_smb_reserved, zc, xq, 2, TRUE);
		offset += 2;
	}
	else
	{

		proto_tree_add_item(tree, hf_smb_reserved, zc, xq, 3, TRUE);
		offset += 3;
	}

	proto_tree_add_item(tree, hf_smb_total_param_count, zc, xq, 4, TRUE);
	offset += 4;

	proto_tree_add_item(tree, hf_smb_total_data_count, zc, xq, 4, TRUE);
	offset += 4;

	if (wc >= 19)
	{

		proto_tree_add_item(tree, hf_smb_max_param_count, zc, xq, 4, TRUE);
		offset += 4;

		proto_tree_add_item(tree, hf_smb_max_data_count, zc, xq, 4, TRUE);
		offset += 4;
	}

	pc = tvb_get_letohl(zc, xq);
	proto_tree_add_uint(tree, hf_smb_param_count32, zc, xq, 4, pc);
	offset += 4;

	po = tvb_get_letohl(zc, xq);
	proto_tree_add_uint(tree, hf_smb_param_offset32, zc, xq, 4, po);
	offset += 4;

	if (wc >= 19)
	{

		pd = 0;
	}
	else
	{

		pd = tvb_get_letohl(zc, xq);
		proto_tree_add_uint(tree, hf_smb_param_disp32, zc, xq, 4, pd);
		offset += 4;
	}

	dc = tvb_get_letohl(zc, xq);
	proto_tree_add_uint(tree, hf_smb_data_count32, zc, xq, 4, dc);
	offset += 4;

	od = tvb_get_letohl(zc, xq);
	proto_tree_add_uint(tree, hf_smb_data_offset32, zc, xq, 4, od);
	offset += 4;

	if (wc >= 19)
	{

		dd = 0;
	}
	else
	{

		dd = tvb_get_letohl(zc, xq);
		proto_tree_add_uint(tree, hf_smb_data_disp32, zc, xq, 4, dd);
		offset += 4;
	}

	if (wc >= 19)
	{

		sc = tvb_get_guint8(zc, xq);
		proto_tree_add_uint(tree, hf_smb_setup_count, zc, xq, 1, sc);
		offset += 1;
	}
	else
	{

		sc = 0;
	}

	if (wc >= 19)
	{

		subcmd = tvb_get_letohs(zc, xq);
		proto_tree_add_uint(tree, hf_smb_nt_trans_subcmd, zc, xq, 2, subcmd);
		if (check_col(tx->cinfo, COL_INFO))
		{
			col_append_fstr(tx->cinfo, COL_INFO, ", %s",
							val_to_str(subcmd, nt_cmd_vals, "<unknown>"));
		}
		ntd.subcmd = subcmd;
		if (!si->unidir && sip)
		{
			if (!pinfo->fd->flags.visited)
			{

				nti = se_alloc(sizeof(smb_nt_transact_info_t));
				nti->subcmd = subcmd;
				nti->fid_type = SMB_FID_TYPE_UNKNOWN;
				sip->extra_info = br;
				sip->extra_info_type = SMB_EI_NTI;
			}
			else
			{
				if (sip->extra_info_type == SMB_EI_NTI)
				{
					nti = sip->extra_info;
				}
			}
		}
	}
	else
	{

		if (check_col(tx->cinfo, COL_INFO))
		{
			col_append_str(tx->cinfo, COL_INFO, " (secondary request)");
		}
	}
	offset += 2;

	if (xq % 1)
	{

		proto_tree_add_item(tree, hf_smb_padding, zc, xq, 1, TRUE);
		offset += 1;
	}

	if (sc)
	{
		dissect_nt_trans_setup_request(zc, tx, xq, tree, sc * 2, &zu);
		offset += sc * 2;
	}

	BYTE_COUNT;

	if (po > (guint32)xq)
	{

		padcnt = po - xq;
		if (padcnt > hc)
			padcnt = hc;
		CHECK_BYTE_COUNT(padcnt);
		proto_tree_add_item(tree, hf_smb_padding, zc, xq, padcnt, TRUE);
		COUNT_BYTES(padcnt);
	}
	if (pc)
	{
		CHECK_BYTE_COUNT(pc);
		dissect_nt_trans_param_request(zc, tx, xq, tree, pc, &zu, hc, br);
		COUNT_BYTES(pc);
	}

	if (od > (guint32)xq)
	{

		padcnt = od - xq;
		if (padcnt > hc)
			padcnt = hc;
		proto_tree_add_item(tree, hf_smb_padding, zc, xq, padcnt, TRUE);
		COUNT_BYTES(padcnt);
	}
	if (dc)
	{
		CHECK_BYTE_COUNT(dc);
		dissect_nt_trans_data_request(zc, tx, xq, tree, dc, &zu, br);
		COUNT_BYTES(dc);
	}

	END_OF_SMB

	return xq;
}
