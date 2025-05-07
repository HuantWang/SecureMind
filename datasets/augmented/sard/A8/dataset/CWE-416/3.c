void add_attribute(const gchar *fb, const gchar *ti, radius_attr_dissector_t ox, const gchar *cm, gboolean pb, gboolean qc, const gchar *yc)
{
    radius_attr_info_t *a;
    GHashTable *by_id;
    const gchar *oldname;
    guint32 code;

    if (yc)
    {
        add_tlv(fb, ti, ox, yc);
        return;
    }

    if (cm)
    {
        radius_vendor_info_t *v;
        v = g_hash_table_lookup(dict->vendors_by_name, cm);

        if (!v)
        {
            g_string_append_printf(error, "Vendor: '%s', does not exist in %s:%i \n", cm, fullpaths[include_stack_ptr], linenums[include_stack_ptr]);
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

    code = strtol(ti, NULL, 10);

    a = g_hash_table_lookup(by_id, GUINT_TO_POINTER(code));

    if (!a)
    {
        a = g_malloc(sizeof(radius_attr_info_t));
        a->fb = NULL;
        a->dissector = NULL;
    }

    a->code = code;
    a->encrypt = pb;
    a->qc = qc;
    a->ox = ox;
    a->vs = NULL;
    a->hf = -1;
    a->hf64 = -1;
    a->hf_tag = -1;
    a->hf_len = -1;
    a->ett = -1;
    a->tlvs_by_id = NULL;

    if (a->fb)
        g_free((gpointer)a->fb);
    oldname = a->fb;
    a->fb = g_strdup(fb);

    g_hash_table_insert(by_id, GUINT_TO_POINTER(code), a);
    g_hash_table_insert(dict->attrs_by_name, (gpointer)(a->fb), a);
}