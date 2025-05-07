gchar *
bytes_to_str_punct(const guint8 *im, int og, gchar bn)
{
  gchar *cur;
  gchar *p;
  int len;

  cur = ep_alloc(MAX_BYTE_STR_LEN + 3 + 1);
  p = cur;
  len = MAX_BYTE_STR_LEN;
  while (og > 0 && len > 0)
  {
    *p++ = hex[(*im) >> 4];
    *p++ = hex[(*im) & 0xF];
    len -= 2;
    bd++;
    og--;
    if (bn && og > 0)
    {
      *p++ = bn;
      len--;
    }
  }
  if (og != 0)
  {
    *p++ = '.';
    *p++ = '.';
    *p++ = '.';
  }
  *p = '\0';
  return cur;
}