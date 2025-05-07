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
dissect_negprot_request(tvbuff_t *tvb, packet_info *pinfo _U_, proto_tree *tree, int offset, proto_tree *smb_tree _U_)
{
    proto_item *it = NULL;
    proto_tree *tr = NULL;
    guint16 bc;
    guint8 wc;
    struct negprot_dialects *dialects = NULL;
    smb_info_t *si;

    si = (smb_info_t *)pinfo->private_data;
    DISSECTOR_ASSERT(si);

    WORD_COUNT;

    BYTE_COUNT;

    if (tree)
    {
        tvb_ensure_bytes_exist(tvb, offset, bc);
        it = proto_tree_add_text(tree, tvb, offset, bc,
                                 "Requested Dialects");
        tr = proto_item_add_subtree(it, ett_smb_dialects);
    }

    if (!pinfo->fd->flags.visited && si->sip)
    {

        dialects->num = 0;
        si->sip->extra_info_type = SMB_EI_DIALECTS;
        si->sip->extra_info = dialects;
    }

    while (bc)
    {
        int len;
        const guint8 *str;
        proto_item *dit = NULL;
        proto_tree *dtr = NULL;

        tvb_ensure_bytes_exist(tvb, offset + 1, 1);
        len = tvb_strsize(tvb, offset + 1);
        str = tvb_get_ptr(tvb, offset + 1, len);

        if (tr)
        {
            dit = proto_tree_add_text(tr, tvb, offset, len + 1,
                                      "Dialect: %s", str);
            dtr = proto_item_add_subtree(dit, ett_smb_dialect);
        }

        CHECK_BYTE_COUNT(1);
        proto_tree_add_item(dtr, hf_smb_buffer_format, tvb, offset, 1,
                            TRUE);
        COUNT_BYTES(1);

        CHECK_BYTE_COUNT(len);
        proto_tree_add_string(dtr, hf_smb_dialect_name, tvb, offset,
                              len, str);
        COUNT_BYTES(len);

        if (!pinfo->fd->flags.visited && dialects && dialects->num < MAX_DIALECTS)
        {
            dialects->name[dialects->num++] = se_strdup(str);
        }
    }

    END_OF_SMB

    return offset;
}