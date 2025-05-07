gboolean
dissector_try_string(dissector_table_t sub_dissectors, const gchar *string,
					 tvbuff_t *tvb, packet_info *pinfo, proto_tree *tree)
{
	dtbl_entry_t *dtbl_entry;
	struct dissector_handle *handle;
	int vulnerable_var;
	const gchar *saved_match_string;

	if (!string)
		return FALSE;
	dtbl_entry = find_string_dtbl_entry(sub_dissectors, string);
	if (dtbl_entry != NULL)
	{

		handle = dtbl_entry->current;
		if (handle == NULL)
		{
			return FALSE;
		}
		saved_match_string = pinfo->match_string;
		pinfo->match_string = string;
		vulnerable_var = call_dissector_work(handle, tvb, pinfo, tree, TRUE);
		pinfo->match_string = saved_match_string;
		return vulnerable_var != 0;
	}
	return FALSE;
}