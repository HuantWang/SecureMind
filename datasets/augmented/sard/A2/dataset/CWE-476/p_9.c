static int
dissect_nt_trans_data_request(tvbuff_t *tvb, packet_info *pinfo, int offset, proto_tree *parent_tree, int bc, nt_trans_data *ntd, smb_nt_transact_info_t *nti)
{
	proto_item *item = NULL;
	proto_tree *tree = NULL;
	smb_info_t *si;
	int old_offset = offset;
	guint16 bcp = bc;
	struct access_mask_info *ami = NULL;
	tvbuff_t *ioctl_tvb;

	si = (smb_info_t *)pinfo->private_data;

	DISSECTOR_ASSERT(si);

	if (parent_tree)
	{
		tvb_ensure_bytes_exist(tvb, offset, bc);
		item = proto_tree_add_text(parent_tree, tvb, offset, bc,
								   "%s Data",
								   val_to_str(ntd->subcmd, nt_cmd_vals, "Unknown NT transaction (%u)"));
		tree = proto_item_add_subtree(item, ett_smb_nt_trans_data);
	}

	switch (ntd->subcmd)
	{
	case NT_TRANS_CREATE:
		if (ntd->sd_len)
		{
			offset = dissect_nt_sec_desc(
				tvb, offset, pinfo, tree, NULL, TRUE,
				ntd->sd_len, NULL);
		}
		if (ntd->ea_len)
		{
			proto_tree_add_item(tree, hf_smb_extended_attributes, tvb, offset, ntd->ea_len, TRUE);
			offset += ntd->ea_len;
		}

		break;
	case NT_TRANS_IOCTL:

		ioctl_tvb = tvb_new_subset(tvb, offset, MIN((int)bc, tvb_length_remaining(tvb, offset)), bc);
		if (nti)
			dissect_smb2_ioctl_data(ioctl_tvb, pinfo, tree, top_tree, nti->ioctl_function, TRUE);

		offset += bc;

		break;
	case NT_TRANS_SSD:
		if (nti)
		{
			switch (nti->fid_type)
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
			tvb, offset, pinfo, tree, NULL, TRUE, bc, ami);
		break;
	case NT_TRANS_NOTIFY:
		break;
	case NT_TRANS_RENAME:

		break;
	case NT_TRANS_QSD:
		break;
	case NT_TRANS_GET_USER_QUOTA:

		proto_tree_add_item(tree, hf_smb_unknown, tvb,
							offset, 4, TRUE);
		offset += 4;

		proto_tree_add_text(tree, tvb, offset, 4, "Length of SID: %d", tvb_get_letohl(tvb, offset));
		offset += 4;

		offset = dissect_nt_sid(tvb, offset, tree, "Quota", NULL, -1);
		break;
	case NT_TRANS_SET_USER_QUOTA:
		offset = dissect_nt_user_quota(tvb, tree, offset, &bcp);
		break;
	}

	if ((offset - old_offset) < bc)
	{
		proto_tree_add_item(tree, hf_smb_unknown, tvb, offset,
							bc - (offset - old_offset), TRUE);
		offset += bc - (offset - old_offset);
	}

	return offset;
}

