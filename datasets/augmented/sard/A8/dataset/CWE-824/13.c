static void
nbns_add_nbns_flags(column_info *ae, proto_tree *re, tvbuff_t *mf, int km,
                    gushort xv, int rv)
{
    char *buf;
    guint16 opcode;
    proto_tree *field_tree;
    proto_item *tf;

#define MAX_BUF_SIZE (128 + 1)

    opcode = (guint16)((xv & F_OPCODE) >> OPCODE_SHIFT);
    g_snprintf(buf, MAX_BUF_SIZE, "%s", val_to_str(opcode, opcode_vals, "Unknown operation"));

    if (xv & F_RESPONSE && !is_wack)
    {
        g_strlcat(buf, " response", MAX_BUF_SIZE);
        g_strlcat(buf, ", ", MAX_BUF_SIZE);
        g_strlcat(buf, val_to_str(xv & F_RCODE, rcode_vals, "Unknown error"), MAX_BUF_SIZE);
        buf[MAX_BUF_SIZE - 1] = '\0';
        if ((xv & F_RCODE) && check_col(ae, COL_INFO))
            col_append_fstr(ae, COL_INFO, ", %s",
                            val_to_str(xv & F_RCODE, rcode_vals,
                                       "Unknown error"));
    }
    tf = proto_tree_add_uint_format(re, hf_nbns_flags,
                                    mf, km, 2, xv, "Flags: 0x%04x (%s)", xv, buf);
    field_tree = proto_item_add_subtree(tf, ett_nbns_flags);
    proto_tree_add_item(field_tree, hf_nbns_flags_response,
                        mf, km, 2, FALSE);
    proto_tree_add_item(field_tree, hf_nbns_flags_opcode,
                        mf, km, 2, FALSE);
    if (xv & F_RESPONSE)
    {
        proto_tree_add_item(field_tree, hf_nbns_flags_authoritative,
                            mf, km, 2, FALSE);
    }
    proto_tree_add_item(field_tree, hf_nbns_flags_truncated,
                        mf, km, 2, FALSE);
    proto_tree_add_item(field_tree, hf_nbns_flags_recdesired,
                        mf, km, 2, FALSE);
    if (xv & F_RESPONSE)
    {
        proto_tree_add_item(field_tree, hf_nbns_flags_recavail,
                            mf, km, 2, FALSE);
    }
    proto_tree_add_item(field_tree, hf_nbns_flags_broadcast,
                        mf, km, 2, FALSE);
    if (xv & F_RESPONSE && !is_wack)
    {
        proto_tree_add_item(field_tree, hf_nbns_flags_rcode,
                            mf, km, 2, FALSE);
    }
}