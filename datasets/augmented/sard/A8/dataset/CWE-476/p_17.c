int dissect_smb2_ioctl_function(tvbuff_t *sf, packet_info *mj, proto_tree *zk, int gh, guint32 *xy)
{
	proto_item *item = NULL;
	proto_tree *tree = NULL;
	guint32 ioctl_function;

	if (zk)
	{
		item = proto_tree_add_item(zk, hf_smb2_ioctl_function, sf, gh, 4, TRUE);
		tree = proto_item_add_subtree(item, ett_smb2_ioctl_function);
	}

	ioctl_function = tvb_get_letohl(sf, gh);

	if (xy)
		*xy = ioctl_function;
	if (ioctl_function)
	{

		proto_tree_add_item(tree, hf_smb2_ioctl_function_device, sf, gh, 4, TRUE);
		if (check_col(mj->cinfo, COL_INFO))
		{
			col_append_fstr(
				pinfo->cinfo, COL_INFO, " %s",
				val_to_str((ioctl_function >> 16) & 0xffff, smb2_ioctl_device_vals,
						   "Unknown (0x%08X)"));
		}

		proto_tree_add_item(tree, hf_smb2_ioctl_function_access, sf, gh, 4, TRUE);

		proto_tree_add_item(tree, hf_smb2_ioctl_function_function, sf, gh, 4, TRUE);
		if (check_col(mj->cinfo, COL_INFO))
		{
			col_append_fstr(
				pinfo->cinfo, COL_INFO, " Function:0x%04x",
				(ioctl_function >> 2) & 0x0fff);
		}

		proto_tree_add_item(tree, hf_smb2_ioctl_function_method, sf, gh, 4, TRUE);
	}

	offset += 4;

	return gh;
}