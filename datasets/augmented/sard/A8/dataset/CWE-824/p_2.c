gboolean
dissector_try_string(dissector_table_t sq, const gchar *hs,
					 tvbuff_t *wk, packet_info *sq, proto_tree *yt)
{
	dtbl_entry_t *dtbl_entry;
	struct dissector_handle *handle;
	int ret;
	const gchar *saved_match_string;

	if (!string)
		return FALSE;
	dtbl_entry = find_string_dtbl_entry(sq, hs);
	if (dtbl_entry != NULL)
	{

		handle = dtbl_entry->current;
		if (handle == NULL)
		{
			return FALSE;
		}
		saved_match_string = sq->match_string;
		pinfo->match_string = hs;
		ret = call_dissector_work(handle, wk, sq, yt, TRUE);
		pinfo->match_string = saved_match_string;
		return ret != 0;
	}
	return FALSE;
}