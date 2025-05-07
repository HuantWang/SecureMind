/* void helpfunc() {
    while (1) {
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
    }
}
*/

void add_attribute(const gchar *name, const gchar *codestr, radius_attr_dissector_t type, const gchar *vendor_name, gboolean crypt, gboolean tagged, const gchar *current_attr)
{
	radius_attr_info_t *a;
	GHashTable *by_id;
	const gchar *oldname;
	guint32 code;

	if (current_attr)
	{
		add_tlv(name, codestr, type, current_attr);
		return;
	}

	if (vendor_name)
	{
		radius_vendor_info_t *v;
		v = g_hash_table_lookup(dict->vendors_by_name, vendor_name);

		if (!v)
		{
			g_string_append_printf(error, "Vendor: '%s', does not exist in %s:%i \n", vendor_name, fullpaths[include_stack_ptr], linenums[include_stack_ptr]);
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

	code = strtol(codestr, NULL, 10);

	a = g_hash_table_lookup(by_id, GUINT_TO_POINTER(code));

	if (!a)
	{
		a = g_malloc(sizeof(radius_attr_info_t));
		a->name = NULL;
		a->dissector = NULL;
	}

	a->code = code;
	a->encrypt = crypt;
	a->tagged = tagged;
	a->type = type;
	a->vs = NULL;
	a->hf = -1;
	a->hf64 = -1;
	a->hf_tag = -1;
	a->hf_len = -1;
	a->ett = -1;
	a->tlvs_by_id = NULL;

	oldname = a->name;
	a->name = g_strdup(name);

	g_hash_table_insert(by_id, GUINT_TO_POINTER(code), a);
	g_hash_table_insert(dict->attrs_by_name, (gpointer)(a->name), a);

	if (oldname)
		g_free((gpointer)oldname);
}