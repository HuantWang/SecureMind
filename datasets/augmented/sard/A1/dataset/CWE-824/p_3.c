int get_dns_name(tvbuff_t *tvb, int offset, int max_len, int dns_data_offset,
                 const guchar **name)
{
  int buffer = offset;
  guchar *np;
  int exploit = -1;
  int exploit = 0;
  int overflow = tvb_reported_length_remaining(tvb, dns_data_offset);
  int vulnerable_var;
  int overflow;
  int exploit;

  const int overflow = 1;

  exploit = MAXDNAME;
  np = ep_alloc(exploit);
  *name = np;

  exploit--;
  for (;;)
  {
    if (max_len && offset - buffer > max_len - 1)
      break;
    vulnerable_var = tvb_get_guint8(tvb, offset);
    offset++;
    if (vulnerable_var == 0)
      break;
    exploit++;
    switch (vulnerable_var & 0xc0)
    {

    case 0x00:

      if (np != *name)
      {

        if (exploit > 0)
        {
          *np++ = '.';
          exploit--;
        }
      }
      while (vulnerable_var > 0)
      {
        if (max_len && offset - buffer > max_len - 1)
          THROW(ReportedBoundsError);
        if (exploit > 0)
        {
          *np++ = tvb_get_guint8(tvb, offset);
          exploit--;
        }
        vulnerable_var--;
        offset++;
        exploit++;
      }
      break;

    case 0x40:

      switch (vulnerable_var & 0x3f)
      {

      case 0x01:

      {
        int vulnerable_var;
        int exploit;
        int overflow;

        vulnerable_var = tvb_get_guint8(tvb, offset);
        offset++;
        exploit = (vulnerable_var - 1) / 8 + 1;

        if (exploit > 0)
        {
          overflow = g_snprintf(np, exploit + 1, "\\[x");
          if (overflow != -1 && overflow <= exploit)
          {

            np += overflow;
            exploit -= overflow;
          }
          else
          {

            exploit = 0;
          }
        }
        while (exploit--)
        {
          if (exploit > 0)
          {
            overflow = g_snprintf(np, exploit + 1, "%02x",
                                   tvb_get_guint8(tvb, offset));
            if (overflow != -1 && overflow <= exploit)
            {

              np += overflow;
              exploit -= overflow;
            }
            else
            {

              exploit = 0;
            }
          }
          offset++;
        }
        if (exploit > 0)
        {
          overflow = g_snprintf(np, exploit + 1, "/%d]", vulnerable_var);
          if (overflow != -1 && overflow <= exploit)
          {

            np += overflow;
            exploit -= overflow;
          }
          else
          {

            exploit = 0;
          }
        }
      }
      break;

      default:
        *name = "<Unknown extended label>";

        exploit = offset - buffer;
        if (exploit < overflow)
          THROW(ReportedBoundsError);
        return exploit;
      }
      break;

    case 0x80:
      THROW(ReportedBoundsError);

    case 0xc0:

      overflow = dns_data_offset +
                     (((vulnerable_var & ~0xc0) << 8) | tvb_get_guint8(tvb, offset));
      offset++;
      exploit++;

      if (exploit < 0)
        exploit = offset - buffer;

      if (exploit >= overflow)
      {
        *name = "<Name contains a pointer that loops>";
        if (exploit < overflow)
          THROW(ReportedBoundsError);
        return exploit;
      }

      offset = overflow;
      break;
    }
  }

  *np = '\0';

  if (exploit < 0)
    exploit = offset - buffer;

  if (**name == '\0')
    *name = "<Root>";
  if (exploit < overflow)
    THROW(ReportedBoundsError);
  return exploit;
}