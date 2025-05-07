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

static void
dissect_payloads(tvbuff_t *tvb, proto_tree *tree, proto_tree *parent_tree,
                 int isakmp_version, guint8 initial_payload, int offset, int length,
                 packet_info *pinfo)
{
    guint8 payload, next_payload;
    guint16 payload_length;
    proto_tree *ntree;
    struct payload_func *f;

    for (payload = initial_payload; length > 0; payload = next_payload)
    {
        if (payload == LOAD_TYPE_NONE)
        {

            proto_tree_add_text(tree, tvb, offset, length,
                                "Extra data: %s",
                                tvb_bytes_to_str(tvb, offset, length));
            break;
        }
        ntree = dissect_payload_header(tvb, offset, length, isakmp_version,
                                       payload, &next_payload, &payload_length, tree);
        if (ntree == NULL)
            break;
        if (payload_length >= 4)
        {
            tvb_ensure_bytes_exist(tvb, offset + 4, payload_length - 4);
            if ((f = getpayload_func(payload, isakmp_version)) != NULL && f->func != NULL)
                (*f->func)(tvb, offset + 4, payload_length - 4, ntree, parent_tree,
                           pinfo, isakmp_version, -1, next_payload);
            else
            {
                proto_tree_add_text(ntree, tvb, offset + 4, payload_length - 4,
                                    "Payload");
            }
        }
        else if (payload_length > length)
        {
            proto_tree_add_text(ntree, tvb, 0, 0,
                                "Payload (bogus, length is %u, greater than remaining length %d",
                                payload_length, length);
            return;
        }
        else
        {
            proto_tree_add_text(ntree, tvb, 0, 0,
                                "Payload (bogus, length is %u, must be at least 4)",
                                payload_length);
            payload_length = 4;
        }
        offset += payload_length;
        length -= payload_length;
    }
}

