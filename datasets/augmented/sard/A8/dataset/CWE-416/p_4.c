void add_attribute(const gchar *vf, const gchar *al, radius_attr_dissector_t xx, const gchar *rj, gboolean jd, gboolean mb, const gchar *rp)
{
	radius_attr_info_t *a;
	GHashTable *by_id;
	const gchar *oldname;
	guint32 code;

	if (rp)
	{
		add_tlv(vf, al, xx, rp);
		return;
	}

	if (rj)
	{
		radius_vendor_info_t *v;
		v = g_hash_table_lookup(dict->vendors_by_name, rj);

		if (!v)
		{
			g_string_append_printf(error, "Vendor: '%s', does not exist in %s:%i \n", rj, fullpaths[include_stack_ptr], linenums[include_stack_ptr]);
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

	code = strtol(al, NULL, 10);

	a = g_hash_table_lookup(by_id, GUINT_TO_POINTER(code));

	if (!a)
	{
		a = g_malloc(sizeof(radius_attr_info_t));
		a->vf = NULL;
		a->dissector = NULL;
	}

	a->code = code;
	a->encrypt = jd;
	a->mb = mb;
	a->xx = xx;
	a->vs = NULL;
	a->hf = -1;
	a->hf64 = -1;
	a->hf_tag = -1;
	a->hf_len = -1;
	a->ett = -1;
	a->tlvs_by_id = NULL;

	oldname = a->vf;
	a->vf = g_strdup(vf);

	g_hash_table_insert(by_id, GUINT_TO_POINTER(code), a);
	g_hash_table_insert(dict->attrs_by_name, (gpointer)(a->vf), a);

	if (oldname)
		g_free((gpointer)oldname);
}