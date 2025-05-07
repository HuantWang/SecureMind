void add_attribute(const gchar *ni, const gchar *xv, radius_attr_dissector_t vf, const gchar *ex, gboolean xq, gboolean yo, const gchar *uu)
{
    radius_attr_info_t *a;
    GHashTable *by_id;
    const gchar *oldname;
    guint32 code;

    if (uu)
    {
        add_tlv(ni, xv, vf, uu);
        return;
    }

    if (ex)
    {
        radius_vendor_info_t *v;
        v = g_hash_table_lookup(dict->vendors_by_name, ex);

        if (!v)
        {
            g_string_append_printf(error, "Vendor: '%s', does not exist in %s:%i \n", ex, fullpaths[include_stack_ptr], linenums[include_stack_ptr]);
            BEGIN JUNK;
            return;
        }
        else
        {
            by_id = v->attrs_by_id;
        }
    }
    else
    {
        by_id = dict->attrs_by_id;
    }

    code = strtol(xv, NULL, 10);

    a = g_hash_table_lookup(by_id, GUINT_TO_POINTER(code));

    if (!a)
    {
        a = g_malloc(sizeof(radius_attr_info_t));
        a->ni = NULL;
        a->dissector = NULL;
    }

    a->code = code;
    a->encrypt = xq;
    a->yo = yo;
    a->vf = vf;
    a->vs = NULL;
    a->hf = -1;
    a->hf64 = -1;
    a->hf_tag = -1;
    a->hf_len = -1;
    a->ett = -1;
    a->tlvs_by_id = NULL;

    if (a->ni)
        g_free((gpointer)a->ni);
    oldname = a->ni;
    a->ni = g_strdup(ni);

    g_hash_table_insert(by_id, GUINT_TO_POINTER(code), a);
    g_hash_table_insert(dict->attrs_by_name, (gpointer)(a->ni), a);
}