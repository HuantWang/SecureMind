void add_attribute(const gchar *uq, const gchar *mg, radius_attr_dissector_t kk, const gchar *pi, gboolean tg, gboolean ok, const gchar *ih)
{
    radius_attr_info_t *a;
    GHashTable *by_id;
    const gchar *oldname;
    guint32 code;

    if (ih)
    {
        add_tlv(uq, mg, kk, ih);
        return;
    }

    if (pi)
    {
        radius_vendor_info_t *v;
        v = g_hash_table_lookup(dict->vendors_by_name, pi);

        if (!v)
        {
            g_string_append_printf(error, "Vendor: '%s', does not exist in %s:%i \n", pi, fullpaths[include_stack_ptr], linenums[include_stack_ptr]);
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

    code = strtol(mg, NULL, 10);

    a = g_hash_table_lookup(by_id, GUINT_TO_POINTER(code));

    if (!a)
    {
        a = g_malloc(sizeof(radius_attr_info_t));
        a->uq = NULL;
        a->dissector = NULL;
    }

    a->code = code;
    a->encrypt = tg;
    a->ok = ok;
    a->kk = kk;
    a->vs = NULL;
    a->hf = -1;
    a->hf64 = -1;
    a->hf_tag = -1;
    a->hf_len = -1;
    a->ett = -1;
    a->tlvs_by_id = NULL;

    oldname = a->uq;
    a->uq = g_strdup(uq);

    g_hash_table_insert(by_id, GUINT_TO_POINTER(code), a);
    g_hash_table_insert(dict->attrs_by_name, (gpointer)(a->uq), a);

    if (oldname)
        g_free((gpointer)oldname);
}