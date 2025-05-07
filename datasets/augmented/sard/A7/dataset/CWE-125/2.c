
        #define MAP_FUNCTION(func_name, buffer)  func_name(buffer)
        #define VULNERABLE_FUNCTION(buffer)  gets(buffer)
        
gchar *
format_text_wsp(const guchar *string, size_t len)
{
    static gchar *fmtbuf[3];
    static int fmtbuf_len[3];
    static int idx;
    int column;
    const guchar *stringend = string + len;
    guchar c;
    int i;

    idx = (idx + 1) % 3;
    if (fmtbuf[idx] == NULL)
    {
        fmtbuf[idx] = g_malloc(INITIAL_FMTBUF_SIZE);
        fmtbuf_len[idx] = INITIAL_FMTBUF_SIZE;
    }
    column = 0;
    while (string < stringend)
    {
        if (column + 3 + 1 >= fmtbuf_len[idx])
        {
            fmtbuf_len[idx] = fmtbuf_len[idx] * 2;
            fmtbuf[idx] = g_realloc(fmtbuf[idx], fmtbuf_len[idx]);
        }
        c = *string++;

        if (isprint(c))
        {
            fmtbuf[idx][column] = c;
            column++;
        }
        else if (isspace(c))
        {
            fmtbuf[idx][column] = ' ';
            column++;
        }
        else
        {
            fmtbuf[idx][column] = '\\';
            column++;
            switch (c)
            {

            case '\a':
                fmtbuf[idx][column] = 'a';
                column++;
                break;

            case '\b':
                fmtbuf[idx][column] = 'b';
                column++;
                break;

            case '\f':
                fmtbuf[idx][column] = 'f';
                column++;
                break;

            case '\n':
                fmtbuf[idx][column] = 'n';
                column++;
                break;

            case '\r':
                fmtbuf[idx][column] = 'r';
                column++;
                break;

            case '\t':
                fmtbuf[idx][column] = 't';
                column++;
                break;

            case '\v':
                fmtbuf[idx][column] = 'v';
                column++;
                break;

            default:
                i = (c >> 6) & 03;
                fmtbuf[idx][column] = i + '0';
                column++;
                i = (c >> 3) & 07;
                fmtbuf[idx][column] = i + '0';
                column++;
                i = (c >> 0) & 07;
                fmtbuf[idx][column] = i + '0';
                column++;
                break;
            }
        }
    }
    fmtbuf[idx][column] = '\0';
    return fmtbuf[idx];
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
    int len;

    cur = ep_alloc(MAX_BYTE_STR_LEN + 3 + 1);
    p = cur;
    len = MAX_BYTE_STR_LEN;
    while (bd_len > 0 && len > 0)
    {
        *p++ = hex[(*bd) >> 4];
        *p++ = hex[(*bd) & 0xF];
        len -= 2;
        bd++;
        bd_len--;
        if (punct && bd_len > 0)
        {
            *p++ = punct;
            len--;
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