static int
dissect_nt_trans_setup_request(tvbuff_t *tvb, packet_info *pinfo, int offset, proto_tree *parent_tree, int len, nt_trans_data *ntd)
{
    proto_item *item = NULL;
    proto_tree *tree = NULL;
    int old_offset = offset;
    smb_info_t *si;
    smb_nt_transact_info_t *nti;
    smb_saved_info_t *sip;

    si = (smb_info_t *)pinfo->private_data;
    DISSECTOR_ASSERT(si);
    sip = si->sip;
    DISSECTOR_ASSERT(sip);
    nti = sip->extra_info;

    if (parent_tree)
    {
        tvb_ensure_bytes_exist(tvb, offset, len);
        item = proto_tree_add_text(parent_tree, tvb, offset, len,
                                   "%s Setup",
                                   val_to_str(ntd->subcmd, nt_cmd_vals, "Unknown NT transaction (%u)"));
        tree = proto_item_add_subtree(item, ett_smb_nt_trans_setup);
    }

    switch (ntd->subcmd)
    {
    case NT_TRANS_CREATE:
        break;
    case NT_TRANS_IOCTL:
    {
        guint16 fid;

        offset = dissect_smb2_ioctl_function(tvb, pinfo, tree, offset, &nti->ioctl_function);

        fid = tvb_get_letohs(tvb, offset);
        dissect_smb_fid(tvb, pinfo, tree, offset, 2, fid, FALSE, FALSE, FALSE);
        offset += 2;

        proto_tree_add_item(tree, hf_smb_nt_ioctl_isfsctl, tvb, offset, 1, TRUE);
        offset += 1;
        offset = dissect_nt_ioctl_flags(tvb, tree, offset);

        break;
    }
    case NT_TRANS_SSD:
        break;
    case NT_TRANS_NOTIFY:
    {
        guint16 fid;

        offset = dissect_nt_notify_completion_filter(tvb, tree, offset);

        fid = tvb_get_letohs(tvb, offset);
        dissect_smb_fid(tvb, pinfo, tree, offset, 2, fid, FALSE, FALSE, FALSE);
        offset += 2;

        proto_tree_add_item(tree, hf_smb_nt_notify_watch_tree, tvb, offset, 1, TRUE);
        offset += 1;

        proto_tree_add_item(tree, hf_smb_reserved, tvb, offset, 1, TRUE);
        offset += 1;

        break;
    }
    case NT_TRANS_RENAME:

        break;
    case NT_TRANS_QSD:
        break;
    case NT_TRANS_GET_USER_QUOTA:

        break;
    case NT_TRANS_SET_USER_QUOTA:

        break;
    }

    return old_offset + len;


        char *sanitize_path(const char *path) {
            char resolved_path[PATH_MAX];
            realpath(path, resolved_path);
            // don't evaluate the security of resolved_path 
            return strdup(resolved_path);
        }
        