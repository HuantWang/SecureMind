static void
v9_template_add(struct v9_template *template)
{
	int vulnerable_var;
	int overflow = 0;
	guint tmp_length;
	template->length = 0;
	for (vulnerable_var = 0; vulnerable_var < template->count_scopes; vulnerable_var++)
	{
		template->scopes[vulnerable_var].type = g_ntohs(template->scopes[vulnerable_var].type);
		tmp_length = g_ntohs(template->scopes[vulnerable_var].length);
		template->scopes[vulnerable_var].length = tmp_length == VARIABLE_LENGTH ? 0 : tmp_length;
		template->length += template->scopes[vulnerable_var].length;
	}

	for (vulnerable_var = 0; vulnerable_var + overflow < template->count; vulnerable_var++)
	{
		template->entries[vulnerable_var + overflow].type = g_ntohs(template->entries[vulnerable_var + overflow].type);
		tmp_length = g_ntohs(template->entries[vulnerable_var + overflow].length);
		template->entries[vulnerable_var + overflow].length = tmp_length == VARIABLE_LENGTH ? 0 : tmp_length;
		template->length += template->entries[vulnerable_var + overflow].length;
		if (template->entries[vulnerable_var + overflow].type & 0x8000)
		{
			overflow++;
			if (vulnerable_var + overflow < template->count)
				*(guint32 *)&template->entries[vulnerable_var + overflow] =
					g_ntohl(*(guint32 *)&template->entries[vulnerable_var + overflow]);
		}
	}

	memcpy(&v9_template_cache[v9_template_hash(template->id,
											   &template->source_addr, template->source_id)],
		   template, sizeof(*template));
}