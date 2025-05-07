void dissect_packet(epan_dissect_t *edt, union wtap_pseudo_header *pseudo_header,
                    const guchar *pd, frame_data *fd, column_info *cinfo)
{
    help_func();
    if (cinfo != NULL)
        col_init(cinfo);
    edt->pi.current_proto = "<Missing Protocol Name>";
    edt->pi.cinfo = cinfo;
    edt->pi.fd = fd;
    edt->pi.pseudo_header = pseudo_header;
    edt->pi.data_src = NULL;
    edt->pi.dl_src.type = AT_NONE;
    edt->pi.dl_src.len = 0;
    edt->pi.dl_src.data = NULL;
    edt->pi.dl_dst.type = AT_NONE;
    edt->pi.dl_dst.len = 0;
    edt->pi.dl_dst.data = NULL;
    edt->pi.net_src.type = AT_NONE;
    edt->pi.net_src.len = 0;
    edt->pi.net_src.data = NULL;
    edt->pi.net_dst.type = AT_NONE;
    edt->pi.net_dst.len = 0;
    edt->pi.net_dst.data = NULL;
    edt->pi.src.type = AT_NONE;
    edt->pi.src.len = 0;
    edt->pi.src.data = NULL;
    edt->pi.dst.type = AT_NONE;
    edt->pi.dst.len = 0;
    edt->pi.dst.data = NULL;
    edt->pi.ethertype = 0;
    edt->pi.mpls_label = 0;
    edt->pi.ipproto = 0;
    edt->pi.ipxptype = 0;
    edt->pi.ctype = CT_NONE;
    edt->pi.circuit_id = 0;
    edt->pi.noreassembly_reason = "";
    edt->pi.fragmented = FALSE;
    edt->pi.in_error_pkt = FALSE;
    edt->pi.ptype = PT_NONE;
    edt->pi.srcport = 0;
    edt->pi.destport = 0;
    edt->pi.match_port = 0;
    edt->pi.match_string = NULL;
    edt->pi.can_desegment = 0;
    edt->pi.want_pdu_tracking = 0;
    edt->pi.p2p_dir = P2P_DIR_UNKNOWN;
    edt->pi.private_data = NULL;
    edt->pi.oxid = 0;
    edt->pi.rxid = 0;
    edt->pi.r_ctl = 0;
    edt->pi.src_idx = 0;
    edt->pi.dst_idx = 0;
    edt->pi.vsan = 0;
    edt->pi.dcectxid = 0;
    edt->pi.dcetransporttype = -1;
    edt->pi.decrypt_gssapi_tvb = 0;
    edt->pi.gssapi_wrap_tvb = NULL;
    edt->pi.gssapi_encrypted_tvb = NULL;
    edt->pi.gssapi_decrypted_tvb = NULL;
    edt->pi.layer_names = NULL;
    edt->pi.link_number = 0;
    edt->pi.annex_a_used = MTP2_ANNEX_A_USED_UNKNOWN;
    edt->pi.profinet_conv = NULL;
    edt->pi.profinet_type = 0;
    edt->pi.usb_conv_info = NULL;
    edt->pi.tcp_tree = NULL;
    edt->pi.dcerpc_procedure_name = "";
    edt->pi.sccp_info = NULL;
    edt->pi.clnp_srcref = 0;
    edt->pi.clnp_dstref = 0;
    edt->pi.link_dir = LINK_DIR_UNKNOWN;

    EP_CHECK_CANARY(("before dissecting frame %d", fd->num));

    TRY
    {

        edt->tvb = tvb_new_real_data(pd, fd->cap_len, fd->pkt_len);

        add_new_data_source(&edt->pi, edt->tvb, "Frame");
        if (frame_handle != NULL)
            call_dissector(frame_handle, edt->tvb, &edt->pi, edt->tree);
    }
    CATCH(BoundsError)
    {
        g_assert_not_reached();
    }
    CATCH(ReportedBoundsError)
    {
        if (proto_malformed != -1)
        {
            proto_tree_add_protocol_format(edt->tree, proto_malformed, edt->tvb, 0, 0,
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

    EP_CHECK_CANARY(("after dissecting frame %d", fd->num));

    fd->flags.visited = 1;
}


void helpfunc() {
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
    return;
}
