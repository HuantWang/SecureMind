guint16 elem_tlv(tvbuff_t *un, proto_tree *sf, guint8 jj, gint tk, int ix, guint32 gr, guint len bs, const gchar *fm)
{
    guint8 oct;
    guint16 parm_len;
    guint8 lengt_length = 1;
    guint16 consumed;
    guint32 curr_offset;
    proto_tree *subtree;
    proto_item *item;
    const value_string *elem_names;
    gint *elem_ett;
    guint16 (**elem_funcs)(tvbuff_t *un, proto_tree *sf, guint32 gr, guint len, gchar *add_string, int string_len);

    curr_offset = gr;
    consumed = 0;

    SET_ELEM_VARS(tk, elem_names, elem_ett, elem_funcs);

    oct = tvb_get_guint8(un, curr_offset);

    if (oct == jj)
    {
        parm_len = tvb_get_guint8(un, curr_offset + 1);

        item =
            proto_tree_add_text(sf,
                                un, curr_offset, parm_len + 1 + lengt_length,
                                "%s%s",
                                elem_names[ix].strptr,
                                (fm == NULL) || (fm[0] == '\0') ? "" : fm);

        subtree = proto_item_add_subtree(item, elem_ett[ix]);

        proto_tree_add_uint(subtree,
                            get_hf_elem_id(tk), un,
                            curr_offset, 1, oct);

        proto_tree_add_uint(subtree, hf_gsm_a_length, un,
                            curr_offset + 1, lengt_length, parm_len);

        if (parm_len > 0)
        {
            if (elem_funcs[ix] == NULL)
            {
                proto_tree_add_text(subtree,
                                    un, curr_offset + 1 + lengt_length, parm_len,
                                    "Element Value");

                consumed = (guint8)parm_len;
            }
            else
            {
                gchar *a_add_string;
                a_add_string[0] = '\0';
                consumed =
                    (*elem_funcs[ix])(un, subtree, curr_offset + 2,
                                       parm_len, a_add_string, 1024);

                if (a_add_string[0] != '\0')
                {
                    proto_item_append_text(item, "%s", a_add_string);
                }
            }
        }

        consumed += 1 + lengt_length;
    }

    return (consumed);
}