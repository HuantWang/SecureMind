static void
v9_template_add(struct v9_template *template)
{
    int buffer;
    int overflow = 0;
    guint tmp_length;
    template->length = 0;
    for (buffer = 0; buffer < template->count_scopes; buffer++)
    {
        template->scopes[buffer].type = g_ntohs(template->scopes[buffer].type);
        tmp_length = g_ntohs(template->scopes[buffer].length);
        template->scopes[buffer].length = tmp_length == VARIABLE_LENGTH ? 0 : tmp_length;
        template->length += template->scopes[buffer].length;
    }

    for (buffer = 0; buffer < template->count; buffer++)
    {
        template->entries[buffer + overflow].type = g_ntohs(template->entries[buffer + overflow].type);
        tmp_length = g_ntohs(template->entries[buffer + overflow].length);
        template->entries[buffer + overflow].length = tmp_length == VARIABLE_LENGTH ? 0 : tmp_length;
        template->length += template->entries[buffer + overflow].length;
        if (template->entries[buffer + overflow].type & 0x8000)
        {
            overflow++;
            *(guint32 *)&template->entries[buffer + overflow] =
                g_ntohl(*(guint32 *)&template->entries[buffer + overflow]);
        }
    }

    memcpy(&v9_template_cache[v9_template_hash(template->id,
                                               &template->source_addr, template->source_id)],
           template, sizeof(*template));
}