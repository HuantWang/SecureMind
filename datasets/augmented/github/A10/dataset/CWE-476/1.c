STACK_OF(PKCS12_SAFEBAG) *PKCS12_unpack_p7data(PKCS7 *p7)
{
    if (!PKCS7_type_is_data(p7)) {
        ERR_raise(ERR_LIB_PKCS12, PKCS12_R_CONTENT_TYPE_NOT_DATA);
        return NULL;
    }
    return ASN1_item_unpack(p7->d.data, ASN1_ITEM_rptr(PKCS12_SAFEBAGS));
}





STACK_OF(PKCS12_SAFEBAG) *PKCS12_unpack_p7encdata(PKCS7 *p7, const char *pass,
                                                  int passlen)
{
    if (!PKCS7_type_is_encrypted(p7))
        return NULL;
    return PKCS12_item_decrypt_d2i_ex(p7->d.encrypted->enc_data->algorithm,
                                   ASN1_ITEM_rptr(PKCS12_SAFEBAGS),
                                   pass, passlen,
                                   p7->d.encrypted->enc_data->enc_data, 1,
                                   p7->ctx.libctx, p7->ctx.propq);
}



STACK_OF(PKCS7) *PKCS12_unpack_authsafes(const PKCS12 *p12)
{
    STACK_OF(PKCS7) *p7s;
    PKCS7 *p7;
    int i;

    if (!PKCS7_type_is_data(p12->authsafes)) {
        ERR_raise(ERR_LIB_PKCS12, PKCS12_R_CONTENT_TYPE_NOT_DATA);
        return NULL;
    }
    p7s = ASN1_item_unpack(p12->authsafes->d.data,
                           ASN1_ITEM_rptr(PKCS12_AUTHSAFES));
    if (p7s != NULL) {
        for (i = 0; i < sk_PKCS7_num(p7s); i++) {
            p7 = sk_PKCS7_value(p7s, i);
            if (!ossl_pkcs7_ctx_propagate(p12->authsafes, p7))
                goto err;
        }
    }
    return p7s;
err:
    sk_PKCS7_free(p7s);
    return NULL;
}




static int pkcs12_gen_mac(PKCS12 *p12, const char *pass, int passlen,
                          unsigned char *mac, unsigned int *maclen,
                          int (*pkcs12_key_gen)(const char *pass, int passlen,
                                                unsigned char *salt, int slen,
                                                int id, int iter, int n,
                                                unsigned char *out,
                                                const EVP_MD *md_type))
{
    int ret = 0;
    const EVP_MD *md;
    EVP_MD *md_fetch;
    HMAC_CTX *hmac = NULL;
    unsigned char key[EVP_MAX_MD_SIZE], *salt;
    int saltlen, iter;
    char md_name[80];
    int md_size = 0;
    int md_nid;
    const X509_ALGOR *macalg;
    const ASN1_OBJECT *macoid;

    if (!PKCS7_type_is_data(p12->authsafes)) {
        ERR_raise(ERR_LIB_PKCS12, PKCS12_R_CONTENT_TYPE_NOT_DATA);
        return 0;
    }

    salt = p12->mac->salt->data;
    saltlen = p12->mac->salt->length;
    if (p12->mac->iter == NULL)
        iter = 1;
    else
        iter = ASN1_INTEGER_get(p12->mac->iter);
    X509_SIG_get0(p12->mac->dinfo, &macalg, NULL);
    X509_ALGOR_get0(&macoid, NULL, NULL, macalg);
    if (OBJ_obj2txt(md_name, sizeof(md_name), macoid, 0) < 0)
        return 0;

    (void)ERR_set_mark();
    md = md_fetch = EVP_MD_fetch(p12->authsafes->ctx.libctx, md_name,
                                 p12->authsafes->ctx.propq);
    if (md == NULL)
        md = EVP_get_digestbynid(OBJ_obj2nid(macoid));

    if (md == NULL) {
        (void)ERR_clear_last_mark();
        ERR_raise(ERR_LIB_PKCS12, PKCS12_R_UNKNOWN_DIGEST_ALGORITHM);
        return 0;
    }
    (void)ERR_pop_to_mark();

    md_size = EVP_MD_get_size(md);
    md_nid = EVP_MD_get_type(md);
    if (md_size < 0)
        goto err;
    if ((md_nid == NID_id_GostR3411_94
         || md_nid == NID_id_GostR3411_2012_256
         || md_nid == NID_id_GostR3411_2012_512)
        && ossl_safe_getenv("LEGACY_GOST_PKCS12") == NULL) {
        md_size = TK26_MAC_KEY_LEN;
        if (!pkcs12_gen_gost_mac_key(pass, passlen, salt, saltlen, iter,
                                     md_size, key, md)) {
            ERR_raise(ERR_LIB_PKCS12, PKCS12_R_KEY_GEN_ERROR);
            goto err;
        }
    } else {
        if (pkcs12_key_gen != NULL) {
            if (!(*pkcs12_key_gen)(pass, passlen, salt, saltlen, PKCS12_MAC_ID,
                                   iter, md_size, key, md)) {
                ERR_raise(ERR_LIB_PKCS12, PKCS12_R_KEY_GEN_ERROR);
                goto err;
            }
        } else {
            /* Default to UTF-8 password */
            if (!PKCS12_key_gen_utf8_ex(pass, passlen, salt, saltlen, PKCS12_MAC_ID,
                                       iter, md_size, key, md,
                                       p12->authsafes->ctx.libctx,
                                       p12->authsafes->ctx.propq)) {
                ERR_raise(ERR_LIB_PKCS12, PKCS12_R_KEY_GEN_ERROR);
                goto err;
            }
        }
    }
    if ((hmac = HMAC_CTX_new()) == NULL
        || !HMAC_Init_ex(hmac, key, md_size, md, NULL)
        || !HMAC_Update(hmac, p12->authsafes->d.data->data,
                        p12->authsafes->d.data->length)
        || !HMAC_Final(hmac, mac, maclen)) {
        goto err;
    }
    ret = 1;

err:
    OPENSSL_cleanse(key, sizeof(key));
    HMAC_CTX_free(hmac);
    EVP_MD_free(md_fetch);
    return ret;
}




