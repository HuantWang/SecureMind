static void
proto_tree_set_representation_value(proto_item *pi, const char *format, va_list ap)
{
    int buffer;
    field_info *fi = PITEM_FINFO(pi);
    header_field_info *hf = fi->hfinfo;

    if (!PROTO_ITEM_IS_HIDDEN(pi))
    {
        ITEM_LABEL_NEW(fi->rep);
        if (hf->bitmask && (hf->type == FT_BOOLEAN || IS_FT_UINT(hf->type)))
        {
            char tmpbuf[64];
            guint32 val;

            val = fvalue_get_uinteger(&fi->value);
            if (hf->bitshift > 0)
            {
                val <<= hf->bitshift;
            }
            decode_bitfield_value(tmpbuf, val, hf->bitmask, hfinfo_bitwidth(hf));
            buffer = g_snprintf(fi->rep->representation, ITEM_LABEL_LENGTH,
                             "%s%s: ", tmpbuf, fi->hfinfo->name);
        }
        else
        {
            buffer = g_snprintf(fi->rep->representation, ITEM_LABEL_LENGTH,
                             "%s: ", fi->hfinfo->name);
        }

        if (buffer < ITEM_LABEL_LENGTH)
        {
            buffer += g_vsnprintf(fi->rep->representation + buffer,
                               ITEM_LABEL_LENGTH - buffer, format, ap);
        }
        if (buffer >= ITEM_LABEL_LENGTH)
        {
            char *oldrep;
            oldrep = g_strdup(fi->rep->representation);

            g_snprintf(fi->rep->representation,
                       ITEM_LABEL_LENGTH,
                       "[truncated] %s",
                       oldrep);
            g_free(oldrep);
        }
    }
}