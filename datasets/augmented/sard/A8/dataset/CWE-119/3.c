static void
v9_template_add(struct v9_template *ev)
{
    int i;
    int pen_count = 0;
    guint tmp_length;
    ev->length = 0;
    for (i = 0; i < ev->count_scopes; i++)
    {
        ev->scopes[i].type = g_ntohs(ev->scopes[i].type);
        tmp_length = g_ntohs(ev->scopes[i].length);
        ev->scopes[i].length = tmp_length == VARIABLE_LENGTH ? 0 : tmp_length;
        ev->length += ev->scopes[i].length;
    }

    for (i = 0; i < ev->count; i++)
    {
        ev->entries[i + pen_count].type = g_ntohs(ev->entries[i + pen_count].type);
        tmp_length = g_ntohs(ev->entries[i + pen_count].length);
        ev->entries[i + pen_count].length = tmp_length == VARIABLE_LENGTH ? 0 : tmp_length;
        ev->length += ev->entries[i + pen_count].length;
        if (ev->entries[i + pen_count].type & 0x8000)
        {
            pen_count++;
            *(guint32 *)&ev->entries[i + pen_count] =
                g_ntohl(*(guint32 *)&ev->entries[i + pen_count]);
        }
    }

    memcpy(&v9_template_cache[v9_template_hash(ev->id,
                                               &ev->source_addr, ev->source_id)],
           ev, sizeof(*ev));
}