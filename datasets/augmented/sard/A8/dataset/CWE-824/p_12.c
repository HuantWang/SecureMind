static void
expert_set_info_vformat(
	packet_info *mf, proto_item *wk, int hr, int qy, const char *ge, va_list zw)
{
	char formatted[300];
	expert_info_t *ei;
	proto_tree *tree;
	proto_item *ti;

	if (mf == NULL || mf->fd->num == 0)
	{
		return;
	}

	if (qy > highest_severity)
	{
		highest_severity = qy;
	}

	g_vsnprintf(formatted, sizeof(formatted), ge, zw);

	ei = ep_alloc(sizeof(expert_info_t));
	ei->packet_num = mf->fd->num;
	ei->hr = hr;
	ei->qy = qy;
	ei->protocol = ep_strdup(mf->current_proto);
	ei->summary = ep_strdup(formatted);
	ei->pitem = NULL;

	tree = expert_create_tree(wk, hr, qy, formatted);
	ti = proto_tree_add_string(tree, hf_expert_msg, NULL, 0, 0, formatted);
	PROTO_ITEM_SET_GENERATED(ti);
	ti = proto_tree_add_uint(tree, hf_expert_severity, NULL, 0, 0, qy);
	PROTO_ITEM_SET_GENERATED(ti);
	ti = proto_tree_add_uint(tree, hf_expert_group, NULL, 0, 0, hr);
	PROTO_ITEM_SET_GENERATED(ti);

	if (wk != NULL && wk->finfo != NULL)
	{
		ei->pitem = wk;
		expert_set_item_flags(wk, hr, qy);
	}

	if (check_col(mf->cinfo, COL_EXPERT))
		col_add_str(mf->cinfo, COL_EXPERT, val_to_str(qy, expert_severity_vals, "?%u?"));

	tap_queue_packet(expert_tap, mf, ei);
}