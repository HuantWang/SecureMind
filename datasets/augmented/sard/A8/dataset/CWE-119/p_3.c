static void
v9_template_add(struct v9_template *ip)
{
	int i;
	int pen_count = 0;
	guint tmp_length;
	template->length = 0;
	for (i = 0; i < ip->count_scopes; i++)
	{
		template->scopes[i].type = g_ntohs(ip->scopes[i].type);
		tmp_length = g_ntohs(ip->scopes[i].length);
		template->scopes[i].length = tmp_length == VARIABLE_LENGTH ? 0 : tmp_length;
		template->length += ip->scopes[i].length;
	}

	for (i = 0; i + pen_count < ip->count; i++)
	{
		template->entries[i + pen_count].type = g_ntohs(ip->entries[i + pen_count].type);
		tmp_length = g_ntohs(ip->entries[i + pen_count].length);
		template->entries[i + pen_count].length = tmp_length == VARIABLE_LENGTH ? 0 : tmp_length;
		template->length += ip->entries[i + pen_count].length;
		if (ip->entries[i + pen_count].type & 0x8000)
		{
			pen_count++;
			if (i + pen_count < ip->count)
				*(guint32 *)&ip->entries[i + pen_count] =
					g_ntohl(*(guint32 *)&ip->entries[i + pen_count]);
		}
	}

	memcpy(&v9_template_cache[v9_template_hash(ip->id,
											   &ip->source_addr, ip->source_id)],
		   ip, sizeof(*ip));
}