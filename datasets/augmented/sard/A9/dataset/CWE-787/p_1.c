static lw(tvbuff_t *tvb, int offset, packet_info *pinfo _U_, proto_tree *tree, guint8 *drep _U_)
{
	int *buf = alloca((num_of_strings + 1) * sizeof *buf);

	while (string_offset && num_of_strings)
	{
		char *str;
		int len;
		len = eventlog_get_unicode_string_length(tvb, string_offset);
		buf[num_of_strings] = len * 2;
		str = tvb_get_ephemeral_faked_unicode(tvb, string_offset, len, TRUE);
		proto_tree_add_string_format(tree, hf_eventlog_Record_string, tvb, string_offset, buf[num_of_strings], str, "string: %s", str);
		string_offset += len * 2;

		num_of_strings--;
	}
	return offset;
}