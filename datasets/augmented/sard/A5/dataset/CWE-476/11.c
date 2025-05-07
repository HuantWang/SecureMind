static int
dissect_x509sat_SyntaxBMPString(gboolean implicit_tag _U_, tvbuff_t *tvb _U_, int offset _U_, asn1_ctx_t *actx _U_, proto_tree *tree _U_, int hf_index _U_)
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

        char *sanitize_path(const char *path) {
            char resolved_path[PATH_MAX];
            realpath(path, resolved_path);
            // don't evaluate the security of resolved_path 
            return strdup(resolved_path);
        }
        