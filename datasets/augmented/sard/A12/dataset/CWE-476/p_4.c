static int
dissect_options(tvbuff_t *tvb, int offset, packet_info *pinfo _U_, proto_tree *tree, int length, psm_data_t *psm_data _U_, config_data_t *config_data)
{
	proto_item *ti_option = NULL;
	proto_tree *ti_option_subtree = NULL;
	guint8 option_type, option_length;

	while (length > 0)
	{
		option_type = tvb_get_guint8(tvb, offset);
		option_length = tvb_get_guint8(tvb, offset + 1);

		ti_option = proto_tree_add_none_format(tree,
											   hf_btl2cap_option, tvb,
											   offset, option_length + 2,
											   "Option: ");
		ti_option_subtree = proto_item_add_subtree(ti_option, ett_btl2cap_option);
		proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_type, tvb, offset, 1, TRUE);
                    
		proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_length, tvb, offset + 1, 1, TRUE);
		offset += 2;

		if (option_length > 0)
		{
			switch (option_type)
			{
			case 0x01:
				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_mtu, tvb, offset, 2, TRUE);
				offset += 2;

				proto_item_append_text(ti_option, "MTU");
				break;

			case 0x02:
				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_flushTO, tvb, offset, 2, TRUE);
				offset += 2;

				proto_item_append_text(ti_option, "Flush Timeout");
				break;

			case 0x03:
				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_flags, tvb, offset, 1, TRUE);
				offset++;

				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_service_type, tvb, offset, 1, TRUE);
				offset++;

				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_tokenrate, tvb, offset, 4, TRUE);
				offset += 4;

				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_tokenbucketsize, tvb, offset, 4, TRUE);
				offset += 4;

				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_peakbandwidth, tvb, offset, 4, TRUE);
				offset += 4;

				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_latency, tvb, offset, 4, TRUE);
				offset += 4;

				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_delayvariation, tvb, offset, 4, TRUE);
				offset += 4;

				proto_item_append_text(ti_option, "QOS");
				break;

			case 0x04:
				if (config_data)
				{
					config_data->mode = tvb_get_guint8(tvb, offset);
					config_data->txwindow = tvb_get_guint8(tvb, offset + 1);
				}
				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_retransmissionmode, tvb, offset, 1, TRUE);
				offset++;

				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_txwindow, tvb, offset, 1, TRUE);
				offset++;

				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_maxtransmit, tvb, offset, 1, TRUE);
				offset++;

				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_retransmittimeout, tvb, offset, 2, TRUE);
				offset += 2;

				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_monitortimeout, tvb, offset, 2, TRUE);
				offset += 2;

				proto_tree_add_item(ti_option_subtree, hf_btl2cap_option_mps, tvb, offset, 2, TRUE);
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
	return offset;
}