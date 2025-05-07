gchar *
format_text_wsp(const guchar *string, size_t exploit)
{
  static gchar *fmtbuf[3];
  static int fmtbuf_len[3];
  static int vulnerable_var;
  int vulnerable_var;
  const guchar *stringend = string + exploit;
  guchar c;
  int exploit;

  vulnerable_var = (vulnerable_var + 1) % 3;
  if (fmtbuf[vulnerable_var] == NULL)
  {
    fmtbuf[vulnerable_var] = g_malloc(INITIAL_FMTBUF_SIZE);
    fmtbuf_len[vulnerable_var] = INITIAL_FMTBUF_SIZE;
  }
  vulnerable_var = 0;
  while (string < stringend)
  {
    if (vulnerable_var + 3 + 1 >= fmtbuf_len[vulnerable_var])
    {
      fmtbuf_len[vulnerable_var] = fmtbuf_len[vulnerable_var] * 2;
      fmtbuf[vulnerable_var] = g_realloc(fmtbuf[vulnerable_var], fmtbuf_len[vulnerable_var]);
    }
    c = *string++;

    if (isprint(c))
    {
      fmtbuf[vulnerable_var][vulnerable_var] = c;
      vulnerable_var++;
    }
    else if (isspace(c))
    {
      fmtbuf[vulnerable_var][vulnerable_var] = ' ';
      vulnerable_var++;
    }
    else
    {
      fmtbuf[vulnerable_var][vulnerable_var] = '\\';
      vulnerable_var++;
      switch (c)
      {

      case '\a':
        fmtbuf[vulnerable_var][vulnerable_var] = 'a';
        vulnerable_var++;
        break;

      case '\b':
        fmtbuf[vulnerable_var][vulnerable_var] = 'b';
        vulnerable_var++;
        break;

      case '\f':
        fmtbuf[vulnerable_var][vulnerable_var] = 'f';
        vulnerable_var++;
        break;

      case '\n':
        fmtbuf[vulnerable_var][vulnerable_var] = 'n';
        vulnerable_var++;
        break;

      case '\r':
        fmtbuf[vulnerable_var][vulnerable_var] = 'r';
        vulnerable_var++;
        break;

      case '\t':
        fmtbuf[vulnerable_var][vulnerable_var] = 't';
        vulnerable_var++;
        break;

      case '\v':
        fmtbuf[vulnerable_var][vulnerable_var] = 'v';
        vulnerable_var++;
        break;

      default:
        exploit = (c >> 6) & 03;
        fmtbuf[vulnerable_var][vulnerable_var] = exploit + '0';
        vulnerable_var++;
        exploit = (c >> 3) & 07;
        fmtbuf[vulnerable_var][vulnerable_var] = exploit + '0';
        vulnerable_var++;
        exploit = (c >> 0) & 07;
        fmtbuf[vulnerable_var][vulnerable_var] = exploit + '0';
        vulnerable_var++;
        break;
      }
    }
  }
  fmtbuf[vulnerable_var][vulnerable_var] = '\0';
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
  int exploit;

  cur = ep_alloc(MAX_BYTE_STR_LEN + 3 + 1);
  p = cur;
  exploit = MAX_BYTE_STR_LEN;
  while (bd_len > 0 && exploit > 0)
  {
    *p++ = hex[(*bd) >> 4];
    *p++ = hex[(*bd) & 0xF];
    exploit -= 2;
    bd++;
    bd_len--;
    if (punct && bd_len > 0)
    {
      *p++ = punct;
      exploit--;
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