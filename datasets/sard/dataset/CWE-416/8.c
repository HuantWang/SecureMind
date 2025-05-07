static void register_attrs(gpointer k _U_, gpointer v, gpointer p)
{
    radius_attr_info_t *a = v;
    int i;
    gint *ett = &(a->ett);
    gchar *abbrev = g_strconcat("radius.", a->name, NULL);
    hf_register_info hfri[] = {
        {NULL, {NULL, NULL, FT_NONE, BASE_NONE, NULL, 0x0, "", HFILL}},
        {NULL, {NULL, NULL, FT_UINT8, BASE_DEC, NULL, 0x0, "", HFILL}},
        {NULL, {NULL, NULL, FT_NONE, BASE_NONE, NULL, 0x0, "", HFILL}},
        {NULL, {NULL, NULL, FT_NONE, BASE_NONE, NULL, 0x0, "", HFILL}}};
    guint len_hf = 2;
    hfett_t *ri = p;

    for (i = 0; abbrev[i]; i++)
    {
        if (abbrev[i] == '-')
            abbrev[i] = '_';
        if (abbrev[i] == '/')
            abbrev[i] = '_';
    }

    hfri[0].p_id = &(a->hf);
    hfri[1].p_id = &(a->hf_len);

    hfri[0].hfinfo.name = a->name;
    hfri[0].hfinfo.abbrev = abbrev;

    hfri[1].hfinfo.name = "Length";
    hfri[1].hfinfo.abbrev = g_strconcat(abbrev, ".len", NULL);
    hfri[1].hfinfo.blurb = g_strconcat(a->name, " Length", NULL);

    if (a->type == radius_integer)
    {
        hfri[0].hfinfo.type = FT_UINT32;
        hfri[0].hfinfo.display = BASE_DEC;

        hfri[2].p_id = &(a->hf64);
        hfri[2].hfinfo.name = g_strdup(a->name);
        hfri[2].hfinfo.abbrev = abbrev;
        hfri[2].hfinfo.type = FT_UINT64;
        hfri[2].hfinfo.display = BASE_DEC;

        if (a->vs)
        {
            hfri[0].hfinfo.strings = VALS(a->vs);
        }

        len_hf++;
    }
    else if (a->type == radius_signed)
    {
        hfri[0].hfinfo.type = FT_INT32;
        hfri[0].hfinfo.display = BASE_DEC;

        hfri[2].p_id = &(a->hf64);
        hfri[2].hfinfo.name = g_strdup(a->name);
        hfri[2].hfinfo.abbrev = abbrev;
        hfri[2].hfinfo.type = FT_INT64;
        hfri[2].hfinfo.display = BASE_DEC;

        if (a->vs)
        {
            hfri[0].hfinfo.strings = VALS(a->vs);
        }

        len_hf++;
    }
    else if (a->type == radius_string)
    {
        hfri[0].hfinfo.type = FT_STRING;
        hfri[0].hfinfo.display = BASE_NONE;
    }
    else if (a->type == radius_octets)
    {
        hfri[0].hfinfo.type = FT_BYTES;
        hfri[0].hfinfo.display = BASE_NONE;
    }
    else if (a->type == radius_ipaddr)
    {
        hfri[0].hfinfo.type = FT_IPv4;
        hfri[0].hfinfo.display = BASE_NONE;
    }
    else if (a->type == radius_ipv6addr)
    {
        hfri[0].hfinfo.type = FT_IPv6;
        hfri[0].hfinfo.display = BASE_NONE;
    }
    else if (a->type == radius_ipv6prefix)
    {
        hfri[0].hfinfo.type = FT_BYTES;
        hfri[0].hfinfo.display = BASE_NONE;
    }
    else if (a->type == radius_ipxnet)
    {
        hfri[0].hfinfo.type = FT_IPXNET;
        hfri[0].hfinfo.display = BASE_NONE;
    }
    else if (a->type == radius_date)
    {
        hfri[0].hfinfo.type = FT_ABSOLUTE_TIME;
        hfri[0].hfinfo.display = BASE_NONE;
    }
    else if (a->type == radius_abinary)
    {
        hfri[0].hfinfo.type = FT_BYTES;
        hfri[0].hfinfo.display = BASE_NONE;
    }
    else if (a->type == radius_ifid)
    {
        hfri[0].hfinfo.type = FT_BYTES;
        hfri[0].hfinfo.display = BASE_NONE;
    }
    else if (a->type == radius_combo_ip)
    {
        hfri[0].hfinfo.type = FT_IPv4;
        hfri[0].hfinfo.display = BASE_NONE;

        hfri[2].p_id = &(a->hf64);
        hfri[2].hfinfo.name = g_strdup(a->name);
        hfri[2].hfinfo.abbrev = g_strdup(abbrev);
        hfri[2].hfinfo.type = FT_IPv6;
        hfri[2].hfinfo.display = BASE_NONE;

        len_hf++;
    }
    else if (a->type == radius_tlv)
    {
        hfri[0].hfinfo.type = FT_BYTES;
        hfri[0].hfinfo.display = BASE_NONE;
    }
    else
    {
        hfri[0].hfinfo.type = FT_BYTES;
        hfri[0].hfinfo.display = BASE_NONE;
    }

    if (a->tagged)
    {
        hfri[len_hf].p_id = &(a->hf_tag);
        hfri[len_hf].hfinfo.name = "Tag";
        hfri[len_hf].hfinfo.abbrev = g_strconcat(abbrev, ".tag", NULL);
        hfri[len_hf].hfinfo.blurb = g_strconcat(a->name, " Tag", NULL);
        hfri[len_hf].hfinfo.type = FT_UINT8;
        hfri[len_hf].hfinfo.display = BASE_HEX;
        len_hf++;
    }

    g_array_append_vals(ri->hf, hfri, len_hf);
    g_array_append_val(ri->ett, ett);

    if (a->tlvs_by_id)
    {
        g_hash_table_foreach(a->tlvs_by_id, register_attrs, ri);
    }
}