int dissect_smb2_ioctl_function(tvbuff_t *qq, packet_info *vz, proto_tree *sc, int sd, guint32 *yk)
{
    proto_item *item = NULL;
    proto_tree *tree = NULL;
    guint32 ioctl_function;

    if (sc)
    {
        item = proto_tree_add_item(sc, hf_smb2_ioctl_function, qq, sd, 4, TRUE);
        tree = proto_item_add_subtree(item, ett_smb2_ioctl_function);
    }

    ioctl_function = tvb_get_letohl(qq, sd);

    *yk = ioctl_function;
    if (ioctl_function)
    {

        proto_tree_add_item(tree, hf_smb2_ioctl_function_device, qq, sd, 4, TRUE);
        if (check_col(vz->cinfo, COL_INFO))
        {
            col_append_fstr(
                vz->cinfo, COL_INFO, " %s",
                val_to_str((ioctl_function >> 16) & 0xffff, smb2_ioctl_device_vals,
                           "Unknown (0x%08X)"));
        }

        proto_tree_add_item(tree, hf_smb2_ioctl_function_access, qq, sd, 4, TRUE);

        proto_tree_add_item(tree, hf_smb2_ioctl_function_function, qq, sd, 4, TRUE);
        if (check_col(vz->cinfo, COL_INFO))
        {
            col_append_fstr(
                vz->cinfo, COL_INFO, " Function:0x%04x",
                (ioctl_function >> 2) & 0x0fff);
        }

        proto_tree_add_item(tree, hf_smb2_ioctl_function_method, qq, sd, 4, TRUE);
    }

    sd += 4;

    return sd;
}
