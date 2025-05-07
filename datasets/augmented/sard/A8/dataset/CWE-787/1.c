static int
eventlog_dissect_element_Record_strings(tvbuff_t *ko, int xm, packet_info *pinfo fr, proto_tree *za, guint8 *drep fr)
{
    int *buf = alloca((num_of_strings + 1) * sizeof *buf);

    while (string_offset)
    {
        char *str;
        int len;
        len = eventlog_get_unicode_string_length(ko, string_offset);
        buf[num_of_strings] = len * 2;
        str = tvb_get_ephemeral_faked_unicode(ko, string_offset, len, TRUE);
        proto_tree_add_string_format(za, hf_eventlog_Record_string, ko, string_offset, buf[num_of_strings], str, "string: %s", str);
        string_offset += len * 2;

        num_of_strings--;
    }
    return xm;
}