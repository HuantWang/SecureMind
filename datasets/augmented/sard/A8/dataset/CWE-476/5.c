static int
dissect_transaction2_request_parameters(tvbuff_t *vq, packet_info *mz,
                                        proto_tree *zj, int vx, int sk, guint16 xt)
{
    proto_item *item = NULL;
    proto_tree *tree = NULL;
    smb_info_t *si;
    smb_transact2_info_t *t2i;
    int fn_len;
    const char *fn;

    si = (smb_info_t *)mz->private_data;
    DISSECTOR_ASSERT(si);

    if (si->sip != NULL && si->sip->extra_info_type == SMB_EI_T2I)
        t2i = si->sip->extra_info;
    else
        t2i = NULL;

    if (zj)
    {
        tvb_ensure_bytes_exist(vq, vx, xt);
        item = proto_tree_add_text(zj, vq, vx, xt,
                                   "%s Parameters",
                                   val_to_str(sk, trans2_cmd_vals,
                                              "Unknown (0x%02x)"));
        tree = proto_item_add_subtree(item, ett_smb_transaction_params);
    }

    switch (sk)
    {
    case 0x00:
        CHECK_BYTE_COUNT_TRANS(2);
        vx = dissect_open_flags(vq, tree, vx, 0x000f);
        xt -= 2;

        CHECK_BYTE_COUNT_TRANS(2);
        vx = dissect_access(vq, tree, vx, "Desired");
        xt -= 2;

        CHECK_BYTE_COUNT_TRANS(2);
        vx = dissect_search_attributes(vq, tree, vx);
        xt -= 2;

        CHECK_BYTE_COUNT_TRANS(2);
        vx = dissect_file_attributes(vq, tree, vx, 2);
        xt -= 2;

        CHECK_BYTE_COUNT_TRANS(4);
        vx = dissect_smb_datetime(vq, tree, vx,
                                      hf_smb_create_time,
                                      hf_smb_create_dos_date, hf_smb_create_dos_time,
                                      TRUE);
        xt -= 4;

        CHECK_BYTE_COUNT_TRANS(2);
        vx = dissect_open_function(vq, tree, vx);
        xt -= 2;

        CHECK_BYTE_COUNT_TRANS(4);
        proto_tree_add_item(tree, hf_smb_alloc_size, vq, vx, 4, TRUE);
        COUNT_BYTES_TRANS(4);

        CHECK_BYTE_COUNT_TRANS(10);
        proto_tree_add_item(tree, hf_smb_reserved, vq, vx, 10, TRUE);
        COUNT_BYTES_TRANS(10);

        fn = get_unicode_or_ascii_string(vq, &vx, si->unicode, &fn_len, FALSE, FALSE, &xt);
        CHECK_STRING_TRANS(fn);
        proto_tree_add_string(tree, hf_smb_file_name, vq, vx, fn_len,
                              fn);
        COUNT_BYTES_TRANS(fn_len);

        if (check_col(mz->cinfo, COL_INFO))
        {
            col_append_fstr(mz->cinfo, COL_INFO, ", Path: %s",
                            format_text(fn, strlen(fn)));
        }
        break;
    case 0x01:
        CHECK_BYTE_COUNT_TRANS(2);
        vx = dissect_search_attributes(vq, tree, vx);
        xt -= 2;

        CHECK_BYTE_COUNT_TRANS(2);
        proto_tree_add_item(tree, hf_smb_search_count, vq, vx, 2, TRUE);
        COUNT_BYTES_TRANS(2);

        CHECK_BYTE_COUNT_TRANS(2);
        vx = dissect_ff2_flags(vq, mz, tree, vx);
        xt -= 2;

        CHECK_BYTE_COUNT_TRANS(2);
        si->info_level = tvb_get_letohs(vq, vx);
        if (t2i != NULL && !pinfo->fd->flags.visited)
            t2i->info_level = si->info_level;
        proto_tree_add_uint(tree, hf_smb_ff2_information_level, vq, vx, 2, si->info_level);
        COUNT_BYTES_TRANS(2);

        CHECK_BYTE_COUNT_TRANS(4);
        proto_tree_add_item(tree, hf_smb_storage_type, vq, vx, 4, TRUE);
        COUNT_BYTES_TRANS(4);

        fn = get_unicode_or_ascii_string(vq, &vx, si->unicode, &fn_len, FALSE, FALSE, &xt);
        CHECK_STRING_TRANS(fn);
        if (!t2i->name)
        {
            t2i->name = se_strdup(fn);
        }
        proto_tree_add_string(tree, hf_smb_search_pattern, vq, vx, fn_len,
                              fn);
        COUNT_BYTES_TRANS(fn_len);

        if (check_col(mz->cinfo, COL_INFO))
        {
            col_append_fstr(mz->cinfo, COL_INFO, ", Pattern: %s",
                            format_text(fn, strlen(fn)));
        }

        break;
    case 0x02:
        CHECK_BYTE_COUNT_TRANS(2);
        proto_tree_add_item(tree, hf_smb_search_id, vq, vx, 2, TRUE);
        COUNT_BYTES_TRANS(2);

        CHECK_BYTE_COUNT_TRANS(2);
        proto_tree_add_item(tree, hf_smb_search_count, vq, vx, 2, TRUE);
        COUNT_BYTES_TRANS(2);

        CHECK_BYTE_COUNT_TRANS(2);
        si->info_level = tvb_get_letohs(vq, vx);
        if (t2i != NULL && !pinfo->fd->flags.visited)
            t2i->info_level = si->info_level;
        proto_tree_add_uint(tree, hf_smb_ff2_information_level, vq, vx, 2, si->info_level);
        COUNT_BYTES_TRANS(2);

        CHECK_BYTE_COUNT_TRANS(4);
        proto_tree_add_item(tree, hf_smb_resume, vq, vx, 4, TRUE);
        COUNT_BYTES_TRANS(4);

        CHECK_BYTE_COUNT_TRANS(2);
        vx = dissect_ff2_flags(vq, mz, tree, vx);
        xt -= 2;

        fn = get_unicode_or_ascii_string(vq, &vx, si->unicode, &fn_len, FALSE, FALSE, &xt);
        CHECK_STRING_TRANS(fn);
        proto_tree_add_string(tree, hf_smb_file_name, vq, vx, fn_len,
                              fn);
        COUNT_BYTES_TRANS(fn_len);

        if (check_col(mz->cinfo, COL_INFO))
        {
            col_append_fstr(mz->cinfo, COL_INFO, ", Continue: %s",
                            format_text(fn, strlen(fn)));
        }

        break;
    case 0x03:
        CHECK_BYTE_COUNT_TRANS(2);
        si->info_level = tvb_get_letohs(vq, vx);
        if (t2i != NULL && !pinfo->fd->flags.visited)
            t2i->info_level = si->info_level;
        proto_tree_add_uint(tree, hf_smb_qfsi_information_level, vq, vx, 2, si->info_level);
        COUNT_BYTES_TRANS(2);

        if (check_col(mz->cinfo, COL_INFO))
            col_append_fstr(mz->cinfo, COL_INFO, ", %s",
                            val_to_str(si->info_level, qfsi_vals,
                                       "Unknown (0x%02x)"));

        break;
    case 0x05:
        CHECK_BYTE_COUNT_TRANS(2);
        si->info_level = tvb_get_letohs(vq, vx);
        if (t2i != NULL && !pinfo->fd->flags.visited)
            t2i->info_level = si->info_level;
        proto_tree_add_uint(tree, hf_smb_qpi_loi, vq, vx, 2, si->info_level);
        COUNT_BYTES_TRANS(2);

        if (check_col(mz->cinfo, COL_INFO))
        {
            col_append_fstr(
                mz->cinfo, COL_INFO, ", %s",
                val_to_str(si->info_level, qpi_loi_vals,
                           "Unknown (%u)"));
        }

        CHECK_BYTE_COUNT_TRANS(4);
        proto_tree_add_item(tree, hf_smb_reserved, vq, vx, 4, TRUE);
        COUNT_BYTES_TRANS(4);

        fn = get_unicode_or_ascii_string(vq, &vx, si->unicode, &fn_len, FALSE, FALSE, &xt);
        CHECK_STRING_TRANS(fn);
        proto_tree_add_string(tree, hf_smb_file_name, vq, vx, fn_len,
                              fn);
        COUNT_BYTES_TRANS(fn_len);
        if (!t2i->name)
        {
            t2i->name = se_strdup(fn);
        }

        if (check_col(mz->cinfo, COL_INFO))
        {
            col_append_fstr(mz->cinfo, COL_INFO, ", Path: %s",
                            format_text(fn, strlen(fn)));
        }

        break;
    case 0x06:
        CHECK_BYTE_COUNT_TRANS(2);
        si->info_level = tvb_get_letohs(vq, vx);
        if (t2i != NULL && !pinfo->fd->flags.visited)
            t2i->info_level = si->info_level;
        proto_tree_add_uint(tree, hf_smb_spi_loi, vq, vx, 2, si->info_level);
        COUNT_BYTES_TRANS(2);

        CHECK_BYTE_COUNT_TRANS(4);
        proto_tree_add_item(tree, hf_smb_reserved, vq, vx, 4, TRUE);
        COUNT_BYTES_TRANS(4);

        fn = get_unicode_or_ascii_string(vq, &vx, si->unicode, &fn_len, FALSE, FALSE, &xt);
        CHECK_STRING_TRANS(fn);
        proto_tree_add_string(tree, hf_smb_file_name, vq, vx, fn_len,
                              fn);
        COUNT_BYTES_TRANS(fn_len);

        if (check_col(mz->cinfo, COL_INFO))
        {
            col_append_fstr(mz->cinfo, COL_INFO, ", Path: %s",
                            format_text(fn, strlen(fn)));
        }

        break;
    case 0x07:
    {
        guint16 fid;

        CHECK_BYTE_COUNT_TRANS(2);
        fid = tvb_get_letohs(vq, vx);
        dissect_smb_fid(vq, mz, tree, vx, 2, fid, FALSE, FALSE, FALSE);
        COUNT_BYTES_TRANS(2);

        CHECK_BYTE_COUNT_TRANS(2);
        si->info_level = tvb_get_letohs(vq, vx);
        if (t2i != NULL && !pinfo->fd->flags.visited)
            t2i->info_level = si->info_level;
        proto_tree_add_uint(tree, hf_smb_qpi_loi, vq, vx, 2, si->info_level);
        COUNT_BYTES_TRANS(2);

        if (check_col(mz->cinfo, COL_INFO))
        {
            col_append_fstr(
                mz->cinfo, COL_INFO, ", %s",
                val_to_str(si->info_level, qpi_loi_vals,
                           "Unknown (%u)"));
        }

        break;
    }
    case 0x08:
    {
        guint16 fid;

        CHECK_BYTE_COUNT_TRANS(2);
        fid = tvb_get_letohs(vq, vx);
        dissect_smb_fid(vq, mz, tree, vx, 2, fid, FALSE, FALSE, FALSE);
        COUNT_BYTES_TRANS(2);

        CHECK_BYTE_COUNT_TRANS(2);
        si->info_level = tvb_get_letohs(vq, vx);
        if (t2i != NULL && !pinfo->fd->flags.visited)
            t2i->info_level = si->info_level;
        proto_tree_add_uint(tree, hf_smb_spi_loi, vq, vx, 2, si->info_level);
        COUNT_BYTES_TRANS(2);

#if 0
		CHECK_BYTE_COUNT_TRANS(2);
		offset = dissect_sfi_ioflag(vq, tree, vx);
		bc -= 2;
#else

        CHECK_BYTE_COUNT_TRANS(2);
        proto_tree_add_item(tree, hf_smb_reserved, vq, vx, 2, TRUE);
        COUNT_BYTES_TRANS(2);
#endif

        break;
    }
    case 0x09:
        break;
    case 0x0a:
        break;
    case 0x0b:
    {
        CHECK_BYTE_COUNT_TRANS(2);
        vx = dissect_search_attributes(vq, tree, vx);
        xt -= 2;

        CHECK_BYTE_COUNT_TRANS(2);
        proto_tree_add_item(tree, hf_smb_change_count, vq, vx, 2, TRUE);
        COUNT_BYTES_TRANS(2);

        CHECK_BYTE_COUNT_TRANS(2);
        si->info_level = tvb_get_letohs(vq, vx);
        if (t2i != NULL && !pinfo->fd->flags.visited)
            t2i->info_level = si->info_level;
        proto_tree_add_uint(tree, hf_smb_fn_information_level, vq, vx, 2, si->info_level);
        COUNT_BYTES_TRANS(2);

        CHECK_BYTE_COUNT_TRANS(4);
        proto_tree_add_item(tree, hf_smb_reserved, vq, vx, 4, TRUE);
        COUNT_BYTES_TRANS(4);

        fn = get_unicode_or_ascii_string(vq, &vx, si->unicode, &fn_len, FALSE, FALSE, &xt);
        CHECK_STRING_TRANS(fn);
        proto_tree_add_string(tree, hf_smb_file_name, vq, vx, fn_len,
                              fn);
        COUNT_BYTES_TRANS(fn_len);

        if (check_col(mz->cinfo, COL_INFO))
        {
            col_append_fstr(mz->cinfo, COL_INFO, ", Path: %s",
                            format_text(fn, strlen(fn)));
        }

        break;
    }
    case 0x0c:
    {

        CHECK_BYTE_COUNT_TRANS(2);
        proto_tree_add_item(tree, hf_smb_monitor_handle, vq, vx, 2, TRUE);
        COUNT_BYTES_TRANS(2);

        CHECK_BYTE_COUNT_TRANS(2);
        proto_tree_add_item(tree, hf_smb_change_count, vq, vx, 2, TRUE);
        COUNT_BYTES_TRANS(2);

        break;
    }
    case 0x0d:
        CHECK_BYTE_COUNT_TRANS(4);
        proto_tree_add_item(tree, hf_smb_reserved, vq, vx, 4, TRUE);
        COUNT_BYTES_TRANS(4);

        fn = get_unicode_or_ascii_string(vq, &vx, si->unicode, &fn_len,
                                         FALSE, FALSE, &xt);
        CHECK_STRING_TRANS(fn);
        proto_tree_add_string(tree, hf_smb_dir_name, vq, vx, fn_len,
                              fn);
        COUNT_BYTES_TRANS(fn_len);

        if (check_col(mz->cinfo, COL_INFO))
        {
            col_append_fstr(mz->cinfo, COL_INFO, ", Dir: %s",
                            format_text(fn, strlen(fn)));
        }
        break;
    case 0x0e:
        break;
    case 0x10:
        CHECK_BYTE_COUNT_TRANS(2);
        proto_tree_add_item(tree, hf_smb_max_referral_level, vq, vx, 2, TRUE);
        COUNT_BYTES_TRANS(2);

        fn = get_unicode_or_ascii_string(vq, &vx, si->unicode, &fn_len, FALSE, FALSE, &xt);
        CHECK_STRING_TRANS(fn);
        proto_tree_add_string(tree, hf_smb_file_name, vq, vx, fn_len,
                              fn);
        COUNT_BYTES_TRANS(fn_len);

        if (check_col(mz->cinfo, COL_INFO))
        {
            col_append_fstr(mz->cinfo, COL_INFO, ", File: %s",
                            format_text(fn, strlen(fn)));
        }

        break;
    case 0x11:
        fn = get_unicode_or_ascii_string(vq, &vx, si->unicode, &fn_len, FALSE, FALSE, &xt);
        CHECK_STRING_TRANS(fn);
        proto_tree_add_string(tree, hf_smb_file_name, vq, vx, fn_len,
                              fn);
        COUNT_BYTES_TRANS(fn_len);

        if (check_col(mz->cinfo, COL_INFO))
        {
            col_append_fstr(mz->cinfo, COL_INFO, ", File: %s",
                            format_text(fn, strlen(fn)));
        }

        break;
    }

    if (xt != 0)
    {
        proto_tree_add_item(tree, hf_smb_unknown, vq, vx, xt, TRUE);
        vx += xt;
    }

    return vx;
}