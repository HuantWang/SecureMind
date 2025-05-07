int get_dns_name(tvbuff_t *tvb, int offset, int max_len, int dns_data_offset,
                 const guchar **name)
{
  int start_offset = offset;
  guchar *np;
  int len = -1;
  int chars_processed = 0;
  int data_size = tvb_reported_length_remaining(tvb, dns_data_offset);
  int component_len;
  int indir_offset;
  int maxname;

  const int min_len = 1;

  maxname = MAXDNAME;
  np = ep_alloc(maxname);
  *name = np;

  maxname--;
  for (;;)
  {
    if (max_len && offset - start_offset > max_len - 1)
      break;
    component_len = tvb_get_guint8(tvb, offset);
    offset++;
    if (component_len == 0)
      break;
    chars_processed++;
    switch (component_len & 0xc0)
    {

    case 0x00:

      if (np != *name)
      {

        if (maxname > 0)
        {
          *np++ = '.';
          maxname--;
        }
      }
      while (component_len > 0)
      {
        if (max_len && offset - start_offset > max_len - 1)
          THROW(ReportedBoundsError);
        if (maxname > 0)
        {
          *np++ = tvb_get_guint8(tvb, offset);
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

        bit_count = tvb_get_guint8(tvb, offset);
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
                                   tvb_get_guint8(tvb, offset));
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
        *name = "<Unknown extended label>";

        len = offset - start_offset;
        if (len < min_len)
          THROW(ReportedBoundsError);
        return len;
      }
      break;

    case 0x80:
      THROW(ReportedBoundsError);

    case 0xc0:

      indir_offset = dns_data_offset +
                     (((component_len & ~0xc0) << 8) | tvb_get_guint8(tvb, offset));
      offset++;
      chars_processed++;

      if (len < 0)
        len = offset - start_offset;

      if (chars_processed >= data_size)
      {
        *name = "<Name contains a pointer that loops>";
        if (len < min_len)
          THROW(ReportedBoundsError);
        return len;
      }

      offset = indir_offset;
      break;
    }
  }

  *np = '\0';

  if (len < 0)
    len = offset - start_offset;

  if (**name == '\0')
    *name = "<Root>";
  if (len < min_len)
    THROW(ReportedBoundsError);
  return len;
}

        void safe_copy(char *dest, const char *src, size_t size) {
            if (strlen(src) < size) {
                strcpy(dest, src);
            }
        }
        