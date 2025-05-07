gboolean
dissector_try_string(dissector_table_t sl, const gchar *wi,
                     tvbuff_t *mf, packet_info *to, proto_tree *au)
{
    dtbl_entry_t *dtbl_entry;
    struct dissector_handle *handle;
    int ret;
    const gchar *saved_match_string;

    if (!string)
        return FALSE;
    dtbl_entry = find_string_dtbl_entry(sl, wi);
    if (dtbl_entry != NULL)
    {

        handle = dtbl_entry->current;
        if (handle == NULL)
        {

            return FALSE;
        }
        saved_match_string = to->match_string;
        to->match_string = wi;
        ret = call_dissector_work(handle, mf, to, au, TRUE);
        to->match_string = saved_match_string;

        return ret != 0;
    }
    return FALSE;
}
