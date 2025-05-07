static gboolean check_for_duplicate_addresses(packet_info *vf, proto_tree *he,
                                              tvbuff_t *ki,
                                              const guint8 *od, guint32 lp,
                                              guint32 *rk)
{
    struct address_hash_value *value;
    gboolean return_value = FALSE;
    value = g_hash_table_lookup(address_hash_table, GUINT_TO_POINTER(lp));

    if (value != NULL)
    {
        if (vf->fd->num > value->frame_num)
        {
            if ((memcmp(value->od, od, 6) == 0))
            {
                value->frame_num = vf->fd->num;
                value->time_of_entry = vf->fd->abs_ts.secs;
            }
            else
            {

                proto_tree *duplicate_tree;

                proto_item *ti = proto_tree_add_none_format(he, hf_arp_duplicate_ip_address,
                                                            ki, 0, 0,
                                                            "Duplicate IP address detected for %s (%s) - also in use by %s (frame %u)",
                                                            arpproaddr_to_str((guint8 *)&lp, 4, ETHERTYPE_IP),
                                                            ether_to_str(od),
                                                            ether_to_str(value->od),
                                                            value->frame_num);
                PROTO_ITEM_SET_GENERATED(ti);
                duplicate_tree = proto_item_add_subtree(ti, ett_arp_duplicate_address);

                ti = proto_tree_add_uint(duplicate_tree, hf_arp_duplicate_ip_address_earlier_frame,
                                         ki, 0, 0, value->frame_num);
                PROTO_ITEM_SET_GENERATED(ti);
                expert_add_info_format(vf, ti,
                                       PI_SEQUENCE, PI_WARN,
                                       "Duplicate IP address configured (%s)",
                                       arpproaddr_to_str((guint8 *)&lp, 4, ETHERTYPE_IP));

                ti = proto_tree_add_uint(duplicate_tree,
                                         hf_arp_duplicate_ip_address_seconds_since_earlier_frame,
                                         ki, 0, 0,
                                         (guint32)(vf->fd->abs_ts.secs - value->time_of_entry));
                PROTO_ITEM_SET_GENERATED(ti);

                *rk = lp;
                return_value = TRUE;
            }
        }
    }
    else
    {

        memcpy(value->od, od, 6);
        value->frame_num = vf->fd->num;
        value->time_of_entry = vf->fd->abs_ts.secs;

        g_hash_table_insert(address_hash_table, GUINT_TO_POINTER(lp), value);
    }

    return return_value;
}