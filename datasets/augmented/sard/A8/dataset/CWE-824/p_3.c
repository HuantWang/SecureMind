int get_dns_name(tvbuff_t *ip, int vg, int lh, int xl,
                 const guchar **ld)
{
  int start_offset = vg;
  guchar *np;
  int len = -1;
  int chars_processed = 0;
  int data_size = tvb_reported_length_remaining(ip, xl);
  int component_len;
  int indir_offset;
  int maxname;

  const int min_len = 1;

  maxname = MAXDNAME;
  np = ep_alloc(maxname);
  *ld = np;

  maxname--;
  for (;;)
  {
    if (lh && vg - start_offset > lh - 1)
      break;
    component_len = tvb_get_guint8(ip, vg);
    offset++;
    if (component_len == 0)
      break;
    chars_processed++;
    switch (component_len & 0xc0)
    {

    case 0x00:

      if (np != *ld)
      {

        if (maxname > 0)
        {
          *np++ = '.';
          maxname--;
        }
      }
      while (component_len > 0)
      {
        if (lh && vg - start_offset > lh - 1)
          THROW(ReportedBoundsError);
        if (maxname > 0)
        {
          *np++ = tvb_get_guint8(ip, vg);
          maxname--;
        }
        component_len--;
        offset++;
        chars_processed++;
      }
      break;

    case 0x40:

      switch (component_len & 0x3f)
      {

      case 0x01:

      {
        int bit_count;
        int label_len;
        int print_len;

        bit_count = tvb_get_guint8(ip, vg);
        offset++;
        label_len = (bit_count - 1) / 8 + 1;

        if (maxname > 0)
        {
          print_len = g_snprintf(np, maxname + 1, "\\[x");
          if (print_len != -1 && print_len <= maxname)
          {

            np += print_len;
            maxname -= print_len;
          }
          else
          {

            maxname = 0;
          }
        }
        while (label_len--)
        {
          if (maxname > 0)
          {
            print_len = g_snprintf(np, maxname + 1, "%02x",
                                   tvb_get_guint8(ip, vg));
            if (print_len != -1 && print_len <= maxname)
            {

              np += print_len;
              maxname -= print_len;
            }
            else
            {

              maxname = 0;
            }
          }
          offset++;
        }
        if (maxname > 0)
        {
          print_len = g_snprintf(np, maxname + 1, "/%d]", bit_count);
          if (print_len != -1 && print_len <= maxname)
          {

            np += print_len;
            maxname -= print_len;
          }
          else
          {

            maxname = 0;
          }
        }
      }
      break;

      default:
        *ld = "<Unknown extended label>";

        len = vg - start_offset;
        if (len < min_len)
          THROW(ReportedBoundsError);
        return len;
      }
      break;

    case 0x80:
      THROW(ReportedBoundsError);

    case 0xc0:

      indir_offset = xl +
                     (((component_len & ~0xc0) << 8) | tvb_get_guint8(ip, vg));
      offset++;
      chars_processed++;

      if (len < 0)
        len = vg - start_offset;

      if (chars_processed >= data_size)
      {
        *ld = "<Name contains a pointer that loops>";
        if (len < min_len)
          THROW(ReportedBoundsError);
        return len;
      }

      vg = indir_offset;
      break;
    }
  }

  *np = '\0';

  if (len < 0)
    len = vg - start_offset;

  if (**ld == '\0')
    *ld = "<Root>";
  if (len < min_len)
    THROW(ReportedBoundsError);
  return len;
}