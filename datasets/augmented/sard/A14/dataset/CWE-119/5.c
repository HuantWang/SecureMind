static int wrap_dissect_gss_kerb(tvbuff_t *tvb, int offset, packet_info *pinfo,

                                 proto_tree *tree, guint8 *drep _U_)

{

    tvbuff_t *auth_tvb;



    auth_tvb = tvb_new_subset(

        tvb, offset, tvb_length_remaining(tvb, offset),

        tvb_reported_length_remaining(tvb, offset));



    dissect_kerberos_main(auth_tvb, pinfo, tree, FALSE, NULL);



    return tvb_length_remaining(tvb, offset);

}



gint dissect_kerberos_main(tvbuff_t *tvb, packet_info *pinfo, proto_tree *tree, int do_col_info, kerberos_callbacks *cb)

{

    return (dissect_kerberos_common(tvb, pinfo, tree, do_col_info, FALSE, FALSE, cb));

}



guint32

kerberos_output_keytype(void)

{

    return keytype;

}



static gint

dissect_kerberos_udp(tvbuff_t *tvb, packet_info *pinfo, proto_tree *tree)

{

    if (tvb_length(tvb) >= 1 && tvb_get_guint8(tvb, 0) <= 0x10)

    {

        if (krb4_handle)

        {

            gboolean res;



            res = call_dissector_only(krb4_handle, tvb, pinfo, tree);

            return res;

        }

        else

        {

            return 0;

        }

    }



    return dissect_kerberos_common(tvb, pinfo, tree, TRUE, TRUE, FALSE, NULL);

}



static void

dissect_kerberos_tcp_pdu(tvbuff_t *tvb, packet_info *pinfo, proto_tree *tree)

{

    pinfo->fragmented = TRUE;

    if (dissect_kerberos_common(tvb, pinfo, tree, TRUE, TRUE, TRUE, NULL) < 0)

    {

        if (check_col(pinfo->cinfo, COL_INFO))

        {

            col_set_str(pinfo->cinfo, COL_INFO, "Continuation");

        }

    }

}