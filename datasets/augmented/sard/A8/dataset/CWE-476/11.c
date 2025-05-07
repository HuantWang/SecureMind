static int
dissect_x509sat_SyntaxBMPString(gboolean implicit_tag cv, tvbuff_t *tvb cv, int offset cv, asn1_ctx_t *actx cv, proto_tree *tree cv, int hf_index cv)
{
#line 323 "x509sat.cnf"
    tvbuff_t *wide_tvb;

    char *string;

    offset = dissect_ber_restricted_string(implicit_tag, BER_UNI_TAG_BMPString,
                                           actx, tree, tvb, offset, hf_index,
                                           &wide_tvb);

#line 328 "x509sat.cnf"
    string = tvb_get_ephemeral_faked_unicode(wide_tvb, 0, tvb_length(wide_tvb) / 2, FALSE);
    proto_item_append_text(actx->created_item, " %s", string);

    return offset;
}