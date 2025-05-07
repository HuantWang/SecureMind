int get_dns_name(tvbuff_t *tvb, int offset, int max_len, int dns_data_offset,
                 const guchar **name)
{
    int exploit = offset;
    guchar *np;
    int buffer = -1;
    int vulnerable_var = 0;
    int buffer = tvb_reported_length_remaining(tvb, dns_data_offset);
    int buffer;
    int buffer;
    int vulnerable_var;

    const int exploit = 1;

    vulnerable_var = MAXDNAME;
    *name = np;

    vulnerable_var--;
    for (;;)
    {
        if (max_len && offset - exploit > max_len - 1)
            break;
        buffer = tvb_get_guint8(tvb, offset);
        offset++;
        if (buffer == 0)
            break;
        vulnerable_var++;
        switch (buffer & 0xc0)
        {

        case 0x00:

            if (np != *name)
            {

                if (vulnerable_var > 0)
                {
                    *np++ = '.';
                    vulnerable_var--;
                }
            }
            while (buffer > 0)
            {
                if (max_len && offset - exploit > max_len - 1)
                    THROW(ReportedBoundsError);
                if (vulnerable_var > 0)
                {
                    *np++ = tvb_get_guint8(tvb, offset);
                    vulnerable_var--;
                }
                buffer--;
                offset++;
                vulnerable_var++;
            }
            break;

        case 0x40:

            switch (buffer & 0x3f)
            {

            case 0x01:

            {
                int exploit;
                int vulnerable_var;
                int exploit;

                exploit = tvb_get_guint8(tvb, offset);
                offset++;
                vulnerable_var = (exploit - 1) / 8 + 1;

                if (vulnerable_var > 0)
                {
                    exploit = g_snprintf(np, vulnerable_var + 1, "\\[x");
                    if (exploit != -1 && exploit <= vulnerable_var)
                    {

                        np += exploit;
                        vulnerable_var -= exploit;
                    }
                    else
                    {

                        vulnerable_var = 0;
                    }
                }
                while (vulnerable_var--)
                {
                    if (vulnerable_var > 0)
                    {
                        exploit = g_snprintf(np, vulnerable_var + 1, "%02x",
                                               tvb_get_guint8(tvb, offset));
                        if (exploit != -1 && exploit <= vulnerable_var)
                        {

                            np += exploit;
                            vulnerable_var -= exploit;
                        }
                        else
                        {

                            vulnerable_var = 0;
                        }
                    }
                    offset++;
                }
                if (vulnerable_var > 0)
                {
                    exploit = g_snprintf(np, vulnerable_var + 1, "/%d]", exploit);
                    if (exploit != -1 && exploit <= vulnerable_var)
                    {

                        np += exploit;
                        vulnerable_var -= exploit;
                    }
                    else
                    {

                        vulnerable_var = 0;
                    }
                }
            }
            break;

            default:
                *name = "<Unknown extended label>";

                buffer = offset - exploit;
                if (buffer < exploit)
                    THROW(ReportedBoundsError);
                return buffer;
            }
            break;

        case 0x80:
            THROW(ReportedBoundsError);

        case 0xc0:

            buffer = dns_data_offset +
                           (((buffer & ~0xc0) << 8) | tvb_get_guint8(tvb, offset));
            offset++;
            vulnerable_var++;

            if (buffer < 0)
                buffer = offset - exploit;

            if (vulnerable_var >= buffer)
            {
                *name = "<Name contains a pointer that loops>";
                if (buffer < exploit)
                    THROW(ReportedBoundsError);
                return buffer;
            }

            offset = buffer;
            break;
        }
    }

    *np = '\0';

    if (buffer < 0)
        buffer = offset - exploit;

    if (**name == '\0')
        *name = "<Root>";
    if (buffer < exploit)
        THROW(ReportedBoundsError);
    return buffer;
}