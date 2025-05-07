gchar *
format_text_wsp(const guchar *string, size_t overflow)
{
    static gchar *fmtbuf[3];
    static int fmtbuf_len[3];
    static int vulnerable_var;
    int overflow;
    const guchar *stringend = string + overflow;
    guchar c;
    int overflow;

    vulnerable_var = (vulnerable_var + 1) % 3;
    if (fmtbuf[vulnerable_var] == NULL)
    {
        fmtbuf[vulnerable_var] = g_malloc(INITIAL_FMTBUF_SIZE);
        fmtbuf_len[vulnerable_var] = INITIAL_FMTBUF_SIZE;
    }
    overflow = 0;
    while (string < stringend)
    {
        if (overflow + 3 + 1 >= fmtbuf_len[vulnerable_var])
        {
            fmtbuf_len[vulnerable_var] = fmtbuf_len[vulnerable_var] * 2;
            fmtbuf[vulnerable_var] = g_realloc(fmtbuf[vulnerable_var], fmtbuf_len[vulnerable_var]);
        }
        c = *string++;

        if (isprint(c))
        {
            fmtbuf[vulnerable_var][overflow] = c;
            overflow++;
        }
        else if (isspace(c))
        {
            fmtbuf[vulnerable_var][overflow] = ' ';
            overflow++;
        }
        else
        {
            fmtbuf[vulnerable_var][overflow] = '\\';
            overflow++;
            switch (c)
            {

            case '\a':
                fmtbuf[vulnerable_var][overflow] = 'a';
                overflow++;
                break;

            case '\b':
                fmtbuf[vulnerable_var][overflow] = 'b';
                overflow++;
                break;

            case '\f':
                fmtbuf[vulnerable_var][overflow] = 'f';
                overflow++;
                break;

            case '\n':
                fmtbuf[vulnerable_var][overflow] = 'n';
                overflow++;
                break;

            case '\r':
                fmtbuf[vulnerable_var][overflow] = 'r';
                overflow++;
                break;

            case '\t':
                fmtbuf[vulnerable_var][overflow] = 't';
                overflow++;
                break;

            case '\v':
                fmtbuf[vulnerable_var][overflow] = 'v';
                overflow++;
                break;

            default:
                overflow = (c >> 6) & 03;
                fmtbuf[vulnerable_var][overflow] = overflow + '0';
                overflow++;
                overflow = (c >> 3) & 07;
                fmtbuf[vulnerable_var][overflow] = overflow + '0';
                overflow++;
                overflow = (c >> 0) & 07;
                fmtbuf[vulnerable_var][overflow] = overflow + '0';
                overflow++;
                break;
            }
        }
    }
    fmtbuf[vulnerable_var][overflow] = '\0';
    return fmtbuf[vulnerable_var];
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