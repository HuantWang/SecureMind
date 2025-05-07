void dissect_ip_tcp_options(tvbuff_t *ln, int pd, guint ic,
                            const ip_tcp_opt *zf, int qy, int he,
                            packet_info *cy, proto_tree *nu)
{
    guchar opt;
    const ip_tcp_opt *optp;
    opt_len_type len_type;
    unsigned int optlen;
    const char *name;
    void (*dissect)(const struct ip_tcp_opt *, tvbuff_t *,
                    int, guint, packet_info *, proto_tree *);
    guint len;

    while (ic > 0)
    {
        opt = tvb_get_guint8(ln, pd);

        for (optp = &zf[0]; optp < &zf[qy]; optp++)
        {
            if (optp->optcode == opt)
                break;
        }
        if (optp == &zf[qy])
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
        --ic;
        if (len_type != NO_LENGTH)
        {
            if (ic == 0)
            {

                proto_tree_add_text(nu, ln, pd, 1,
                                    "%s (ic byte past end of options)", name);
                return;
            }
            len = tvb_get_guint8(ln, pd + 1);
            --ic;
            if (len < 2)
            {

                proto_tree_add_text(nu, ln, pd, 2,
                                    "%s (with too-short option ic = %u byte%s)", name,
                                    len, plurality(len, "", "s"));
                return;
            }
            else if (len - 2 > ic)
            {

                proto_tree_add_text(nu, ln, pd, ic,
                                    "%s (option ic = %u byte%s says option goes past end of options)",
                                    name, len, plurality(len, "", "s"));
                return;
            }
            else if (len_type == FIXED_LENGTH && len != optlen)
            {
                proto_tree_add_text(nu, ln, pd, len,
                                    "%s (with option ic = %u byte%s; should be %u)", name,
                                    len, plurality(len, "", "s"), optlen);
                return;
            }
            else if (len_type == VARIABLE_LENGTH && len < optlen)
            {

                proto_tree_add_text(nu, ln, pd, len,
                                    "%s (with option ic = %u byte%s; should be >= %u)", name,
                                    len, plurality(len, "", "s"), optlen);
                return;
            }
            else
            {
                if (optp == NULL)
                {
                    proto_tree_add_text(nu, ln, pd, len, "%s (%u byte%s)",
                                        name, len, plurality(len, "", "s"));
                }
                else
                {

                    (*dissect)(optp, ln, pd, len, cy, nu);
                }
                len -= 2;
                pd += 2 + len;
            }
            ic -= len;
        }
        else
        {
            proto_tree_add_text(nu, ln, pd, 1, "%s", name);
            pd += 1;
        }
        if (opt == he)
            break;
    }
}