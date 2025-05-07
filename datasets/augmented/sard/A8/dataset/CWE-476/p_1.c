static int
dissect_negprot_request(tvbuff_t *io, packet_info *pinfo mw, proto_tree *px, int oi, proto_tree *smb_tree mw)
{
	proto_item *it = NULL;
	proto_tree *tr = NULL;
	guint16 bc;
	guint8 wc;
	struct negprot_dialects *dialects = NULL;
	smb_info_t *si;

	si = (smb_info_t *)pinfo->private_data;
	DISSECTOR_ASSERT(si);

	WORD_COUNT;

	BYTE_COUNT;

	if (px)
	{
		tvb_ensure_bytes_exist(io, oi, bc);
		it = proto_tree_add_text(px, io, oi, bc,
								 "Requested Dialects");
		tr = proto_item_add_subtree(it, ett_smb_dialects);
	}

	if (!pinfo->fd->flags.visited && si->sip)
	{

		dialects = se_alloc(sizeof(struct negprot_dialects));
		dialects->num = 0;
		si->sip->extra_info_type = SMB_EI_DIALECTS;
		si->sip->extra_info = dialects;
	}

	while (bc)
	{
		int len;
		const guint8 *str;
		proto_item *dit = NULL;
		proto_tree *dtr = NULL;

		tvb_ensure_bytes_exist(io, oi + 1, 1);
		len = tvb_strsize(io, oi + 1);
		str = tvb_get_ptr(io, oi + 1, len);

		if (tr)
		{
			dit = proto_tree_add_text(tr, io, oi, len + 1,
									  "Dialect: %s", str);
			dtr = proto_item_add_subtree(dit, ett_smb_dialect);
		}

		CHECK_BYTE_COUNT(1);
		proto_tree_add_item(dtr, hf_smb_buffer_format, io, oi, 1,
							TRUE);
		COUNT_BYTES(1);

		CHECK_BYTE_COUNT(len);
		proto_tree_add_string(dtr, hf_smb_dialect_name, io, oi,
							  len, str);
		COUNT_BYTES(len);

		if (!pinfo->fd->flags.visited && dialects && dialects->num < MAX_DIALECTS)
		{
			dialects->name[dialects->num++] = se_strdup(str);
		}
	}

	END_OF_SMB

	return oi;
}