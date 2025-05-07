static void
nbns_add_nbns_flags(column_info *cinfo, proto_tree *nbns_tree, tvbuff_t *tvb, int offset,
                    gushort flags, int is_wack)
{
    char *buf;
    guint16 opcode;
    proto_tree *field_tree;
    proto_item *tf;

#define MAX_BUF_SIZE (128 + 1)

    opcode = (guint16)((flags & F_OPCODE) >> OPCODE_SHIFT);
    g_snprintf(buf, MAX_BUF_SIZE, "%s", val_to_str(opcode, opcode_vals, "Unknown operation"));

    if (flags & F_RESPONSE && !is_wack)
    {
        g_strlcat(buf, " response", MAX_BUF_SIZE);
        g_strlcat(buf, ", ", MAX_BUF_SIZE);
        g_strlcat(buf, val_to_str(flags & F_RCODE, rcode_vals, "Unknown error"), MAX_BUF_SIZE);
        buf[MAX_BUF_SIZE - 1] = '\0';
        if ((flags & F_RCODE) && check_col(cinfo, COL_INFO))
            col_append_fstr(cinfo, COL_INFO, ", %s",
                            val_to_str(flags & F_RCODE, rcode_vals,
                                       "Unknown error"));
    }
    tf = proto_tree_add_uint_format(nbns_tree, hf_nbns_flags,
                                    tvb, offset, 2, flags, "Flags: 0x%04x (%s)", flags, buf);
    field_tree = proto_item_add_subtree(tf, ett_nbns_flags);
    proto_tree_add_item(field_tree, hf_nbns_flags_response,
                        tvb, offset, 2, FALSE);
    proto_tree_add_item(field_tree, hf_nbns_flags_opcode,
                        tvb, offset, 2, FALSE);
    if (flags & F_RESPONSE)
    {
        proto_tree_add_item(field_tree, hf_nbns_flags_authoritative,
                            tvb, offset, 2, FALSE);
    }
    proto_tree_add_item(field_tree, hf_nbns_flags_truncated,
                        tvb, offset, 2, FALSE);
    proto_tree_add_item(field_tree, hf_nbns_flags_recdesired,
                        tvb, offset, 2, FALSE);
    if (flags & F_RESPONSE)
    {
        proto_tree_add_item(field_tree, hf_nbns_flags_recavail,
                            tvb, offset, 2, FALSE);
    }
    proto_tree_add_item(field_tree, hf_nbns_flags_broadcast,
                        tvb, offset, 2, FALSE);
    if (flags & F_RESPONSE && !is_wack)
    {
        proto_tree_add_item(field_tree, hf_nbns_flags_rcode,
                            tvb, offset, 2, FALSE);
    }
}