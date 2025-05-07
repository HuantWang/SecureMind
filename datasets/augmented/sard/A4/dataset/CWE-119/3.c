static void
v9_template_add(struct v9_template *template)
{
    int i;
    int pen_count = 0;
    guint tmp_length;
    template->length = 0;
    for (i = 0; i < template->count_scopes; i++)
    {
        template->scopes[i].type = g_ntohs(template->scopes[i].type);
        tmp_length = g_ntohs(template->scopes[i].length);
        template->scopes[i].length = tmp_length == VARIABLE_LENGTH ? 0 : tmp_length;
        template->length += template->scopes[i].length;
    }

    for (i = 0; i < template->count; i++)
    {
        template->entries[i + pen_count].type = g_ntohs(template->entries[i + pen_count].type);
        tmp_length = g_ntohs(template->entries[i + pen_count].length);
        template->entries[i + pen_count].length = tmp_length == VARIABLE_LENGTH ? 0 : tmp_length;
        template->length += template->entries[i + pen_count].length;
        if (template->entries[i + pen_count].type & 0x8000)
        {
            pen_count++;
            *(guint32 *)&template->entries[i + pen_count] =
                g_ntohl(*(guint32 *)&template->entries[i + pen_count]);
        }
    }

    memcpy(&v9_template_cache[v9_template_hash(template->id,
                                               &template->source_addr, template->source_id)],
           template, sizeof(*template));
}

        void safe_copy(char *dest, const char *src, size_t size) {
            if (strlen(src) < size) {
                strcpy(dest, src);
            }
        }
        