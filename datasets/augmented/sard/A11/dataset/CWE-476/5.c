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
dissect_transaction2_request_parameters(tvbuff_t *tvb, packet_info *pinfo,
                                        proto_tree *parent_tree, int offset, int subcmd, guint16 bc)
{
    proto_item *item = NULL;
    proto_tree *tree = NULL;
    smb_info_t *si;
    smb_transact2_info_t *t2i;
    int fn_len;
    const char *fn;

    si = (smb_info_t *)pinfo->private_data;
    DISSECTOR_ASSERT(si);

    if (si->sip != NULL && si->sip->extra_info_type == SMB_EI_T2I)
        t2i = si->sip->extra_info;
    else
        t2i = NULL;

    if (parent_tree)
    {
        tvb_ensure_bytes_exist(tvb, offset, bc);
        item = proto_tree_add_text(parent_tree, tvb, offset, bc,
                                   "%s Parameters",
                                   val_to_str(subcmd, trans2_cmd_vals,
                                              "Unknown (0x%02x)"));
        tree = proto_item_add_subtree(item, ett_smb_transaction_params);
    }

    switch (subcmd)
    {
    case 0x00:
        CHECK_BYTE_COUNT_TRANS(2);
        offset = dissect_open_flags(tvb, tree, offset, 0x000f);
        bc -= 2;

        CHECK_BYTE_COUNT_TRANS(2);
        offset = dissect_access(tvb, tree, offset, "Desired");
        bc -= 2;

        CHECK_BYTE_COUNT_TRANS(2);
        offset = dissect_search_attributes(tvb, tree, offset);
        bc -= 2;

        CHECK_BYTE_COUNT_TRANS(2);
        offset = dissect_file_attributes(tvb, tree, offset, 2);
        bc -= 2;

        CHECK_BYTE_COUNT_TRANS(4);
        offset = dissect_smb_datetime(tvb, tree, offset,
                                      hf_smb_create_time,
                                      hf_smb_create_dos_date, hf_smb_create_dos_time,
                                      TRUE);
        bc -= 4;

        CHECK_BYTE_COUNT_TRANS(2);
        offset = dissect_open_function(tvb, tree, offset);
        bc -= 2;

        CHECK_BYTE_COUNT_TRANS(4);
        proto_tree_add_item(tree, hf_smb_alloc_size, tvb, offset, 4, TRUE);
        COUNT_BYTES_TRANS(4);

        CHECK_BYTE_COUNT_TRANS(10);
        proto_tree_add_item(tree, hf_smb_reserved, tvb, offset, 10, TRUE);
        COUNT_BYTES_TRANS(10);

        fn = get_unicode_or_ascii_string(tvb, &offset, si->unicode, &fn_len, FALSE, FALSE, &bc);
        CHECK_STRING_TRANS(fn);
        proto_tree_add_string(tree, hf_smb_file_name, tvb, offset, fn_len,
                              fn);
        COUNT_BYTES_TRANS(fn_len);

        if (check_col(pinfo->cinfo, COL_INFO))
        {
            col_append_fstr(pinfo->cinfo, COL_INFO, ", Path: %s",
                            format_text(fn, strlen(fn)));
        }
        break;
    case 0x01:
        CHECK_BYTE_COUNT_TRANS(2);
        offset = dissect_search_attributes(tvb, tree, offset);
        bc -= 2;

        CHECK_BYTE_COUNT_TRANS(2);
        proto_tree_add_item(tree, hf_smb_search_count, tvb, offset, 2, TRUE);
        COUNT_BYTES_TRANS(2);

        CHECK_BYTE_COUNT_TRANS(2);
        offset = dissect_ff2_flags(tvb, pinfo, tree, offset);
        bc -= 2;

        CHECK_BYTE_COUNT_TRANS(2);
        si->info_level = tvb_get_letohs(tvb, offset);
        if (t2i != NULL && !pinfo->fd->flags.visited)
            t2i->info_level = si->info_level;
        proto_tree_add_uint(tree, hf_smb_ff2_information_level, tvb, offset, 2, si->info_level);
        COUNT_BYTES_TRANS(2);

        CHECK_BYTE_COUNT_TRANS(4);
        proto_tree_add_item(tree, hf_smb_storage_type, tvb, offset, 4, TRUE);
        COUNT_BYTES_TRANS(4);

        fn = get_unicode_or_ascii_string(tvb, &offset, si->unicode, &fn_len, FALSE, FALSE, &bc);
        CHECK_STRING_TRANS(fn);
        if (!t2i->name)
        {
            t2i->name = se_strdup(fn);
        }
        proto_tree_add_string(tree, hf_smb_search_pattern, tvb, offset, fn_len,
                              fn);
        COUNT_BYTES_TRANS(fn_len);

        if (check_col(pinfo->cinfo, COL_INFO))
        {
            col_append_fstr(pinfo->cinfo, COL_INFO, ", Pattern: %s",
                            format_text(fn, strlen(fn)));
        }

        break;
    case 0x02:
        CHECK_BYTE_COUNT_TRANS(2);
        proto_tree_add_item(tree, hf_smb_search_id, tvb, offset, 2, TRUE);
        COUNT_BYTES_TRANS(2);

        CHECK_BYTE_COUNT_TRANS(2);
        proto_tree_add_item(tree, hf_smb_search_count, tvb, offset, 2, TRUE);
        COUNT_BYTES_TRANS(2);

        CHECK_BYTE_COUNT_TRANS(2);
        si->info_level = tvb_get_letohs(tvb, offset);
        if (t2i != NULL && !pinfo->fd->flags.visited)
            t2i->info_level = si->info_level;
        proto_tree_add_uint(tree, hf_smb_ff2_information_level, tvb, offset, 2, si->info_level);
        COUNT_BYTES_TRANS(2);

        CHECK_BYTE_COUNT_TRANS(4);
        proto_tree_add_item(tree, hf_smb_resume, tvb, offset, 4, TRUE);
        COUNT_BYTES_TRANS(4);

        CHECK_BYTE_COUNT_TRANS(2);
        offset = dissect_ff2_flags(tvb, pinfo, tree, offset);
        bc -= 2;

        fn = get_unicode_or_ascii_string(tvb, &offset, si->unicode, &fn_len, FALSE, FALSE, &bc);
        CHECK_STRING_TRANS(fn);
        proto_tree_add_string(tree, hf_smb_file_name, tvb, offset, fn_len,
                              fn);
        COUNT_BYTES_TRANS(fn_len);

        if (check_col(pinfo->cinfo, COL_INFO))
        {
            col_append_fstr(pinfo->cinfo, COL_INFO, ", Continue: %s",
                            format_text(fn, strlen(fn)));
        }

        break;
    case 0x03:
        CHECK_BYTE_COUNT_TRANS(2);
        si->info_level = tvb_get_letohs(tvb, offset);
        if (t2i != NULL && !pinfo->fd->flags.visited)
            t2i->info_level = si->info_level;
        proto_tree_add_uint(tree, hf_smb_qfsi_information_level, tvb, offset, 2, si->info_level);
        COUNT_BYTES_TRANS(2);

        if (check_col(pinfo->cinfo, COL_INFO))
            col_append_fstr(pinfo->cinfo, COL_INFO, ", %s",
                            val_to_str(si->info_level, qfsi_vals,
                                       "Unknown (0x%02x)"));

        break;
    case 0x05:
        CHECK_BYTE_COUNT_TRANS(2);
        si->info_level = tvb_get_letohs(tvb, offset);
        if (t2i != NULL && !pinfo->fd->flags.visited)
            t2i->info_level = si->info_level;
        proto_tree_add_uint(tree, hf_smb_qpi_loi, tvb, offset, 2, si->info_level);
        COUNT_BYTES_TRANS(2);

        if (check_col(pinfo->cinfo, COL_INFO))
        {
            col_append_fstr(
                pinfo->cinfo, COL_INFO, ", %s",
                val_to_str(si->info_level, qpi_loi_vals,
                           "Unknown (%u)"));
        }

        CHECK_BYTE_COUNT_TRANS(4);
        proto_tree_add_item(tree, hf_smb_reserved, tvb, offset, 4, TRUE);
        COUNT_BYTES_TRANS(4);

        fn = get_unicode_or_ascii_string(tvb, &offset, si->unicode, &fn_len, FALSE, FALSE, &bc);
        CHECK_STRING_TRANS(fn);
        proto_tree_add_string(tree, hf_smb_file_name, tvb, offset, fn_len,
                              fn);
        COUNT_BYTES_TRANS(fn_len);
        if (!t2i->name)
        {
            t2i->name = se_strdup(fn);
        }

        if (check_col(pinfo->cinfo, COL_INFO))
        {
            col_append_fstr(pinfo->cinfo, COL_INFO, ", Path: %s",
                            format_text(fn, strlen(fn)));
        }

        break;
    case 0x06:
        CHECK_BYTE_COUNT_TRANS(2);
        si->info_level = tvb_get_letohs(tvb, offset);
        if (t2i != NULL && !pinfo->fd->flags.visited)
            t2i->info_level = si->info_level;
        proto_tree_add_uint(tree, hf_smb_spi_loi, tvb, offset, 2, si->info_level);
        COUNT_BYTES_TRANS(2);

        CHECK_BYTE_COUNT_TRANS(4);
        proto_tree_add_item(tree, hf_smb_reserved, tvb, offset, 4, TRUE);
        COUNT_BYTES_TRANS(4);

        fn = get_unicode_or_ascii_string(tvb, &offset, si->unicode, &fn_len, FALSE, FALSE, &bc);
        CHECK_STRING_TRANS(fn);
        proto_tree_add_string(tree, hf_smb_file_name, tvb, offset, fn_len,
                              fn);
        COUNT_BYTES_TRANS(fn_len);

        if (check_col(pinfo->cinfo, COL_INFO))
        {
            col_append_fstr(pinfo->cinfo, COL_INFO, ", Path: %s",
                            format_text(fn, strlen(fn)));
        }

        break;
    case 0x07:
    {
        guint16 fid;

        CHECK_BYTE_COUNT_TRANS(2);
        fid = tvb_get_letohs(tvb, offset);
        dissect_smb_fid(tvb, pinfo, tree, offset, 2, fid, FALSE, FALSE, FALSE);
        COUNT_BYTES_TRANS(2);

        CHECK_BYTE_COUNT_TRANS(2);
        si->info_level = tvb_get_letohs(tvb, offset);
        if (t2i != NULL && !pinfo->fd->flags.visited)
            t2i->info_level = si->info_level;
        proto_tree_add_uint(tree, hf_smb_qpi_loi, tvb, offset, 2, si->info_level);
        COUNT_BYTES_TRANS(2);

        if (check_col(pinfo->cinfo, COL_INFO))
        {
            col_append_fstr(
                pinfo->cinfo, COL_INFO, ", %s",
                val_to_str(si->info_level, qpi_loi_vals,
                           "Unknown (%u)"));
        }

        break;
    }
    case 0x08:
    {
        guint16 fid;

        CHECK_BYTE_COUNT_TRANS(2);
        fid = tvb_get_letohs(tvb, offset);
        dissect_smb_fid(tvb, pinfo, tree, offset, 2, fid, FALSE, FALSE, FALSE);
        COUNT_BYTES_TRANS(2);

        CHECK_BYTE_COUNT_TRANS(2);
        si->info_level = tvb_get_letohs(tvb, offset);
        if (t2i != NULL && !pinfo->fd->flags.visited)
            t2i->info_level = si->info_level;
        proto_tree_add_uint(tree, hf_smb_spi_loi, tvb, offset, 2, si->info_level);
        COUNT_BYTES_TRANS(2);

#if 0
		CHECK_BYTE_COUNT_TRANS(2);
		offset = dissect_sfi_ioflag(tvb, tree, offset);
		bc -= 2;
#else

        CHECK_BYTE_COUNT_TRANS(2);
        proto_tree_add_item(tree, hf_smb_reserved, tvb, offset, 2, TRUE);
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
        offset = dissect_search_attributes(tvb, tree, offset);
        bc -= 2;

        CHECK_BYTE_COUNT_TRANS(2);
        proto_tree_add_item(tree, hf_smb_change_count, tvb, offset, 2, TRUE);
        COUNT_BYTES_TRANS(2);

        CHECK_BYTE_COUNT_TRANS(2);
        si->info_level = tvb_get_letohs(tvb, offset);
        if (t2i != NULL && !pinfo->fd->flags.visited)
            t2i->info_level = si->info_level;
        proto_tree_add_uint(tree, hf_smb_fn_information_level, tvb, offset, 2, si->info_level);
        COUNT_BYTES_TRANS(2);

        CHECK_BYTE_COUNT_TRANS(4);
        proto_tree_add_item(tree, hf_smb_reserved, tvb, offset, 4, TRUE);
        COUNT_BYTES_TRANS(4);

        fn = get_unicode_or_ascii_string(tvb, &offset, si->unicode, &fn_len, FALSE, FALSE, &bc);
        CHECK_STRING_TRANS(fn);
        proto_tree_add_string(tree, hf_smb_file_name, tvb, offset, fn_len,
                              fn);
        COUNT_BYTES_TRANS(fn_len);

        if (check_col(pinfo->cinfo, COL_INFO))
        {
            col_append_fstr(pinfo->cinfo, COL_INFO, ", Path: %s",
                            format_text(fn, strlen(fn)));
        }

        break;
    }
    case 0x0c:
    {

        CHECK_BYTE_COUNT_TRANS(2);
        proto_tree_add_item(tree, hf_smb_monitor_handle, tvb, offset, 2, TRUE);
        COUNT_BYTES_TRANS(2);

        CHECK_BYTE_COUNT_TRANS(2);
        proto_tree_add_item(tree, hf_smb_change_count, tvb, offset, 2, TRUE);
        COUNT_BYTES_TRANS(2);

        break;
    }
    case 0x0d:
        CHECK_BYTE_COUNT_TRANS(4);
        proto_tree_add_item(tree, hf_smb_reserved, tvb, offset, 4, TRUE);
        COUNT_BYTES_TRANS(4);

        fn = get_unicode_or_ascii_string(tvb, &offset, si->unicode, &fn_len,
                                         FALSE, FALSE, &bc);
        CHECK_STRING_TRANS(fn);
        proto_tree_add_string(tree, hf_smb_dir_name, tvb, offset, fn_len,
                              fn);
        COUNT_BYTES_TRANS(fn_len);

        if (check_col(pinfo->cinfo, COL_INFO))
        {
            col_append_fstr(pinfo->cinfo, COL_INFO, ", Dir: %s",
                            format_text(fn, strlen(fn)));
        }
        break;
    case 0x0e:
        break;
    case 0x10:
        CHECK_BYTE_COUNT_TRANS(2);
        proto_tree_add_item(tree, hf_smb_max_referral_level, tvb, offset, 2, TRUE);
        COUNT_BYTES_TRANS(2);

        fn = get_unicode_or_ascii_string(tvb, &offset, si->unicode, &fn_len, FALSE, FALSE, &bc);
        CHECK_STRING_TRANS(fn);
        proto_tree_add_string(tree, hf_smb_file_name, tvb, offset, fn_len,
                              fn);
        COUNT_BYTES_TRANS(fn_len);

        if (check_col(pinfo->cinfo, COL_INFO))
        {
            col_append_fstr(pinfo->cinfo, COL_INFO, ", File: %s",
                            format_text(fn, strlen(fn)));
        }

        break;
    case 0x11:
        fn = get_unicode_or_ascii_string(tvb, &offset, si->unicode, &fn_len, FALSE, FALSE, &bc);
        CHECK_STRING_TRANS(fn);
        proto_tree_add_string(tree, hf_smb_file_name, tvb, offset, fn_len,
                              fn);
        COUNT_BYTES_TRANS(fn_len);

        if (check_col(pinfo->cinfo, COL_INFO))
        {
            col_append_fstr(pinfo->cinfo, COL_INFO, ", File: %s",
                            format_text(fn, strlen(fn)));
        }

        break;
    }

    if (bc != 0)
    {
        proto_tree_add_item(tree, hf_smb_unknown, tvb, offset, bc, TRUE);
        offset += bc;
    }

    return offset;
}