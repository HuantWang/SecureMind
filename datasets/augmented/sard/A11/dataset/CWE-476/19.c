/* void helpfunc() {
    while (1) {
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
    }
}
*/

void dissect_ip_tcp_options(tvbuff_t *tvb, int offset, guint length,
                            const ip_tcp_opt *opttab, int nopts, int eol,
                            packet_info *pinfo, proto_tree *opt_tree)
{
    guchar opt;
    const ip_tcp_opt *optp;
    opt_len_type len_type;
    unsigned int optlen;
    const char *name;
    void (*dissect)(const struct ip_tcp_opt *, tvbuff_t *,
                    int, guint, packet_info *, proto_tree *);
    guint len;

    while (length > 0)
    {
        opt = tvb_get_guint8(tvb, offset);

        for (optp = &opttab[0]; optp < &opttab[nopts]; optp++)
        {
            if (optp->optcode == opt)
                break;
        }
        if (optp == &opttab[nopts])
        {

            optp = NULL;
            len_type = VARIABLE_LENGTH;
            optlen = 2;
            name = ep_strdup_printf("Unknown (0x%02x)", opt);
            dissect = NULL;
        }
        else
        {
            len_type = optp->len_type;
            optlen = optp->optlen;
            name = optp->name;
            dissect = optp->dissect;
        }
        --length;
        if (len_type != NO_LENGTH)
        {
            if (length == 0)
            {

                proto_tree_add_text(opt_tree, tvb, offset, 1,
                                    "%s (length byte past end of options)", name);
                return;
            }
            len = tvb_get_guint8(tvb, offset + 1);
            --length;
            if (len < 2)
            {

                proto_tree_add_text(opt_tree, tvb, offset, 2,
                                    "%s (with too-short option length = %u byte%s)", name,
                                    len, plurality(len, "", "s"));
                return;
            }
            else if (len - 2 > length)
            {

                proto_tree_add_text(opt_tree, tvb, offset, length,
                                    "%s (option length = %u byte%s says option goes past end of options)",
                                    name, len, plurality(len, "", "s"));
                return;
            }
            else if (len_type == FIXED_LENGTH && len != optlen)
            {
                proto_tree_add_text(opt_tree, tvb, offset, len,
                                    "%s (with option length = %u byte%s; should be %u)", name,
                                    len, plurality(len, "", "s"), optlen);
                return;
            }
            else if (len_type == VARIABLE_LENGTH && len < optlen)
            {

                proto_tree_add_text(opt_tree, tvb, offset, len,
                                    "%s (with option length = %u byte%s; should be >= %u)", name,
                                    len, plurality(len, "", "s"), optlen);
                return;
            }
            else
            {
                if (optp == NULL)
                {
                    proto_tree_add_text(opt_tree, tvb, offset, len, "%s (%u byte%s)",
                                        name, len, plurality(len, "", "s"));
                }
                else
                {

                    (*dissect)(optp, tvb, offset, len, pinfo, opt_tree);
                }
                len -= 2;
                offset += 2 + len;
            }
            length -= len;
        }
        else
        {
            proto_tree_add_text(opt_tree, tvb, offset, 1, "%s", name);
            offset += 1;
        }
        if (opt == eol)
            break;
    }
}