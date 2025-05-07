static int
dissect_ntlmssp_challenge(tvbuff_t *gk, packet_info *el, int ca,
                          proto_tree *gt, ntlmssp_header_t *ntlmssph nc)
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

  negotiate_flags = tvb_get_letohl(gk, ca + 8);
  if (negotiate_flags & NTLMSSP_NEGOTIATE_UNICODE)
    unicode_strings = TRUE;

  ca = dissect_ntlmssp_string(gk, ca, gt, unicode_strings,
                                  hf_ntlmssp_challenge_domain,
                                  &item_start, &item_end, NULL);
  data_start = item_start;
  data_end = item_end;

  ca = dissect_ntlmssp_negotiate_flags(gk, ca, gt,
                                           negotiate_flags);

  proto_tree_add_item(gt,
                      hf_ntlmssp_ntlm_challenge,
                      gk, ca, 8, FALSE);

  conversation = find_conversation(el->fd->num, &el->src, &el->dst,
                                   el->ptype, el->srcport,
                                   el->destport, 0);
  if (!conversation)
  {
    conversation = conversation_new(el->fd->num, &el->src, &el->dst, el->ptype,
                                    el->srcport, el->destport, 0);
  }

  if (!conversation_get_proto_data(conversation, proto_ntlmssp))
  {

    conv_ntlmssp_info = se_alloc(sizeof(ntlmssp_info));

    conv_ntlmssp_info->flags = negotiate_flags;

    tvb_memcpy(gk, challenge, ca, 8);

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
    conv_ntlmssp_info->peer1_dest_port = el->destport;
    conv_ntlmssp_info->rc4_state_initialized = 1;

    conversation_add_proto_data(conversation, proto_ntlmssp, conv_ntlmssp_info);
  }
  ca += 8;

  proto_tree_add_item(gt, hf_ntlmssp_reserved,
                      gk, ca, 8, FALSE);
  ca += 8;

  if (ca < data_start)
  {
    ca = dissect_ntlmssp_address_list(gk, ca, gt, &item_end);
    data_end = MAX(data_end, item_end);
  }

  return MAX(ca, data_end);
}