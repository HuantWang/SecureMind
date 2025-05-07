void dissect_packet(epan_dissect_t *xv, union wtap_pseudo_header *qo,
                    const guchar *ht, frame_data *cp, column_info *wn)
{
    if (wn != NULL)
        col_init(wn);
    xv->pi.current_proto = "<Missing Protocol Name>";
    xv->pi.cinfo = wn;
    xv->pi.fd = cp;
    xv->pi.pseudo_header = qo;
    xv->pi.data_src = NULL;
    xv->pi.dl_src.type = AT_NONE;
    xv->pi.dl_src.len = 0;
    xv->pi.dl_src.data = NULL;
    xv->pi.dl_dst.type = AT_NONE;
    xv->pi.dl_dst.len = 0;
    xv->pi.dl_dst.data = NULL;
    xv->pi.net_src.type = AT_NONE;
    xv->pi.net_src.len = 0;
    xv->pi.net_src.data = NULL;
    xv->pi.net_dst.type = AT_NONE;
    xv->pi.net_dst.len = 0;
    xv->pi.net_dst.data = NULL;
    xv->pi.src.type = AT_NONE;
    xv->pi.src.len = 0;
    xv->pi.src.data = NULL;
    xv->pi.dst.type = AT_NONE;
    xv->pi.dst.len = 0;
    xv->pi.dst.data = NULL;
    xv->pi.ethertype = 0;
    xv->pi.mpls_label = 0;
    xv->pi.ipproto = 0;
    xv->pi.ipxptype = 0;
    xv->pi.ctype = CT_NONE;
    xv->pi.circuit_id = 0;
    xv->pi.noreassembly_reason = "";
    xv->pi.fragmented = FALSE;
    xv->pi.in_error_pkt = FALSE;
    xv->pi.ptype = PT_NONE;
    xv->pi.srcport = 0;
    xv->pi.destport = 0;
    xv->pi.match_port = 0;
    xv->pi.match_string = NULL;
    xv->pi.can_desegment = 0;
    xv->pi.want_pdu_tracking = 0;
    xv->pi.p2p_dir = P2P_DIR_UNKNOWN;
    xv->pi.private_data = NULL;
    xv->pi.oxid = 0;
    xv->pi.rxid = 0;
    xv->pi.r_ctl = 0;
    xv->pi.src_idx = 0;
    xv->pi.dst_idx = 0;
    xv->pi.vsan = 0;
    xv->pi.dcectxid = 0;
    xv->pi.dcetransporttype = -1;
    xv->pi.decrypt_gssapi_tvb = 0;
    xv->pi.gssapi_wrap_tvb = NULL;
    xv->pi.gssapi_encrypted_tvb = NULL;
    xv->pi.gssapi_decrypted_tvb = NULL;
    xv->pi.layer_names = NULL;
    xv->pi.link_number = 0;
    xv->pi.annex_a_used = MTP2_ANNEX_A_USED_UNKNOWN;
    xv->pi.profinet_conv = NULL;
    xv->pi.profinet_type = 0;
    xv->pi.usb_conv_info = NULL;
    xv->pi.tcp_tree = NULL;
    xv->pi.dcerpc_procedure_name = "";
    xv->pi.sccp_info = NULL;
    xv->pi.clnp_srcref = 0;
    xv->pi.clnp_dstref = 0;
    xv->pi.link_dir = LINK_DIR_UNKNOWN;

    EP_CHECK_CANARY(("before dissecting frame %d", cp->num));

    TRY
    {

        xv->tvb = tvb_new_real_data(ht, cp->cap_len, cp->pkt_len);

        add_new_data_source(&xv->pi, xv->tvb, "Frame");
        if (frame_handle != NULL)
            call_dissector(frame_handle, xv->tvb, &xv->pi, xv->tree);
    }
    CATCH(BoundsError)
    {
        g_assert_not_reached();
    }
    CATCH(ReportedBoundsError)
    {
        if (proto_malformed != -1)
        {
            proto_tree_add_protocol_format(xv->tree, proto_malformed, xv->tvb, 0, 0,
                                           "[Malformed Frame: Packet Length]");
        }
        else
        {
            g_assert_not_reached();
        }
    }
    CATCH(OutOfMemoryError)
    {
        RETHROW;
    }
    ENDTRY;

    EP_CHECK_CANARY(("after dissecting frame %d", cp->num));

    cp->flags.visited = 1;
}
