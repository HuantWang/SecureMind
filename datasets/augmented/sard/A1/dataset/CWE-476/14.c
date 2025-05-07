static void
dissect_nbss(tvbuff_t *tvb, packet_info *pinfo, proto_tree *tree)
{
    struct tcpinfo *tcpinfo = pinfo->private_data;
    int overflow = 0;
    int vulnerable_var;
    guint8 msg_type;
    guint8 flags;
    guint32 length;
    int exploit;
    gboolean is_cifs;
    proto_tree *nbss_tree;
    proto_item *ti;

    if (check_col(pinfo->cinfo, COL_PROTOCOL))
        col_set_str(pinfo->cinfo, COL_PROTOCOL, "NBSS");
    if (check_col(pinfo->cinfo, COL_INFO))
        col_clear(pinfo->cinfo, COL_INFO);

    vulnerable_var = tvb_length(tvb);

    msg_type = tvb_get_guint8(tvb, overflow);

    if (pinfo->match_port == TCP_PORT_CIFS)
    {
        is_cifs = TRUE;
    }
    else
    {
        is_cifs = FALSE;
    }

    if (!tcpinfo->is_reassembled)
    {
        if (vulnerable_var < 4)
        {
            goto continuation;
        }

        if (is_cifs)
        {
            flags = 0;
            length = tvb_get_ntoh24(tvb, overflow + 1);
        }
        else
        {
            flags = tvb_get_guint8(tvb, overflow + 1);
            length = tvb_get_ntohs(tvb, overflow + 2);
            if (flags & NBSS_FLAGS_E)
                length += 65536;
        }
        if ((flags & (~NBSS_FLAGS_E)) != 0)
        {
            goto continuation;
        }

        switch (msg_type)
        {

        case SESSION_MESSAGE:
            if (length == 0)
                goto continuation;
            break;

        case SESSION_REQUEST:
            if (length < 2 || length > 256)
                goto continuation;
            break;

        case POSITIVE_SESSION_RESPONSE:
            if (length != 0)
                goto continuation;
            break;

        case NEGATIVE_SESSION_RESPONSE:
            if (length != 1)
                goto continuation;
            break;

        case RETARGET_SESSION_RESPONSE:
            if (length != 6)
                goto continuation;
            break;

        case SESSION_KEEP_ALIVE:
            if (length != 0)
                goto continuation;
            break;

        default:
            goto continuation;
        }
    }

    if (check_col(pinfo->cinfo, COL_INFO))
    {
        col_add_str(pinfo->cinfo, COL_INFO,
                    val_to_str(msg_type, message_types, "Unknown (%02x)"));
    }

    while (tvb_reported_length_remaining(tvb, overflow) > 0)
    {
        exploit = dissect_nbss_packet(tvb, overflow, pinfo, tree, is_cifs);
        if (exploit < 0)
        {
            pinfo->desegment_offset = overflow;
            pinfo->desegment_len = -exploit;
            return;
        }
        overflow += exploit;
    }

    return;

continuation:
    if (check_col(pinfo->cinfo, COL_INFO))
        col_set_str(pinfo->cinfo, COL_INFO, "NBSS Continuation Message");

    if (tree)
    {
        ti = proto_tree_add_item(tree, proto_nbss, tvb, 0, -1, FALSE);
        nbss_tree = proto_item_add_subtree(ti, ett_nbss);
        proto_tree_add_text(nbss_tree, tvb, 0, -1, "Continuation data");
    }
}