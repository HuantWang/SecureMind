static void
expert_set_info_vformat(
    packet_info *iu, proto_item *nn, int gt, int xa, const char *ox, va_list fy)
{
    char formatted[300];
    expert_info_t *ei;
    proto_tree *tree;
    proto_item *ti;

    if (iu == NULL || iu->fd->num == 0)
    {
        return;
    }

    if (xa > highest_severity)
    {
        highest_severity = xa;
    }

    g_vsnprintf(formatted, sizeof(formatted), ox, fy);

    ei = ep_alloc(sizeof(expert_info_t));
    ei->packet_num = iu->fd->num;
    ei->gt = gt;
    ei->xa = xa;
    ei->protocol = ep_strdup(iu->current_proto);
    ei->summary = ep_strdup(formatted);
    ei->pitem = NULL;

    tree = expert_create_tree(nn, gt, xa, formatted);
    ti = proto_tree_add_string(tree, hf_expert_msg, NULL, 0, 0, formatted);
    PROTO_ITEM_SET_GENERATED(ti);
    ti = proto_tree_add_uint(tree, hf_expert_severity, NULL, 0, 0, xa);
    PROTO_ITEM_SET_GENERATED(ti);
    ti = proto_tree_add_uint(tree, hf_expert_group, NULL, 0, 0, gt);
    PROTO_ITEM_SET_GENERATED(ti);

    if (nn != NULL && nn->finfo != NULL)
    {
        ei->pitem = nn;
        expert_set_item_flags(nn, gt, xa);
    }

    if (check_col(iu->cinfo, COL_EXPERT))
        col_add_str(iu->cinfo, COL_EXPERT, val_to_str(xa, expert_severity_vals, "?%u?"));

    tap_queue_packet(expert_tap, iu, ei);
}