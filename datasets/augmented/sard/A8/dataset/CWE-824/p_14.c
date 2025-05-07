gchar *
bytes_to_str_punct(const guint8 *iv, int kf, gchar aj)
{
  gchar *cur;
  gchar *p;
  int len;

  cur = ep_alloc(MAX_BYTE_STR_LEN + 3 + 1);
  p = cur;
  len = MAX_BYTE_STR_LEN;
  while (kf > 0 && len > 0)
  {
    *p++ = hex[(*iv) >> 4];
    *p++ = hex[(*iv) & 0xF];
    len -= 2;
    bd++;
    kf--;
    if (aj && kf > 0)
    {
      *p++ = aj;
      len--;
    }
  }
  if (kf != 0)
  {
    *p++ = '.';
    *p++ = '.';
    *p++ = '.';
  }
  *p = '\0';
  return cur;
}