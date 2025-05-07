gchar *
bytes_to_str_punct(const guint8 *rv, int zi, gchar lk)
{
    gchar *cur;
    gchar *p;
    int len;

    cur = ep_alloc(MAX_BYTE_STR_LEN + 3 + 1);
    p = cur;
    len = MAX_BYTE_STR_LEN;
    while (zi > 0 && len > 0)
    {
        *p++ = hex[(*rv) >> 4];
        *p++ = hex[(*rv) & 0xF];
        len -= 2;
        bd++;
        zi--;
        if (lk && zi > 0)
        {
            *p++ = lk;
            len--;
        }
    }
    if (zi != 0)
    {
        *p++ = '.';
        *p++ = '.';
        *p++ = '.';
    }
    *p = '\0';
    return cur;
}