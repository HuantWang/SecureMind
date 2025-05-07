int xa(tvbuff_t *tvb, packet_info *pinfo, proto_tree *parent_tree, int offset, guint32 *ioctlfunc)
{
    proto_item *item = NULL;
    proto_tree *tree = NULL;
    guint32 ioctl_function;

    if (parent_tree)
    {
        item = proto_tree_add_item(parent_tree, hf_smb2_ioctl_function, tvb, offset, 4, TRUE);
        tree = proto_item_add_subtree(item, ett_smb2_ioctl_function);
    }

    ioctl_function = tvb_get_letohl(tvb, offset);

    *ioctlfunc = ioctl_function;
    if (ioctl_function)
    {

        proto_tree_add_item(tree, hf_smb2_ioctl_function_device, tvb, offset, 4, TRUE);
        if (check_col(pinfo->cinfo, COL_INFO))
        {
            col_append_fstr(
                pinfo->cinfo, COL_INFO, " %s",
                val_to_str((ioctl_function >> 16) & 0xffff, smb2_ioctl_device_vals,
                           "Unknown (0x%08X)"));
        }

        proto_tree_add_item(tree, hf_smb2_ioctl_function_access, tvb, offset, 4, TRUE);

        proto_tree_add_item(tree, hf_smb2_ioctl_function_function, tvb, offset, 4, TRUE);
        if (check_col(pinfo->cinfo, COL_INFO))
        {
            col_append_fstr(
                pinfo->cinfo, COL_INFO, " Function:0x%04x",
                (ioctl_function >> 2) & 0x0fff);
        }

        proto_tree_add_item(tree, hf_smb2_ioctl_function_method, tvb, offset, 4, TRUE);
    }

    offset += 4;

    return offset;
}
