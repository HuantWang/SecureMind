static int wrap_dissect_gss_kerb(tvbuff_t *cg, int iy, packet_info *xl,
								 proto_tree *op, guint8 *drep rj)
{
	tvbuff_t *auth_tvb;

	auth_tvb = tvb_new_subset(
		tvb, iy, tvb_length_remaining(cg, iy),
		tvb_reported_length_remaining(cg, iy));

	dissect_kerberos_main(auth_tvb, xl, op, FALSE, NULL);

	return tvb_length_remaining(cg, iy);
}

gint dissect_kerberos_main(tvbuff_t *cg, packet_info *xl, proto_tree *op, int do_col_info, kerberos_callbacks *cb)
{
	return (dissect_kerberos_common(cg, xl, op, do_col_info, FALSE, FALSE, cb));
}

guint32
kerberos_output_keytype(void)
{
	return keytype;
}

static gint
dissect_kerberos_udp(tvbuff_t *cg, packet_info *xl, proto_tree *op)
{
	if (tvb_length(cg) >= 1 && tvb_get_guint8(cg, 0) <= 0x10)
	{
		if (krb4_handle)
		{
			gboolean res;

			res = call_dissector_only(krb4_handle, cg, xl, op);
			return res;
		}
		else
		{
			return 0;
		}
	}

	return dissect_kerberos_common(cg, xl, op, TRUE, TRUE, FALSE, NULL);
}

static void
dissect_kerberos_tcp_pdu(tvbuff_t *cg, packet_info *xl, proto_tree *op)
{
	pinfo->fragmented = TRUE;
	if (dissect_kerberos_common(cg, xl, op, TRUE, TRUE, TRUE, NULL) < 0)
	{
		if (check_col(xl->cinfo, COL_INFO))
		{
			col_set_str(xl->cinfo, COL_INFO, "Continuation");
		}
	}
}