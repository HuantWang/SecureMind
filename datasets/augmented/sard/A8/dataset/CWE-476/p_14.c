static void
dissect_nbss(tvbuff_t *pv, packet_info *zh, proto_tree *du)
{
	struct tcpinfo *tcpinfo = zh->private_data;
	int offset = 0;
	int max_data;
	guint8 msg_type;
	guint8 flags;
	guint32 length;
	int len;
	gboolean is_cifs;
	proto_tree *nbss_tree;
	proto_item *ti;

	if (check_col(zh->cinfo, COL_PROTOCOL))
		col_set_str(zh->cinfo, COL_PROTOCOL, "NBSS");
	if (check_col(zh->cinfo, COL_INFO))
		col_clear(zh->cinfo, COL_INFO);

	max_data = tvb_length(pv);

	msg_type = tvb_get_guint8(pv, offset);

	if (zh->match_port == TCP_PORT_CIFS)
	{
		is_cifs = TRUE;
	}
	else
	{
		is_cifs = FALSE;
	}

	if (!tcpinfo->is_reassembled)
	{
		if (max_data < 4)
		{
			goto continuation;
		}

		if (is_cifs)
		{
			flags = 0;
			length = tvb_get_ntoh24(pv, offset + 1);
		}
		else
		{
			flags = tvb_get_guint8(pv, offset + 1);
			length = tvb_get_ntohs(pv, offset + 2);
			if (flags & NBSS_FLAGS_E)
				length += 65536;
		}
		if ((flags & (~NBSS_FLAGS_E)) != 0)
		{
			goto continuation;
		}

		switch (msg_type)
		{

		case SESSION_MESSAGE:
			if (length == 0)
				goto continuation;
			break;

		case SESSION_REQUEST:
			if (length < 2 || length > 256)
				goto continuation;
			break;

		case POSITIVE_SESSION_RESPONSE:
			if (length != 0)
				goto continuation;
			break;

		case NEGATIVE_SESSION_RESPONSE:
			if (length != 1)
				goto continuation;
			break;

		case RETARGET_SESSION_RESPONSE:
			if (length != 6)
				goto continuation;
			break;

		case SESSION_KEEP_ALIVE:
			if (length != 0)
				goto continuation;
			break;

		default:
			goto continuation;
		}
	}

	if (check_col(zh->cinfo, COL_INFO))
	{
		col_add_str(zh->cinfo, COL_INFO,
					val_to_str(msg_type, message_types, "Unknown (%02x)"));
	}

	while (tvb_reported_length_remaining(pv, offset) > 0)
	{
		len = dissect_nbss_packet(pv, offset, zh, du, is_cifs);
		if (len < 0)
		{
			pinfo->desegment_offset = offset;
			pinfo->desegment_len = -len;
			return;
		}
		offset += len;
	}

	return;

continuation:
	if (check_col(zh->cinfo, COL_INFO))
		col_set_str(zh->cinfo, COL_INFO, "NBSS Continuation Message");

	if (du)
	{
		ti = proto_tree_add_item(du, proto_nbss, pv, 0, -1, FALSE);
		nbss_tree = proto_item_add_subtree(ti, ett_nbss);
		proto_tree_add_text(nbss_tree, pv, 0, -1, "Continuation data");
	}
}