static void
dissect_isakmp(tvbuff_t *tvb, packet_info *pinfo, proto_tree *tree)
{
    int offset = 0, len;
    isakmp_hdr_t hdr;
    proto_item *ti;
    proto_tree *isakmp_tree = NULL;
    int isakmp_version;
#ifdef HAVE_LIBGCRYPT
    guint8 i_cookie[COOKIE_SIZE], *ic_key;
    decrypt_data_t *decr = NULL;
    tvbuff_t *decr_tvb;
    proto_tree *decr_tree;
    address null_addr;
    void *pd_save;
    gboolean pd_changed = FALSE;
#endif

    if (check_col(pinfo->cinfo, COL_PROTOCOL))
        col_set_str(pinfo->cinfo, COL_PROTOCOL, "ISAKMP");
    if (check_col(pinfo->cinfo, COL_INFO))
        col_clear(pinfo->cinfo, COL_INFO);

    if (tree)
    {
        ti = proto_tree_add_item(tree, proto_isakmp, tvb, offset, -1, FALSE);
        isakmp_tree = proto_item_add_subtree(ti, ett_isakmp);
    }

    if ((tvb_length(tvb) == 1) && (tvb_get_guint8(tvb, offset) == 0xff))
    {
        if (check_col(pinfo->cinfo, COL_INFO))
        {
            col_set_str(pinfo->cinfo, COL_INFO, "NAT Keepalive");
        }
        proto_tree_add_item(isakmp_tree, hf_isakmp_nat_keepalive, tvb, offset, 1, FALSE);
        return;
    }

    hdr.length = tvb_get_ntohl(tvb, offset + ISAKMP_HDR_SIZE - sizeof(hdr.length));
    hdr.exch_type = tvb_get_guint8(tvb, COOKIE_SIZE + COOKIE_SIZE + sizeof(hdr.next_payload) + sizeof(hdr.version));
    hdr.version = tvb_get_guint8(tvb, COOKIE_SIZE + COOKIE_SIZE + sizeof(hdr.next_payload));
    isakmp_version = hi_nibble(hdr.version);
    hdr.flags = tvb_get_guint8(tvb, COOKIE_SIZE + COOKIE_SIZE + sizeof(hdr.next_payload) + sizeof(hdr.version) + sizeof(hdr.exch_type));
    if (check_col(pinfo->cinfo, COL_INFO))
        col_add_str(pinfo->cinfo, COL_INFO,
                    exchtype2str(isakmp_version, hdr.exch_type));

#ifdef HAVE_LIBGCRYPT

    if (isakmp_version == 1)
    {
        SET_ADDRESS(&null_addr, AT_NONE, 0, NULL);

        tvb_memcpy(tvb, i_cookie, offset, COOKIE_SIZE);
        decr = (decrypt_data_t *)g_hash_table_lookup(isakmp_hash, i_cookie);

        if (!decr)
        {
            ic_key = g_mem_chunk_alloc(isakmp_key_data);
            memcpy(ic_key, i_cookie, COOKIE_SIZE);
            decr = g_mem_chunk_alloc(isakmp_decrypt_data);
            memset(decr, 0, sizeof(decrypt_data_t));
            SET_ADDRESS(&decr->initiator, AT_NONE, 0, NULL);

            g_hash_table_insert(isakmp_hash, ic_key, decr);
        }

        if (ADDRESSES_EQUAL(&decr->initiator, &null_addr))
        {

            SE_COPY_ADDRESS(&decr->initiator, &pinfo->src);
        }

        pd_save = pinfo->private_data;
        pinfo->private_data = decr;
        pd_changed = TRUE;
    }
    else if (isakmp_version == 2)
    {
        ikev2_uat_data_key_t hash_key;
        ikev2_uat_data_t *ike_sa_data = NULL;
        ikev2_decrypt_data_t *ikev2_dec_data;
        guchar spii[COOKIE_SIZE], spir[COOKIE_SIZE];

        tvb_memcpy(tvb, spii, offset, COOKIE_SIZE);
        tvb_memcpy(tvb, spir, offset + COOKIE_SIZE, COOKIE_SIZE);
        hash_key.spii = spii;
        hash_key.spir = spir;
        hash_key.spii_len = COOKIE_SIZE;
        hash_key.spir_len = COOKIE_SIZE;

        ike_sa_data = g_hash_table_lookup(ikev2_key_hash, &hash_key);
        if (ike_sa_data)
        {
            guint8 initiator_flag;
            initiator_flag = hdr.flags & I_FLAG;
            ikev2_dec_data = ep_alloc(sizeof(ikev2_decrypt_data_t));
            ikev2_dec_data->encr_key = initiator_flag ? ike_sa_data->sk_ei : ike_sa_data->sk_er;
            ikev2_dec_data->auth_key = initiator_flag ? ike_sa_data->sk_ai : ike_sa_data->sk_ar;
            ikev2_dec_data->encr_spec = ike_sa_data->encr_spec;
            ikev2_dec_data->auth_spec = ike_sa_data->auth_spec;

            pd_save = pinfo->private_data;
            pinfo->private_data = ikev2_dec_data;
            pd_changed = TRUE;
        }
    }
#endif

    if (tree)
    {
        proto_tree_add_item(isakmp_tree, hf_isakmp_icookie, tvb, offset, COOKIE_SIZE, FALSE);
        offset += COOKIE_SIZE;

        proto_tree_add_item(isakmp_tree, hf_isakmp_rcookie, tvb, offset, COOKIE_SIZE, FALSE);
        offset += COOKIE_SIZE;

        hdr.next_payload = tvb_get_guint8(tvb, offset);
        proto_tree_add_uint_format(isakmp_tree, hf_isakmp_nextpayload, tvb, offset,
                                   sizeof(hdr.next_payload), hdr.next_payload,
                                   "Next payload: %s (%u)",
                                   payloadtype2str(isakmp_version, hdr.next_payload),
                                   hdr.next_payload);
        offset += sizeof(hdr.next_payload);

        proto_tree_add_uint_format(isakmp_tree, hf_isakmp_version, tvb, offset,
                                   sizeof(hdr.version), hdr.version, "Version: %u.%u",
                                   hi_nibble(hdr.version), lo_nibble(hdr.version));
        offset += sizeof(hdr.version);

        hdr.exch_type = tvb_get_guint8(tvb, offset);
        proto_tree_add_uint_format(isakmp_tree, hf_isakmp_exchangetype, tvb, offset,
                                   sizeof(hdr.exch_type), hdr.exch_type,
                                   "Exchange type: %s (%u)",
                                   exchtype2str(isakmp_version, hdr.exch_type),
                                   hdr.exch_type);
        offset += sizeof(hdr.exch_type);

        {
            proto_item *fti;
            proto_tree *ftree;

            fti = proto_tree_add_item(isakmp_tree, hf_isakmp_flags, tvb, offset, sizeof(hdr.flags), FALSE);
            ftree = proto_item_add_subtree(fti, ett_isakmp_flags);

            if (isakmp_version == 1)
            {
                proto_tree_add_text(ftree, tvb, offset, 1, "%s",
                                    decode_boolean_bitfield(hdr.flags, E_FLAG, sizeof(hdr.flags) * 8,
                                                            "Encrypted", "Not encrypted"));
                proto_tree_add_text(ftree, tvb, offset, 1, "%s",
                                    decode_boolean_bitfield(hdr.flags, C_FLAG, sizeof(hdr.flags) * 8,
                                                            "Commit", "No commit"));
                proto_tree_add_text(ftree, tvb, offset, 1, "%s",
                                    decode_boolean_bitfield(hdr.flags, A_FLAG, sizeof(hdr.flags) * 8,
                                                            "Authentication", "No authentication"));
            }
            else if (isakmp_version == 2)
            {
                proto_tree_add_text(ftree, tvb, offset, 1, "%s",
                                    decode_boolean_bitfield(hdr.flags, I_FLAG, sizeof(hdr.flags) * 8,
                                                            "Initiator", "Responder"));
                proto_tree_add_text(ftree, tvb, offset, 1, "%s",
                                    decode_boolean_bitfield(hdr.flags, V_FLAG, sizeof(hdr.flags) * 8,
                                                            "A higher version enabled", ""));
                proto_tree_add_text(ftree, tvb, offset, 1, "%s",
                                    decode_boolean_bitfield(hdr.flags, R_FLAG, sizeof(hdr.flags) * 8,
                                                            "Response", "Request"));
            }
            offset += sizeof(hdr.flags);
        }

        hdr.message_id = tvb_get_ntohl(tvb, offset);
        proto_tree_add_item(isakmp_tree, hf_isakmp_messageid, tvb, offset, sizeof(hdr.message_id), FALSE);
        offset += sizeof(hdr.message_id);

        if (hdr.length < ISAKMP_HDR_SIZE)
        {
            proto_tree_add_uint_format(isakmp_tree, hf_isakmp_length, tvb, offset, sizeof(hdr.length),
                                       hdr.length, "Length: (bogus, length is %u, should be at least %lu)",
                                       hdr.length, (unsigned long)ISAKMP_HDR_SIZE);
#ifdef HAVE_LIBGCRYPT
            if (pd_changed)
                pinfo->private_data = pd_save;
#endif
            return;
        }

        len = hdr.length - ISAKMP_HDR_SIZE;

        if (len < 0)
        {
            proto_tree_add_uint_format(isakmp_tree, hf_isakmp_length, tvb, offset, sizeof(hdr.length),
                                       hdr.length, "Length: (bogus, length is %u, which is too large)",
                                       hdr.length);
#ifdef HAVE_LIBGCRYPT
            if (pd_changed)
                pinfo->private_data = pd_save;
#endif
            return;
        }

        proto_tree_add_item(isakmp_tree, hf_isakmp_length, tvb, offset, sizeof(hdr.length), FALSE);
        offset += sizeof(hdr.length);

        if (hdr.flags & E_FLAG)
        {
            if (len && isakmp_tree)
            {
                ti = proto_tree_add_text(isakmp_tree, tvb, offset, len,
                                         "Encrypted payload (%d byte%s)",
                                         len, plurality(len, "", "s"));
#ifdef HAVE_LIBGCRYPT

                if (decr)
                {
                    decr_tvb = decrypt_payload(tvb, pinfo, tvb_get_ptr(tvb, offset, len), len, &hdr);
                    if (decr_tvb)
                    {
                        decr_tree = proto_item_add_subtree(ti, ett_isakmp);
                        dissect_payloads(decr_tvb, decr_tree, tree, isakmp_version,
                                         hdr.next_payload, 0, tvb_length(decr_tvb), pinfo);
                    }
                }
#endif
            }
        }
        else
            dissect_payloads(tvb, isakmp_tree, tree, isakmp_version, hdr.next_payload,
                             offset, len, pinfo);
    }
#ifdef HAVE_LIBGCRYPT
    if (pd_changed)
        pinfo->private_data = pd_save;
#endif
}

