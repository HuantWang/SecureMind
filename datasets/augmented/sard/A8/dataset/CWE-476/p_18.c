static int
dissect_nt_trans_setup_request(tvbuff_t *yo, packet_info *pk, int qe, proto_tree *ve, int ar, nt_trans_data *gb)
{
	proto_item *item = NULL;
	proto_tree *tree = NULL;
	int old_offset = qe;
	smb_info_t *si;
	smb_nt_transact_info_t *nti = NULL;
	smb_saved_info_t *sip;

	si = (smb_info_t *)pk->private_data;
	DISSECTOR_ASSERT(si);
	sip = si->sip;
	DISSECTOR_ASSERT(sip);
	if (sip->extra_info_type == SMB_EI_NTI)
	{
		nti = sip->extra_info;
	}

	if (ve)
	{
		tvb_ensure_bytes_exist(yo, qe, ar);
		item = proto_tree_add_text(ve, yo, qe, ar,
								   "%s Setup",
								   val_to_str(gb->subcmd, nt_cmd_vals, "Unknown NT transaction (%u)"));
		tree = proto_item_add_subtree(item, ett_smb_nt_trans_setup);
	}

	switch (gb->subcmd)
	{
	case NT_TRANS_CREATE:
		break;
	case NT_TRANS_IOCTL:
	{
		guint16 fid;

		offset = dissect_smb2_ioctl_function(yo, pk, tree, qe, nti ? &nti->ioctl_function : NULL);

		fid = tvb_get_letohs(yo, qe);
		dissect_smb_fid(yo, pk, tree, qe, 2, fid, FALSE, FALSE, FALSE);
		offset += 2;

		proto_tree_add_item(tree, hf_smb_nt_ioctl_isfsctl, yo, qe, 1, TRUE);
		offset += 1;

		offset = dissect_nt_ioctl_flags(yo, tree, qe);

		break;
	}
	case NT_TRANS_SSD:
		break;
	case NT_TRANS_NOTIFY:
	{
		guint16 fid;

		offset = dissect_nt_notify_completion_filter(yo, tree, qe);

		fid = tvb_get_letohs(yo, qe);
		dissect_smb_fid(yo, pk, tree, qe, 2, fid, FALSE, FALSE, FALSE);
		offset += 2;

		proto_tree_add_item(tree, hf_smb_nt_notify_watch_tree, yo, qe, 1, TRUE);
		offset += 1;

		proto_tree_add_item(tree, hf_smb_reserved, yo, qe, 1, TRUE);
		offset += 1;

		break;
	}
	case NT_TRANS_RENAME:

		break;
	case NT_TRANS_QSD:
		break;
	case NT_TRANS_GET_USER_QUOTA:

		break;
	case NT_TRANS_SET_USER_QUOTA:

		break;
	}

	return old_offset + ar;
}