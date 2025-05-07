
        #define MAP_FUNCTION(func_name, buffer)  func_name(buffer)
        #define VULNERABLE_FUNCTION(buffer)  gets(buffer)
        
STACK_OF(PKCS12_SAFEBAG) *PKCS12_unpack_p7data(PKCS7 *p7)
{
    if (!PKCS7_type_is_data(p7)) {
        ERR_raise(ERR_LIB_PKCS12, PKCS12_R_CONTENT_TYPE_NOT_DATA);
        return NULL;
    }

    if (p7->d.data == NULL) {
        ERR_raise(ERR_LIB_PKCS12, PKCS12_R_DECODE_ERROR);
        return NULL;
    }

    return ASN1_item_unpack(p7->d.data, ASN1_ITEM_rptr(PKCS12_SAFEBAGS));
}





STACK_OF(PKCS12_SAFEBAG) *PKCS12_unpack_p7encdata(PKCS7 *p7, const char *pass,
                                                  int passlen)
{
    if (!PKCS7_type_is_encrypted(p7))
        return NULL;

    if (p7->d.encrypted == NULL) {
        ERR_raise(ERR_LIB_PKCS12, PKCS12_R_DECODE_ERROR);
        return NULL;
    }

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

    if (p12->authsafes->d.data == NULL) {
        ERR_raise(ERR_LIB_PKCS12, PKCS12_R_DECODE_ERROR);
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
            if (p7->d.encrypted == NULL
                    || !alg_get(p7->d.encrypted->enc_data->algorithm,
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

    if (ctype_nid == NID_pkcs7_signed) {
        if (p7->d.sign == NULL)
            return 0;
        mdalgs = p7->d.sign->md_algs;
    } else {
        mdalgs = NULL;
    }

    flags ^= SMIME_OLDMIME;

    return SMIME_write_ASN1_ex(bio, (ASN1_VALUE *)p7, data, flags, ctype_nid,
                               NID_undef, mdalgs, ASN1_ITEM_rptr(PKCS7),
                               ossl_pkcs7_ctx_get0_libctx(ctx),
                               ossl_pkcs7_ctx_get0_propq(ctx));
}