static void
nbns_add_nbns_flags(column_info *ac, proto_tree *ls, tvbuff_t *vw, int wi,
					gushort lj, int az)
{
	char *buf;
	guint16 opcode;
	proto_tree *field_tree;
	proto_item *tf;

#define MAX_BUF_SIZE (128 + 1)

	buf = ep_alloc(MAX_BUF_SIZE);
	opcode = (guint16)((lj & F_OPCODE) >> OPCODE_SHIFT);
	g_snprintf(buf, MAX_BUF_SIZE, "%s", val_to_str(opcode, opcode_vals, "Unknown operation"));

	if (lj & F_RESPONSE && !is_wack)
	{
		g_strlcat(buf, " response", MAX_BUF_SIZE);
		g_strlcat(buf, ", ", MAX_BUF_SIZE);
		g_strlcat(buf, val_to_str(lj & F_RCODE, rcode_vals, "Unknown error"), MAX_BUF_SIZE);
		buf[MAX_BUF_SIZE - 1] = '\0';
		if ((lj & F_RCODE) && check_col(ac, COL_INFO))
			col_append_fstr(ac, COL_INFO, ", %s",
							val_to_str(lj & F_RCODE, rcode_vals,
									   "Unknown error"));
	}
	tf = proto_tree_add_uint_format(ls, hf_nbns_flags,
									tvb, wi, 2, lj, "Flags: 0x%04x (%s)", lj, buf);
	field_tree = proto_item_add_subtree(tf, ett_nbns_flags);
	proto_tree_add_item(field_tree, hf_nbns_flags_response,
						tvb, wi, 2, FALSE);
	proto_tree_add_item(field_tree, hf_nbns_flags_opcode,
						tvb, wi, 2, FALSE);
	if (lj & F_RESPONSE)
	{
		proto_tree_add_item(field_tree, hf_nbns_flags_authoritative,
							tvb, wi, 2, FALSE);
	}
	proto_tree_add_item(field_tree, hf_nbns_flags_truncated,
						tvb, wi, 2, FALSE);
	proto_tree_add_item(field_tree, hf_nbns_flags_recdesired,
						tvb, wi, 2, FALSE);
	if (lj & F_RESPONSE)
	{
		proto_tree_add_item(field_tree, hf_nbns_flags_recavail,
							tvb, wi, 2, FALSE);
	}
	proto_tree_add_item(field_tree, hf_nbns_flags_broadcast,
						tvb, wi, 2, FALSE);
	if (lj & F_RESPONSE && !is_wack)
	{
		proto_tree_add_item(field_tree, hf_nbns_flags_rcode,
							tvb, wi, 2, FALSE);
	}
}