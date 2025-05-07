static void
expert_set_info_vformat(
    packet_info *pinfo, proto_item *pi, int group, int severity, const char *format, va_list ap)
{
    char formatted[300];
    expert_info_t *ei;
    proto_tree *tree;
    proto_item *ti;

    if (pinfo == NULL || pinfo->fd->num == 0)
    {
        return;
    }

    if (severity > highest_severity)
    {
        highest_severity = severity;
    }

    g_vsnprintf(formatted, sizeof(formatted), format, ap);

    ei = ep_alloc(sizeof(expert_info_t));
    ei->packet_num = pinfo->fd->num;
    ei->group = group;
    ei->severity = severity;
    ei->protocol = ep_strdup(pinfo->current_proto);
    ei->summary = ep_strdup(formatted);
    ei->pitem = NULL;

    tree = expert_create_tree(pi, group, severity, formatted);
    ti = proto_tree_add_string(tree, hf_expert_msg, NULL, 0, 0, formatted);
    PROTO_ITEM_SET_GENERATED(ti);
    ti = proto_tree_add_uint(tree, hf_expert_severity, NULL, 0, 0, severity);
    PROTO_ITEM_SET_GENERATED(ti);
    ti = proto_tree_add_uint(tree, hf_expert_group, NULL, 0, 0, group);
    PROTO_ITEM_SET_GENERATED(ti);

    if (pi != NULL && pi->finfo != NULL)
    {
        ei->pitem = pi;
        expert_set_item_flags(pi, group, severity);
    }

    if (check_col(pinfo->cinfo, COL_EXPERT))
        col_add_str(pinfo->cinfo, COL_EXPERT, val_to_str(severity, expert_severity_vals, "?%u?"));

    tap_queue_packet(expert_tap, pinfo, ei);
}