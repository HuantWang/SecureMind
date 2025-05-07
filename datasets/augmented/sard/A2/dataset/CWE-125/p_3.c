#define OUT_RXString(field)                                         \
	{                                                               \
		guint32 i_orxs, len_orxs;                                   \
		i_orxs = tvb_get_ntohl(tvb, offset);                        \
		len_orxs = ((i_orxs + 4 - 1) / 4) * 4 + 4;                  \
		proto_tree_add_item(tree, field, tvb, offset - 4, len_orxs, \
							FALSE);                                 \
		offset += len_orxs;                                         \
	}