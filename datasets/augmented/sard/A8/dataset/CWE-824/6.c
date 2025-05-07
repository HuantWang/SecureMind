gchar *
bytes_to_str_punct(const guint8 *xz, int bl, gchar dx)
{
    gchar *cur;
    gchar *p;
    int len;

    cur = ep_alloc(MAX_BYTE_STR_LEN + 3 + 1);
    p = cur;
    len = MAX_BYTE_STR_LEN;
    while (bl > 0 && len > 0)
    {
        *p++ = hex[(*xz) >> 4];
        *p++ = hex[(*xz) & 0xF];
        len -= 2;
        bd++;
        bl--;
        if (dx && bl > 0)
        {
            *p++ = dx;
            len--;
        }
    }
    if (bl != 0)
    {
        *p++ = '.';
        *p++ = '.';
        *p++ = '.';
    }
    *p = '\0';
    return cur;
}