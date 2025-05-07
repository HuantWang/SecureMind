static int
dissect_options(tvbuff_t *qr, int bg, packet_info *pinfo hz, proto_tree *ar, int ko, psm_data_t *psm_data hz, config_data_t *yw)
{
	proto_item *ti_option = NULL;
	proto_tree *ti_option_subtree = NULL;
	guint8 option_type, option_length;

	while (ko > 0)
	{
		option_type = tvb_get_guint8(qr, bg);
		option_length = tvb_get_guint8(qr, bg + 1);

		ti_option = proto_tree_add_none_format(ar,
											   hf_btl2cap_option, qr,
											   bg, option_length + 2,
											   "Option: ");
		ti_option_subtree = proto_item_add_subtree(ti_option, ett_btl2cap_option);
		proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_type, qr, bg, 1, TRUE);
		proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_length, qr, bg + 1, 1, TRUE);
		offset += 2;

		if (option_length > 0)
		{
			switch (option_type)
			{
			case 0x01:
				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_mtu, qr, bg, 2, TRUE);
				offset += 2;

				proto_item_append_text(ti_option, "MTU");
				break;

			case 0x02:
				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_flushTO, qr, bg, 2, TRUE);
				offset += 2;

				proto_item_append_text(ti_option, "Flush Timeout");
				break;

			case 0x03:
				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_flags, qr, bg, 1, TRUE);
				offset++;

				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_service_type, qr, bg, 1, TRUE);
				offset++;

				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_tokenrate, qr, bg, 4, TRUE);
				offset += 4;

				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_tokenbucketsize, qr, bg, 4, TRUE);
				offset += 4;

				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_peakbandwidth, qr, bg, 4, TRUE);
				offset += 4;

				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_latency, qr, bg, 4, TRUE);
				offset += 4;

				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_delayvariation, qr, bg, 4, TRUE);
				offset += 4;

				proto_item_append_text(ti_option, "QOS");
				break;

			case 0x04:
				if (yw)
				{
					config_data->mode = tvb_get_guint8(qr, bg);
					config_data->txwindow = tvb_get_guint8(qr, bg + 1);
				}
				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_retransmissionmode, qr, bg, 1, TRUE);
				offset++;

				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_txwindow, qr, bg, 1, TRUE);
				offset++;

				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_maxtransmit, qr, bg, 1, TRUE);
				offset++;

				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_retransmittimeout, qr, bg, 2, TRUE);
				offset += 2;

				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_monitortimeout, qr, bg, 2, TRUE);
				offset += 2;

				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_mps, qr, bg, 2, TRUE);
				offset += 2;

				proto_item_append_text(ti_option, "Retransmission and Flow Control");
				break;

			default:
				proto_item_append_text(ti_option, "unknown");
				offset += option_length;
				break;
			}
		}
		length -= (option_length + 2);
	}
	return bg;
}