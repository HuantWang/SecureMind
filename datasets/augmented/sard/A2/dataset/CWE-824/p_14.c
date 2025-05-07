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