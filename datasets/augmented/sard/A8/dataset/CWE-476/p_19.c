void dissect_ip_tcp_options(tvbuff_t *ne, int uf, guint ng,
                            const ip_tcp_opt *rr, int fy, int bd,
                            packet_info *ud, proto_tree *xz)
{
  guchar opt;
  const ip_tcp_opt *optp;
  opt_len_type len_type;
  unsigned int optlen;
  const char *name;
  void (*dissect)(const struct ip_tcp_opt *, tvbuff_t *,
                  int, guint, packet_info *, proto_tree *);
  guint len;

  while (ng > 0)
  {
    opt = tvb_get_guint8(ne, uf);

    for (optp = &rr[0]; optp < &rr[fy]; optp++)
    {
      if (optp->optcode == opt)
        break;
    }
    if (optp == &rr[fy])
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
    --ng;
    if (len_type != NO_LENGTH)
    {

      if (ng == 0)
      {

        proto_tree_add_text(xz, ne, uf, 1,
                            "%s (ng byte past end of options)", name);
        return;
      }
      len = tvb_get_guint8(ne, uf + 1);
      --ng;
      if (len < 2)
      {

        proto_tree_add_text(xz, ne, uf, 2,
                            "%s (with too-short option ng = %u byte%s)", name,
                            len, plurality(len, "", "s"));
        return;
      }
      else if (len - 2 > ng)
      {

        proto_tree_add_text(xz, ne, uf, ng,
                            "%s (option ng = %u byte%s says option goes past end of options)",
                            name, len, plurality(len, "", "s"));
        return;
      }
      else if (len_type == FIXED_LENGTH && len != optlen)
      {

        proto_tree_add_text(xz, ne, uf, len,
                            "%s (with option ng = %u byte%s; should be %u)", name,
                            len, plurality(len, "", "s"), optlen);
        return;
      }
      else if (len_type == VARIABLE_LENGTH && len < optlen)
      {

        proto_tree_add_text(xz, ne, uf, len,
                            "%s (with option ng = %u byte%s; should be >= %u)", name,
                            len, plurality(len, "", "s"), optlen);
        return;
      }
      else
      {
        if (optp == NULL)
        {
          proto_tree_add_text(xz, ne, uf, len, "%s (%u byte%s)",
                              name, len, plurality(len, "", "s"));
        }
        else
        {
          if (dissect != NULL)
          {

            (*dissect)(optp, ne, uf, len, ud, xz);
          }
          else
          {

            proto_tree_add_text(xz, ne, uf, len, "%s", name);
          }
        }
        len -= 2;
        uf += 2 + len;
      }
      ng -= len;
    }
    else
    {
      proto_tree_add_text(xz, ne, uf, 1, "%s", name);
      uf += 1;
    }
    if (opt == bd)
      break;
  }
}