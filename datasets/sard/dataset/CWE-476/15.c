static gboolean check_for_duplicate_addresses(packet_info *pinfo, proto_tree *tree,
                                              tvbuff_t *tvb,
                                              const guint8 *mac, guint32 ip,
                                              guint32 *duplicate_ip)
{
    struct address_hash_value *value;
    gboolean return_value = FALSE;
    value = g_hash_table_lookup(address_hash_table, GUINT_TO_POINTER(ip));

    if (value != NULL)
    {
        if (pinfo->fd->num > value->frame_num)
        {
            if ((memcmp(value->mac, mac, 6) == 0))
            {
                value->frame_num = pinfo->fd->num;
                value->time_of_entry = pinfo->fd->abs_ts.secs;
            }
            else
            {

                proto_tree *duplicate_tree;

                proto_item *ti = proto_tree_add_none_format(tree, hf_arp_duplicate_ip_address,
                                                            tvb, 0, 0,
                                                            "Duplicate IP address detected for %s (%s) - also in use by %s (frame %u)",
                                                            arpproaddr_to_str((guint8 *)&ip, 4, ETHERTYPE_IP),
                                                            ether_to_str(mac),
                                                            ether_to_str(value->mac),
                                                            value->frame_num);
                PROTO_ITEM_SET_GENERATED(ti);
                duplicate_tree = proto_item_add_subtree(ti, ett_arp_duplicate_address);

                ti = proto_tree_add_uint(duplicate_tree, hf_arp_duplicate_ip_address_earlier_frame,
                                         tvb, 0, 0, value->frame_num);
                PROTO_ITEM_SET_GENERATED(ti);
                expert_add_info_format(pinfo, ti,
                                       PI_SEQUENCE, PI_WARN,
                                       "Duplicate IP address configured (%s)",
                                       arpproaddr_to_str((guint8 *)&ip, 4, ETHERTYPE_IP));

                ti = proto_tree_add_uint(duplicate_tree,
                                         hf_arp_duplicate_ip_address_seconds_since_earlier_frame,
                                         tvb, 0, 0,
                                         (guint32)(pinfo->fd->abs_ts.secs - value->time_of_entry));
                PROTO_ITEM_SET_GENERATED(ti);

                *duplicate_ip = ip;
                return_value = TRUE;
            }
        }
    }
    else
    {

        memcpy(value->mac, mac, 6);
        value->frame_num = pinfo->fd->num;
        value->time_of_entry = pinfo->fd->abs_ts.secs;

        g_hash_table_insert(address_hash_table, GUINT_TO_POINTER(ip), value);
    }

    return return_value;
}