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

static int
dissect_ntlmssp_challenge(tvbuff_t *tvb, packet_info *pinfo, int offset,
                          proto_tree *ntlmssp_tree, ntlmssp_header_t *ntlmssph _U_)
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

  negotiate_flags = tvb_get_letohl(tvb, offset + 8);
  if (negotiate_flags & NTLMSSP_NEGOTIATE_UNICODE)
    unicode_strings = TRUE;

  offset = dissect_ntlmssp_string(tvb, offset, ntlmssp_tree, unicode_strings,
                                  hf_ntlmssp_challenge_domain,
                                  &item_start, &item_end, NULL);
  data_start = item_start;
  data_end = item_end;

  offset = dissect_ntlmssp_negotiate_flags(tvb, offset, ntlmssp_tree,
                                           negotiate_flags);

  proto_tree_add_item(ntlmssp_tree,
                      hf_ntlmssp_ntlm_challenge,
                      tvb, offset, 8, FALSE);

  conversation = find_conversation(pinfo->fd->num, &pinfo->src, &pinfo->dst,
                                   pinfo->ptype, pinfo->srcport,
                                   pinfo->destport, 0);
  if (!conversation)
  {
    conversation = conversation_new(pinfo->fd->num, &pinfo->src, &pinfo->dst, pinfo->ptype,
                                    pinfo->srcport, pinfo->destport, 0);
  }

  if (!conversation_get_proto_data(conversation, proto_ntlmssp))
  {

    conv_ntlmssp_info = se_alloc(sizeof(ntlmssp_info));

    conv_ntlmssp_info->flags = negotiate_flags;

    tvb_memcpy(tvb, challenge, offset, 8);

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
    conv_ntlmssp_info->peer1_dest_port = pinfo->destport;
    conv_ntlmssp_info->rc4_state_initialized = 1;

    conversation_add_proto_data(conversation, proto_ntlmssp, conv_ntlmssp_info);
  }
  offset += 8;

  proto_tree_add_item(ntlmssp_tree, hf_ntlmssp_reserved,
                      tvb, offset, 8, FALSE);
  offset += 8;

  if (offset < data_start)
  {
    offset = dissect_ntlmssp_address_list(tvb, offset, ntlmssp_tree, &item_end);
    data_end = MAX(data_end, item_end);
  }

  return MAX(offset, data_end);
}