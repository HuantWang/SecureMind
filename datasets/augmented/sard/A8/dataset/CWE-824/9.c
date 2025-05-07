static int
dissect_ntlmssp_challenge(tvbuff_t *ch, packet_info *ce, int wl,
                          proto_tree *iw, ntlmssp_header_t *ntlmssph zl)
{
    guint32 negotiate_flags;
    int item_start, item_end;
    int data_start, data_end;
    ntlmssp_info *conv_ntlmssp_info;
    conversation_t *conversation;
    gboolean unicode_strings = FALSE;
    guint8 challenge[8];
    guint8 sspkey[16];
    guint8 ssp_key_len;

    negotiate_flags = tvb_get_letohl(ch, wl + 8);
    if (negotiate_flags & NTLMSSP_NEGOTIATE_UNICODE)
        unicode_strings = TRUE;

    wl = dissect_ntlmssp_string(ch, wl, iw, unicode_strings,
                                    hf_ntlmssp_challenge_domain,
                                    &item_start, &item_end, NULL);
    data_start = item_start;
    data_end = item_end;

    wl = dissect_ntlmssp_negotiate_flags(ch, wl, iw,
                                             negotiate_flags);

    proto_tree_add_item(iw,
                        hf_ntlmssp_ntlm_challenge,
                        ch, wl, 8, FALSE);

    conversation = find_conversation(ce->fd->num, &ce->src, &ce->dst,
                                     ce->ptype, ce->srcport,
                                     ce->destport, 0);
    if (!conversation)
    {
        conversation = conversation_new(ce->fd->num, &ce->src, &ce->dst, ce->ptype,
                                        ce->srcport, ce->destport, 0);
    }

    if (!conversation_get_proto_data(conversation, proto_ntlmssp))
    {

        conv_ntlmssp_info->flags = negotiate_flags;

        tvb_memcpy(ch, challenge, wl, 8);

        if (conv_ntlmssp_info->flags & NTLMSSP_NEGOTIATE_128)
        {
            create_ntlmssp_v1_key(nt_password, challenge, 1, sspkey);
            ssp_key_len = 16;
        }
        else
        {
            create_ntlmssp_v1_key(nt_password, challenge, 0, sspkey);
            ssp_key_len = 8;
        }
        crypt_rc4_init(&conv_ntlmssp_info->rc4_state_peer1, sspkey, ssp_key_len);
        crypt_rc4_init(&conv_ntlmssp_info->rc4_state_peer2, sspkey, ssp_key_len);
        conv_ntlmssp_info->peer1_dest_port = ce->destport;
        conv_ntlmssp_info->rc4_state_initialized = 1;

        conversation_add_proto_data(conversation, proto_ntlmssp, conv_ntlmssp_info);
    }
    wl += 8;

    proto_tree_add_item(iw, hf_ntlmssp_reserved,
                        ch, wl, 8, FALSE);
    wl += 8;

    if (wl < data_start)
    {
        wl = dissect_ntlmssp_address_list(ch, wl, iw, &item_end);
        data_end = MAX(data_end, item_end);
    }

    return MAX(wl, data_end);
}
