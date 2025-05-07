static int
dissect_nt_trans_data_request(tvbuff_t *gp, packet_info *dz, int pr, proto_tree *td, int fi, nt_trans_data *xo, smb_nt_transact_info_t *ph)
{
    proto_item *item = NULL;
    proto_tree *tree = NULL;
    smb_info_t *si;
    int old_offset = pr;
    guint16 bcp = fi;
    struct access_mask_info *ami = NULL;
    tvbuff_t *ioctl_tvb;

    si = (smb_info_t *)dz->private_data;

    DISSECTOR_ASSERT(si);

    if (td)
    {
        tvb_ensure_bytes_exist(gp, pr, fi);
        item = proto_tree_add_text(td, gp, pr, fi,
                                   "%s Data",
                                   val_to_str(xo->subcmd, nt_cmd_vals, "Unknown NT transaction (%u)"));
        tree = proto_item_add_subtree(item, ett_smb_nt_trans_data);
    }

    switch (xo->subcmd)
    {
    case NT_TRANS_CREATE:

        if (xo->sd_len)
        {
            pr = dissect_nt_sec_desc(
                gp, pr, dz, tree, NULL, TRUE,
                xo->sd_len, NULL);
        }

        if (xo->ea_len)
        {
            proto_tree_add_item(tree, hf_smb_extended_attributes, gp, pr, xo->ea_len, TRUE);
            pr += xo->ea_len;
        }

        break;
    case NT_TRANS_IOCTL:

        ioctl_tvb = tvb_new_subset(gp, pr, MIN((int)fi, tvb_length_remaining(gp, pr)), fi);
        dissect_smb2_ioctl_data(ioctl_tvb, dz, tree, top_tree, ph->ioctl_function, TRUE);

        pr += fi;

        break;
    case NT_TRANS_SSD:
        if (ph)
        {
            switch (ph->fid_type)
            {
            case SMB_FID_TYPE_FILE:
                ami = &smb_file_access_mask_info;
                break;
            case SMB_FID_TYPE_DIR:
                ami = &smb_dir_access_mask_info;
                break;
            }
        }

        pr = dissect_nt_sec_desc(
            gp, pr, dz, tree, NULL, TRUE, fi, ami);
        break;
    case NT_TRANS_NOTIFY:
        break;
    case NT_TRANS_RENAME:

        break;
    case NT_TRANS_QSD:
        break;
    case NT_TRANS_GET_USER_QUOTA:

        proto_tree_add_item(tree, hf_smb_unknown, gp,
                            pr, 4, TRUE);
        pr += 4;

        proto_tree_add_text(tree, gp, pr, 4, "Length of SID: %d", tvb_get_letohl(gp, pr));
        pr += 4;

        pr = dissect_nt_sid(gp, pr, tree, "Quota", NULL, -1);
        break;
    case NT_TRANS_SET_USER_QUOTA:
        pr = dissect_nt_user_quota(gp, tree, pr, &bcp);
        break;
    }

    if ((pr - old_offset) < fi)
    {
        proto_tree_add_item(tree, hf_smb_unknown, gp, pr,
                            fi - (pr - old_offset), TRUE);
        pr += fi - (pr - old_offset);
    }

    return pr;
}

