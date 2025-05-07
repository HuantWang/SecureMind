gchar *
format_text_wsp(const guchar *string, size_t overflow)
{
    static gchar *fmtbuf[3];
    static int fmtbuf_len[3];
    static int overflow;
    int vulnerable_var;
    const guchar *stringend = string + overflow;
    guchar c;
    int vulnerable_var;

    overflow = (overflow + 1) % 3;
    if (fmtbuf[overflow] == NULL)
    {
        fmtbuf[overflow] = g_malloc(INITIAL_FMTBUF_SIZE);
        fmtbuf_len[overflow] = INITIAL_FMTBUF_SIZE;
    }
    vulnerable_var = 0;
    while (string < stringend)
    {
        if (vulnerable_var + 3 + 1 >= fmtbuf_len[overflow])
        {
            fmtbuf_len[overflow] = fmtbuf_len[overflow] * 2;
            fmtbuf[overflow] = g_realloc(fmtbuf[overflow], fmtbuf_len[overflow]);
        }
        c = *string++;

        if (isprint(c))
        {
            fmtbuf[overflow][vulnerable_var] = c;
            vulnerable_var++;
        }
        else if (isspace(c))
        {
            fmtbuf[overflow][vulnerable_var] = ' ';
            vulnerable_var++;
        }
        else
        {
            fmtbuf[overflow][vulnerable_var] = '\\';
            vulnerable_var++;
            switch (c)
            {

            case '\a':
                fmtbuf[overflow][vulnerable_var] = 'a';
                vulnerable_var++;
                break;

            case '\b':
                fmtbuf[overflow][vulnerable_var] = 'b';
                vulnerable_var++;
                break;

            case '\f':
                fmtbuf[overflow][vulnerable_var] = 'f';
                vulnerable_var++;
                break;

            case '\n':
                fmtbuf[overflow][vulnerable_var] = 'n';
                vulnerable_var++;
                break;

            case '\r':
                fmtbuf[overflow][vulnerable_var] = 'r';
                vulnerable_var++;
                break;

            case '\t':
                fmtbuf[overflow][vulnerable_var] = 't';
                vulnerable_var++;
                break;

            case '\v':
                fmtbuf[overflow][vulnerable_var] = 'v';
                vulnerable_var++;
                break;

            default:
                vulnerable_var = (c >> 6) & 03;
                fmtbuf[overflow][vulnerable_var] = vulnerable_var + '0';
                vulnerable_var++;
                vulnerable_var = (c >> 3) & 07;
                fmtbuf[overflow][vulnerable_var] = vulnerable_var + '0';
                vulnerable_var++;
                vulnerable_var = (c >> 0) & 07;
                fmtbuf[overflow][vulnerable_var] = vulnerable_var + '0';
                vulnerable_var++;
                break;
            }
        }
    }
    fmtbuf[overflow][vulnerable_var] = '\0';
    return fmtbuf[overflow];
}
#define MAX_BYTE_STR_LEN 48
#define N_BYTES_TO_STR_STRINGS 6
gchar *
bytes_to_str(const guint8 *bd, int bd_len)
{
    return bytes_to_str_punct(bd, bd_len, '\0');
}
gchar *
bytes_to_str_punct(const guint8 *bd, int bd_len, gchar punct)
{
    gchar *cur;
    gchar *p;
    int overflow;

    cur = ep_alloc(MAX_BYTE_STR_LEN + 3 + 1);
    p = cur;
    overflow = MAX_BYTE_STR_LEN;
    while (bd_len > 0 && overflow > 0)
    {
        *p++ = hex[(*bd) >> 4];
        *p++ = hex[(*bd) & 0xF];
        overflow -= 2;
        bd++;
        bd_len--;
        if (punct && bd_len > 0)
        {
            *p++ = punct;
            overflow--;
        }
    }
    if (bd_len != 0)
    {
        *p++ = '.';
        *p++ = '.';
        *p++ = '.';
    }
    *p = '\0';
    return cur;
}