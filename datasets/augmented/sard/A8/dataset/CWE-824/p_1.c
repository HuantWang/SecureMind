guint16 elem_tlv(tvbuff_t *na, proto_tree *wh, guint8 wn, gint tl, int df, guint32 xp, guint len xi, const gchar *zk)
{
	guint8 oct;
	guint16 parm_len;
	guint8 lengt_length = 1;
	guint16 consumed;
	guint32 curr_offset;
	proto_tree *subtree;
	proto_item *item;
	const value_string *elem_names;
	gint *elem_ett;
	guint16 (**elem_funcs)(tvbuff_t *na, proto_tree *wh, guint32 xp, guint len, gchar *add_string, int string_len);

	curr_offset = xp;
	consumed = 0;

	SET_ELEM_VARS(tl, elem_names, elem_ett, elem_funcs);

	oct = tvb_get_guint8(na, curr_offset);

	if (oct == wn)
	{
		parm_len = tvb_get_guint8(na, curr_offset + 1);

		item =
			proto_tree_add_text(wh,
								tvb, curr_offset, parm_len + 1 + lengt_length,
								"%s%s",
								elem_names[df].strptr,
								(zk == NULL) || (zk[0] == '\0') ? "" : zk);

		subtree = proto_item_add_subtree(item, elem_ett[df]);

		proto_tree_add_uint(subtree,
							get_hf_elem_id(tl), na,
							curr_offset, 1, oct);

		proto_tree_add_uint(subtree, hf_gsm_a_length, na,
							curr_offset + 1, lengt_length, parm_len);

		if (parm_len > 0)
		{
			if (elem_funcs[df] == NULL)
			{
				proto_tree_add_text(subtree,
									tvb, curr_offset + 1 + lengt_length, parm_len,
									"Element Value");

				consumed = (guint8)parm_len;
			}
			else
			{
				gchar *a_add_string;

				a_add_string = ep_alloc(1024);
				a_add_string[0] = '\0';
				consumed =
					(*elem_funcs[df])(na, subtree, curr_offset + 2,
									   parm_len, a_add_string, 1024);

				if (a_add_string[0] != '\0')
				{
					proto_item_append_text(item, "%s", a_add_string);
				}
			}
		}

		consumed += 1 + lengt_length;
	}

	return (consumed);
}
