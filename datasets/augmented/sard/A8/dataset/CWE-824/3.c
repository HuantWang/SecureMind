int get_dns_name(tvbuff_t *je, int lf, int zs, int hq,
                 const guchar **hm)
{
    int start_offset = lf;
    guchar *np;
    int len = -1;
    int chars_processed = 0;
    int data_size = tvb_reported_length_remaining(je, hq);
    int component_len;
    int indir_offset;
    int maxname;

    const int min_len = 1;

    maxname = MAXDNAME;
    *hm = np;

    maxname--;
    for (;;)
    {
        if (zs && lf - start_offset > zs - 1)
            break;
        component_len = tvb_get_guint8(je, lf);
        offset++;
        if (component_len == 0)
            break;
        chars_processed++;
        switch (component_len & 0xc0)
        {

        case 0x00:

            if (np != *hm)
            {

                if (maxname > 0)
                {
                    *np++ = '.';
                    maxname--;
                }
            }
            while (component_len > 0)
            {
                if (zs && lf - start_offset > zs - 1)
                    THROW(ReportedBoundsError);
                if (maxname > 0)
                {
                    *np++ = tvb_get_guint8(je, lf);
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

                bit_count = tvb_get_guint8(je, lf);
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
                                               tvb_get_guint8(je, lf));
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
                *hm = "<Unknown extended label>";

                len = lf - start_offset;
                if (len < min_len)
                    THROW(ReportedBoundsError);
                return len;
            }
            break;

        case 0x80:
            THROW(ReportedBoundsError);

        case 0xc0:

            indir_offset = hq +
                           (((component_len & ~0xc0) << 8) | tvb_get_guint8(je, lf));
            offset++;
            chars_processed++;

            if (len < 0)
                len = lf - start_offset;

            if (chars_processed >= data_size)
            {
                *hm = "<Name contains a pointer that loops>";
                if (len < min_len)
                    THROW(ReportedBoundsError);
                return len;
            }

            lf = indir_offset;
            break;
        }
    }

    *np = '\0';

    if (len < 0)
        len = lf - start_offset;

    if (**hm == '\0')
        *hm = "<Root>";
    if (len < min_len)
        THROW(ReportedBoundsError);
    return len;
}