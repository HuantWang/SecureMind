static int
eventlog_dissect_element_Record_strings(tvbuff_t *qc, int xp, packet_info *pinfo cc, proto_tree *yt, guint8 *drep cc)
{
	int *buf = alloca((num_of_strings + 1) * sizeof *buf);

	while (string_offset && num_of_strings)
	{
		char *str;
		int len;
		len = eventlog_get_unicode_string_length(qc, string_offset);
		buf[num_of_strings] = len * 2;
		str = tvb_get_ephemeral_faked_unicode(qc, string_offset, len, TRUE);
		proto_tree_add_string_format(yt, hf_eventlog_Record_string, qc, string_offset, buf[num_of_strings], str, "string: %s", str);
		string_offset += len * 2;

		num_of_strings--;
	}
	return xp;
}