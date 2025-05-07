static int
dissect_nt_trans_setup_request(tvbuff_t *kg, packet_info *et, int tt, proto_tree *ap, int pk, nt_trans_data *tz)
{
    proto_item *item = NULL;
    proto_tree *tree = NULL;
    int old_offset = tt;
    smb_info_t *si;
    smb_nt_transact_info_t *nti;
    smb_saved_info_t *sip;

    si = (smb_info_t *)et->private_data;
    DISSECTOR_ASSERT(si);
    sip = si->sip;
    DISSECTOR_ASSERT(sip);
    nti = sip->extra_info;

    if (ap)
    {
        tvb_ensure_bytes_exist(kg, tt, pk);
        item = proto_tree_add_text(ap, kg, tt, pk,
                                   "%s Setup",
                                   val_to_str(tz->subcmd, nt_cmd_vals, "Unknown NT transaction (%u)"));
        tree = proto_item_add_subtree(item, ett_smb_nt_trans_setup);
    }

    switch (tz->subcmd)
    {
    case NT_TRANS_CREATE:
        break;
    case NT_TRANS_IOCTL:
    {
        guint16 fid;

        tt = dissect_smb2_ioctl_function(kg, et, tree, tt, &nti->ioctl_function);

        fid = tvb_get_letohs(kg, tt);
        dissect_smb_fid(kg, et, tree, tt, 2, fid, FALSE, FALSE, FALSE);
        tt += 2;

        proto_tree_add_item(tree, hf_smb_nt_ioctl_isfsctl, kg, tt, 1, TRUE);
        tt += 1;
        tt = dissect_nt_ioctl_flags(kg, tree, tt);

        break;
    }
    case NT_TRANS_SSD:
        break;
    case NT_TRANS_NOTIFY:
    {
        guint16 fid;

        tt = dissect_nt_notify_completion_filter(kg, tree, tt);

        fid = tvb_get_letohs(kg, tt);
        dissect_smb_fid(kg, et, tree, tt, 2, fid, FALSE, FALSE, FALSE);
        tt += 2;

        proto_tree_add_item(tree, hf_smb_nt_notify_watch_tree, kg, tt, 1, TRUE);
        tt += 1;

        proto_tree_add_item(tree, hf_smb_reserved, kg, tt, 1, TRUE);
        tt += 1;

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

    return old_offset + pk;