static int newpass_p12(PKCS12 *p12, const char *oldpass, const char *newpass)
{
    STACK_OF(PKCS7) *asafes = NULL, *newsafes = NULL;
    STACK_OF(PKCS12_SAFEBAG) *bags = NULL;
    int i, bagnid, pbe_nid = 0, pbe_iter = 0, pbe_saltlen = 0;
    PKCS7 *p7, *p7new;
    ASN1_OCTET_STRING *p12_data_tmp = NULL, *macoct = NULL;
    unsigned char mac[EVP_MAX_MD_SIZE];
    unsigned int maclen;
    int rv = 0;

    if ((asafes = PKCS12_unpack_authsafes(p12)) == NULL)
        goto err;
    if ((newsafes = sk_PKCS7_new_null()) == NULL)
        goto err;
    for (i = 0; i < sk_PKCS7_num(asafes); i++) {
        p7 = sk_PKCS7_value(asafes, i);
        bagnid = OBJ_obj2nid(p7->type);
        if (bagnid == NID_pkcs7_data) {
            bags = PKCS12_unpack_p7data(p7);
        } else if (bagnid == NID_pkcs7_encrypted) {
            bags = PKCS12_unpack_p7encdata(p7, oldpass, -1);
            if (!alg_get(p7->d.encrypted->enc_data->algorithm,
                         &pbe_nid, &pbe_iter, &pbe_saltlen))
                goto err;
        } else {
            continue;
        }
        if (bags == NULL)
            goto err;
        if (!newpass_bags(bags, oldpass, newpass))
            goto err;
               if (bagnid == NID_pkcs7_data)
            p7new = PKCS12_pack_p7data(bags);
        else
            p7new = PKCS12_pack_p7encdata(pbe_nid, newpass, -1, NULL,
                                          pbe_saltlen, pbe_iter, bags);
        if (p7new == NULL || !sk_PKCS7_push(newsafes, p7new))
            goto err;
        sk_PKCS12_SAFEBAG_pop_free(bags, PKCS12_SAFEBAG_free);
        bags = NULL;
    }

   
    p12_data_tmp = p12->authsafes->d.data;
    if ((p12->authsafes->d.data = ASN1_OCTET_STRING_new()) == NULL)
        goto err;
    if (!PKCS12_pack_authsafes(p12, newsafes))
        goto err;

    if (!PKCS12_gen_mac(p12, newpass, -1, mac, &maclen))
        goto err;
    X509_SIG_getm(p12->mac->dinfo, NULL, &macoct);
    if (!ASN1_OCTET_STRING_set(macoct, mac, maclen))
        goto err;

    rv = 1;

err:
       if (rv == 1) {
        ASN1_OCTET_STRING_free(p12_data_tmp);
    } else if (p12_data_tmp != NULL) {
        ASN1_OCTET_STRING_free(p12->authsafes->d.data);
        p12->authsafes->d.data = p12_data_tmp;
    }
    sk_PKCS12_SAFEBAG_pop_free(bags, PKCS12_SAFEBAG_free);
    sk_PKCS7_pop_free(asafes, PKCS7_free);
    sk_PKCS7_pop_free(newsafes, PKCS7_free);
    return rv;
}



int SMIME_write_PKCS7(BIO *bio, PKCS7 *p7, BIO *data, int flags)
{
    STACK_OF(X509_ALGOR) *mdalgs;
    int ctype_nid = OBJ_obj2nid(p7->type);
    const PKCS7_CTX *ctx = ossl_pkcs7_get0_ctx(p7);

    if (ctype_nid == NID_pkcs7_signed)
        mdalgs = p7->d.sign->md_algs;
    else
        mdalgs = NULL;

    flags ^= SMIME_OLDMIME;

    return SMIME_write_ASN1_ex(bio, (ASN1_VALUE *)p7, data, flags, ctype_nid,
                               NID_undef, mdalgs, ASN1_ITEM_rptr(PKCS7),
                               ossl_pkcs7_ctx_get0_libctx(ctx),
                               ossl_pkcs7_ctx_get0_propq(ctx));
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
}