static void
dissect_enc(tvbuff_t *tvb, int offset, int length, proto_tree *tree,
            proto_tree *p _U_, packet_info *pinfo, int isakmp_version _U_, int unused _U_, guint8 inner_payload)
{
#ifdef HAVE_LIBGCRYPT
    ikev2_decrypt_data_t *key_info = NULL;
    gint iv_len, encr_data_len, icd_len, encr_key_len, decr_data_len, md_len;
    guint8 pad_len;
    guchar *iv = NULL, *encr_data = NULL, *decr_data = NULL, *entire_message = NULL, *md = NULL;
    gcry_cipher_hd_t cipher_hd;
    gcry_md_hd_t md_hd;
    gcry_error_t err = 0;
    proto_item *item = NULL, *icd_item = NULL, *encr_data_item = NULL, *padlen_item = NULL;
    tvbuff_t *decr_tvb = NULL;
    gint payloads_len;
    proto_tree *decr_tree = NULL, *decr_payloads_tree = NULL;

    if (pinfo->private_data)
    {
        key_info = (ikev2_decrypt_data_t *)(pinfo->private_data);
        encr_key_len = key_info->encr_spec->key_len;
        iv_len = key_info->encr_spec->iv_len;
        icd_len = key_info->auth_spec->trunc_len;
        encr_data_len = length - iv_len - icd_len;

        if (encr_data_len <= 0)
        {
            item = proto_tree_add_text(tree, tvb, offset, length, "Not enough data for IV, Encrypted data and ICD.");
            expert_add_info_format(pinfo, item, PI_MALFORMED, PI_WARN, "Not enough data in IKEv2 Encrypted payload");
            PROTO_ITEM_SET_GENERATED(item);
            return;
        }

        if (iv_len)
        {
            proto_tree_add_text(tree, tvb, offset, iv_len, "Initialization Vector (%d bytes): 0x%s",
                                iv_len, tvb_bytes_to_str(tvb, offset, iv_len));
            iv = ep_tvb_memdup(tvb, offset, iv_len);

            offset += iv_len;
        }

        encr_data_item = proto_tree_add_text(tree, tvb, offset, encr_data_len, "Encrypted Data (%d bytes)", encr_data_len);
        encr_data = ep_tvb_memdup(tvb, offset, encr_data_len);
        offset += encr_data_len;

        if (icd_len)
        {
            icd_item = proto_tree_add_text(tree, tvb, offset, icd_len, "Integrity Checksum Data (%d bytes) ", icd_len);

            if (key_info->auth_spec->gcry_alg)
            {
                err = gcry_md_open(&md_hd, key_info->auth_spec->gcry_alg, key_info->auth_spec->gcry_flag);
                if (err)
                {
                    REPORT_DISSECTOR_BUG(ep_strdup_printf("IKEv2 hashing error: algorithm %d: gcry_md_open failed: %s",
                                                          key_info->auth_spec->gcry_alg, gcry_strerror(err)));
                }
                err = gcry_md_setkey(md_hd, key_info->auth_key, key_info->auth_spec->key_len);
                if (err)
                {
                    REPORT_DISSECTOR_BUG(ep_strdup_printf("IKEv2 hashing error: algorithm %s, key length %u: gcry_md_setkey failed: %s",
                                                          gcry_md_algo_name(key_info->auth_spec->gcry_alg), key_info->auth_spec->key_len, gcry_strerror(err)));
                }

                entire_message = ep_tvb_memdup(tvb, 0, offset);
                gcry_md_write(md_hd, entire_message, offset);
                md = gcry_md_read(md_hd, 0);
                md_len = gcry_md_get_algo_dlen(key_info->auth_spec->gcry_alg);
                if (md_len < icd_len)
                {
                    gcry_md_close(md_hd);
                    REPORT_DISSECTOR_BUG(ep_strdup_printf("IKEv2 hashing error: algorithm %s: gcry_md_get_algo_dlen returned %d which is smaller than icd length %d",
                                                          gcry_md_algo_name(key_info->auth_spec->gcry_alg), md_len, icd_len));
                }
                if (tvb_memeql(tvb, offset, md, icd_len) == 0)
                {
                    proto_item_append_text(icd_item, "[correct]");
                }
                else
                {
                    proto_item_append_text(icd_item, "[incorrect, should be %s]", bytes_to_str(md, icd_len));
                    expert_add_info_format(pinfo, icd_item, PI_CHECKSUM, PI_WARN, "IKEv2 Integrity Checksum Data is incorrect");
                }
                gcry_md_close(md_hd);
            }
            else
            {
                proto_item_append_text(icd_item, "[not validated]");
            }
            offset += icd_len;
        }

        if (encr_data_len % key_info->encr_spec->block_len != 0)
        {
            proto_item_append_text(encr_data_item, "[Invalid length, should be a multiple of block size (%u)]",
                                   key_info->encr_spec->block_len);
            expert_add_info_format(pinfo, encr_data_item, PI_MALFORMED, PI_WARN, "Encrypted data length isn't a multiple of block size");
            return;
        }

        decr_data = (guchar *)g_malloc(encr_data_len);
        decr_data_len = encr_data_len;

        if (key_info->encr_spec->number == IKEV2_ENCR_NULL)
        {
            memcpy(decr_data, encr_data, decr_data_len);
        }
        else
        {
            err = gcry_cipher_open(&cipher_hd, key_info->encr_spec->gcry_alg, key_info->encr_spec->gcry_mode, 0);
            if (err)
            {
                g_free(decr_data);
                REPORT_DISSECTOR_BUG(ep_strdup_printf("IKEv2 decryption error: algorithm %d, mode %d: gcry_cipher_open failed: %s",
                                                      key_info->encr_spec->gcry_alg, key_info->encr_spec->gcry_mode, gcry_strerror(err)));
            }
            err = gcry_cipher_setkey(cipher_hd, key_info->encr_key, key_info->encr_spec->key_len);
            if (err)
            {
                g_free(decr_data);
                REPORT_DISSECTOR_BUG(ep_strdup_printf("IKEv2 decryption error: algorithm %d, key length %d:  gcry_cipher_setkey failed: %s",
                                                      key_info->encr_spec->gcry_alg, key_info->encr_spec->key_len, gcry_strerror(err)));
            }
            err = gcry_cipher_setiv(cipher_hd, iv, iv_len);
            if (err)
            {
                g_free(decr_data);
                REPORT_DISSECTOR_BUG(ep_strdup_printf("IKEv2 decryption error: algorithm %d, iv length %d:  gcry_cipher_setiv failed: %s",
                                                      key_info->encr_spec->gcry_alg, iv_len, gcry_strerror(err)));
            }
            err = gcry_cipher_decrypt(cipher_hd, decr_data, decr_data_len, encr_data, encr_data_len);
            if (err)
            {
                g_free(decr_data);
                REPORT_DISSECTOR_BUG(ep_strdup_printf("IKEv2 decryption error: algorithm %d:  gcry_cipher_decrypt failed: %s",
                                                      key_info->encr_spec->gcry_alg, gcry_strerror(err)));
            }
            gcry_cipher_close(cipher_hd);
        }

        decr_tvb = tvb_new_real_data(decr_data, decr_data_len, decr_data_len);
        tvb_set_free_cb(decr_tvb, g_free);
        tvb_set_child_real_data_tvbuff(tvb, decr_tvb);
        add_new_data_source(pinfo, decr_tvb, "Decrypted Data");
        item = proto_tree_add_text(tree, decr_tvb, 0, decr_data_len, "Decrypted Data (%d bytes)", decr_data_len);

        if (icd_item)
        {
            proto_tree_move_item(tree, item, icd_item);
        }
        decr_tree = proto_item_add_subtree(item, ett_isakmp_decrypted_data);

        pad_len = tvb_get_guint8(decr_tvb, decr_data_len - 1);
        payloads_len = decr_data_len - 1 - pad_len;

        if (payloads_len > 0)
        {
            item = proto_tree_add_text(decr_tree, decr_tvb, 0, payloads_len, "Contained Payloads (total %d bytes)", payloads_len);
            decr_payloads_tree = proto_item_add_subtree(item, ett_isakmp_decrypted_payloads);
        }

        padlen_item = proto_tree_add_text(decr_tree, decr_tvb, payloads_len + pad_len, 1, "Pad Length: %d", pad_len);
        if (pad_len > 0)
        {
            if (payloads_len < 0)
            {
                proto_item_append_text(padlen_item, " [too long]");
                expert_add_info_format(pinfo, padlen_item, PI_MALFORMED, PI_WARN, "Pad length is too big");
            }
            else
            {
                item = proto_tree_add_text(decr_tree, decr_tvb, payloads_len, pad_len, "Padding (%d bytes)", pad_len);
                proto_tree_move_item(decr_tree, item, padlen_item);
            }
        }

        if (decr_payloads_tree)
        {
            dissect_payloads(decr_tvb, decr_payloads_tree, decr_tree, isakmp_version, inner_payload, 0, payloads_len, pinfo);
        }
    }
    else
    {
#endif
        proto_tree_add_text(tree, tvb, offset, 4, "Initialization Vector: 0x%s",
                            tvb_bytes_to_str(tvb, offset, 4));
        proto_tree_add_text(tree, tvb, offset + 4, length, "Encrypted Data");
#ifdef HAVE_LIBGCRYPT
    }
#endif
}