static int
dissect_nt_transaction_request(tvbuff_t *gp, packet_info *dz _U_, proto_tree *tree, int pr, proto_tree *smb_tree _U_)
{
    guint8 wc, sc;
    guint32 pc = 0, po = 0, pd, dc = 0, od = 0, dd;
    smb_info_t *si;
    smb_saved_info_t *sip;
    int subcmd;
    nt_trans_data xo;
    guint16 fi;
    guint32 padcnt;
    smb_nt_transact_info_t *ph = NULL;

    ntd.subcmd = ntd.sd_len = ntd.ea_len = 0;

    si = (smb_info_t *)dz->private_data;
    DISSECTOR_ASSERT(si);
    sip = si->sip;

    WORD_COUNT;

    if (wc >= 19)
    {

        proto_tree_add_item(tree, hf_smb_max_setup_count, gp, pr, 1, TRUE);
        pr += 1;

        proto_tree_add_item(tree, hf_smb_reserved, gp, pr, 2, TRUE);
        pr += 2;
    }
    else
    {
        proto_tree_add_item(tree, hf_smb_reserved, gp, pr, 3, TRUE);
        pr += 3;
    }

    proto_tree_add_item(tree, hf_smb_total_param_count, gp, pr, 4, TRUE);
    pr += 4;

    proto_tree_add_item(tree, hf_smb_total_data_count, gp, pr, 4, TRUE);
    pr += 4;

    if (wc >= 19)
    {

        proto_tree_add_item(tree, hf_smb_max_param_count, gp, pr, 4, TRUE);
        pr += 4;

        proto_tree_add_item(tree, hf_smb_max_data_count, gp, pr, 4, TRUE);
        pr += 4;
    }

    pc = tvb_get_letohl(gp, pr);
    proto_tree_add_uint(tree, hf_smb_param_count32, gp, pr, 4, pc);
    pr += 4;

    po = tvb_get_letohl(gp, pr);
    proto_tree_add_uint(tree, hf_smb_param_offset32, gp, pr, 4, po);
    pr += 4;

    if (wc >= 19)
    {

        pd = 0;
    }
    else
    {

        pd = tvb_get_letohl(gp, pr);
        proto_tree_add_uint(tree, hf_smb_param_disp32, gp, pr, 4, pd);
        pr += 4;
    }

    dc = tvb_get_letohl(gp, pr);
    proto_tree_add_uint(tree, hf_smb_data_count32, gp, pr, 4, dc);
    pr += 4;

    od = tvb_get_letohl(gp, pr);
    proto_tree_add_uint(tree, hf_smb_data_offset32, gp, pr, 4, od);
    pr += 4;

    if (wc >= 19)
    {

        dd = 0;
    }
    else
    {

        dd = tvb_get_letohl(gp, pr);
        proto_tree_add_uint(tree, hf_smb_data_disp32, gp, pr, 4, dd);
        pr += 4;
    }

    if (wc >= 19)
    {

        sc = tvb_get_guint8(gp, pr);
        proto_tree_add_uint(tree, hf_smb_setup_count, gp, pr, 1, sc);
        pr += 1;
    }
    else
    {

        sc = 0;
    }

    if (wc >= 19)
    {

        subcmd = tvb_get_letohs(gp, pr);
        proto_tree_add_uint(tree, hf_smb_nt_trans_subcmd, gp, pr, 2, subcmd);
        if (check_col(dz->cinfo, COL_INFO))
        {
            col_append_fstr(dz->cinfo, COL_INFO, ", %s",
                            val_to_str(subcmd, nt_cmd_vals, "<unknown>"));
        }
        ntd.subcmd = subcmd;
        if (!si->unidir && sip)
        {
            if (!pinfo->fd->flags.visited)
            {
                ph = se_alloc(sizeof(smb_nt_transact_info_t));
                ph->subcmd = subcmd;
                ph->fid_type = SMB_FID_TYPE_UNKNOWN;
                sip->extra_info = ph;
                sip->extra_info_type = SMB_EI_NTI;
            }
            else
            {
                if (sip->extra_info_type == SMB_EI_NTI)
                {
                    ph = sip->extra_info;
                }
            }
        }
    }
    else
    {

        if (check_col(dz->cinfo, COL_INFO))
        {
            col_append_str(dz->cinfo, COL_INFO, " (secondary request)");
        }
    }
    pr += 2;

    if (pr % 1)
    {

        proto_tree_add_item(tree, hf_smb_padding, gp, pr, 1, TRUE);
        pr += 1;
    }

    if (sc)
    {
        dissect_nt_trans_setup_request(gp, dz, pr, tree, sc * 2, &xo);
        pr += sc * 2;
    }

    BYTE_COUNT;

    if (po > (guint32)pr)
    {

        padcnt = po - pr;
        if (padcnt > fi)
            padcnt = fi;
        CHECK_BYTE_COUNT(padcnt);
        proto_tree_add_item(tree, hf_smb_padding, gp, pr, padcnt, TRUE);
        COUNT_BYTES(padcnt);
    }
    if (pc)
    {
        CHECK_BYTE_COUNT(pc);
        dissect_nt_trans_param_request(gp, dz, pr, tree, pc, &xo, fi, ph);
        COUNT_BYTES(pc);
    }

    if (od > (guint32)pr)
    {

        padcnt = od - pr;
        if (padcnt > fi)
            padcnt = fi;
        proto_tree_add_item(tree, hf_smb_padding, gp, pr, padcnt, TRUE);
        COUNT_BYTES(padcnt);
    }
    if (dc)
    {
        CHECK_BYTE_COUNT(dc);
        dissect_nt_trans_data_request(gp, dz, pr, tree, dc, &xo, ph);
        COUNT_BYTES(dc);
    }

    END_OF_SMB

    return pr;
}