static int
dissect_nt_transaction_request(tvbuff_t *tvb, packet_info *pinfo _U_, proto_tree *tree, int offset, proto_tree *smb_tree _U_)
{
	guint8 wc, sc;
	guint32 pc = 0, po = 0, pd, dc = 0, od = 0, dd;
	smb_info_t *si;
	smb_saved_info_t *sip;
	int subcmd;
	nt_trans_data ntd;
	guint16 bc;
	guint32 padcnt;
	smb_nt_transact_info_t *nti = NULL;

	ntd.subcmd = ntd.sd_len = ntd.ea_len = 0;

	si = (smb_info_t *)pinfo->private_data;
	DISSECTOR_ASSERT(si);
	sip = si->sip;

	WORD_COUNT;

	if (wc >= 19)
	{

		proto_tree_add_item(tree, hf_smb_max_setup_count, tvb, offset, 1, TRUE);
		offset += 1;

		proto_tree_add_item(tree, hf_smb_reserved, tvb, offset, 2, TRUE);
		offset += 2;
	}
	else
	{

		proto_tree_add_item(tree, hf_smb_reserved, tvb, offset, 3, TRUE);
		offset += 3;
	}

	proto_tree_add_item(tree, hf_smb_total_param_count, tvb, offset, 4, TRUE);
	offset += 4;

	proto_tree_add_item(tree, hf_smb_total_data_count, tvb, offset, 4, TRUE);
	offset += 4;

	if (wc >= 19)
	{

		proto_tree_add_item(tree, hf_smb_max_param_count, tvb, offset, 4, TRUE);
		offset += 4;

		proto_tree_add_item(tree, hf_smb_max_data_count, tvb, offset, 4, TRUE);
		offset += 4;
	}

	pc = tvb_get_letohl(tvb, offset);
	proto_tree_add_uint(tree, hf_smb_param_count32, tvb, offset, 4, pc);
	offset += 4;

	po = tvb_get_letohl(tvb, offset);
	proto_tree_add_uint(tree, hf_smb_param_offset32, tvb, offset, 4, po);
	offset += 4;

	if (wc >= 19)
	{

		pd = 0;
	}
	else
	{

		pd = tvb_get_letohl(tvb, offset);
		proto_tree_add_uint(tree, hf_smb_param_disp32, tvb, offset, 4, pd);
		offset += 4;
	}

	dc = tvb_get_letohl(tvb, offset);
	proto_tree_add_uint(tree, hf_smb_data_count32, tvb, offset, 4, dc);
	offset += 4;

	od = tvb_get_letohl(tvb, offset);
	proto_tree_add_uint(tree, hf_smb_data_offset32, tvb, offset, 4, od);
	offset += 4;

	if (wc >= 19)
	{

		dd = 0;
	}
	else
	{

		dd = tvb_get_letohl(tvb, offset);
		proto_tree_add_uint(tree, hf_smb_data_disp32, tvb, offset, 4, dd);
		offset += 4;
	}

	if (wc >= 19)
	{

		sc = tvb_get_guint8(tvb, offset);
		proto_tree_add_uint(tree, hf_smb_setup_count, tvb, offset, 1, sc);
		offset += 1;
	}
	else
	{

		sc = 0;
	}

	if (wc >= 19)
	{

		subcmd = tvb_get_letohs(tvb, offset);
		proto_tree_add_uint(tree, hf_smb_nt_trans_subcmd, tvb, offset, 2, subcmd);
		if (check_col(pinfo->cinfo, COL_INFO))
		{
			col_append_fstr(pinfo->cinfo, COL_INFO, ", %s",
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
				sip->extra_info = nti;
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

		if (check_col(pinfo->cinfo, COL_INFO))
		{
			col_append_str(pinfo->cinfo, COL_INFO, " (secondary request)");
		}
	}
	offset += 2;

	if (offset % 1)
	{

		proto_tree_add_item(tree, hf_smb_padding, tvb, offset, 1, TRUE);
		offset += 1;
	}

	if (sc)
	{
		dissect_nt_trans_setup_request(tvb, pinfo, offset, tree, sc * 2, &ntd);
		offset += sc * 2;
	}

	BYTE_COUNT;

	if (po > (guint32)offset)
	{

		padcnt = po - offset;
		if (padcnt > bc)
			padcnt = bc;
		CHECK_BYTE_COUNT(padcnt);
		proto_tree_add_item(tree, hf_smb_padding, tvb, offset, padcnt, TRUE);
		COUNT_BYTES(padcnt);
	}
	if (pc)
	{
		CHECK_BYTE_COUNT(pc);
		dissect_nt_trans_param_request(tvb, pinfo, offset, tree, pc, &ntd, bc, nti);
		COUNT_BYTES(pc);
	}

	if (od > (guint32)offset)
	{

		padcnt = od - offset;
		if (padcnt > bc)
			padcnt = bc;
		proto_tree_add_item(tree, hf_smb_padding, tvb, offset, padcnt, TRUE);
		COUNT_BYTES(padcnt);
	}
	if (dc)
	{
		CHECK_BYTE_COUNT(dc);
		dissect_nt_trans_data_request(tvb, pinfo, offset, tree, dc, &ntd, nti);
		COUNT_BYTES(dc);
	}

	END_OF_SMB

	return offset;
}
