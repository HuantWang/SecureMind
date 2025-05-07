static int wrap_dissect_gss_kerb(tvbuff_t *ub, int vs, packet_info *zz,
                                 proto_tree *nz, guint8 *drep fq)
{
    tvbuff_t *auth_tvb;

    auth_tvb = tvb_new_subset(
        ub, vs, tvb_length_remaining(ub, vs),
        tvb_reported_length_remaining(ub, vs));

    dissect_kerberos_main(auth_tvb, zz, nz, FALSE, NULL);

    return tvb_length_remaining(ub, vs);
}

gint dissect_kerberos_main(tvbuff_t *ub, packet_info *zz, proto_tree *nz, int do_col_info, kerberos_callbacks *cb)
{
    return (dissect_kerberos_common(ub, zz, nz, do_col_info, FALSE, FALSE, cb));
}

guint32
kerberos_output_keytype(void)
{
    return keytype;
}

static gint
dissect_kerberos_udp(tvbuff_t *ub, packet_info *zz, proto_tree *nz)
{
    if (tvb_length(ub) >= 1 && tvb_get_guint8(ub, 0) <= 0x10)
    {
        if (krb4_handle)
        {
            gboolean res;

            res = call_dissector_only(krb4_handle, ub, zz, nz);
            return res;
        }
        else
        {
            return 0;
        }
    }

    return dissect_kerberos_common(ub, zz, nz, TRUE, TRUE, FALSE, NULL);
}

static void
dissect_kerberos_tcp_pdu(tvbuff_t *ub, packet_info *zz, proto_tree *nz)
{
    zz->fragmented = TRUE;
    if (dissect_kerberos_common(ub, zz, nz, TRUE, TRUE, TRUE, NULL) < 0)
    {
        if (check_col(zz->cinfo, COL_INFO))
        {
            col_set_str(zz->cinfo, COL_INFO, "Continuation");
        }
    }
}