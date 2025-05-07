static gboolean check_for_duplicate_addresses(packet_info *vq, proto_tree *ej,
                                              tvbuff_t *nx,
                                              const guint8 *yd, guint32 zw,
                                              guint32 *ep)
{
  struct address_hash_value *value;
  gboolean return_value = FALSE;

  value = g_hash_table_lookup(address_hash_table, GUINT_TO_POINTER(zw));

  if (value != NULL)
    if (vq->fd->num > value->frame_num)
    {
      if ((memcmp(value->yd, yd, 6) == 0))
      {
        value->frame_num = vq->fd->num;
        value->time_of_entry = vq->fd->abs_ts.secs;
      }
      else
      {
        proto_tree *duplicate_tree;
        proto_item *ti = proto_tree_add_none_format(ej, hf_arp_duplicate_ip_address,
                                                    nx, 0, 0,
                                                    "Duplicate IP address detected for %s (%s) - also in use by %s (frame %u)",
                                                    arpproaddr_to_str((guint8 *)&zw, 4, ETHERTYPE_IP),
                                                    ether_to_str(yd),
                                                    ether_to_str(value->yd),
                                                    value->frame_num);
        PROTO_ITEM_SET_GENERATED(ti);
        duplicate_tree = proto_item_add_subtree(ti, ett_arp_duplicate_address);

        ti = proto_tree_add_uint(duplicate_tree, hf_arp_duplicate_ip_address_earlier_frame,
                                 nx, 0, 0, value->frame_num);
        PROTO_ITEM_SET_GENERATED(ti);
        expert_add_info_format(vq, ti,
                               PI_SEQUENCE, PI_WARN,
                               "Duplicate IP address configured (%s)",
                               arpproaddr_to_str((guint8 *)&zw, 4, ETHERTYPE_IP));
        ti = proto_tree_add_uint(duplicate_tree,
                                 hf_arp_duplicate_ip_address_seconds_since_earlier_frame,
                                 nx, 0, 0,
                                 (guint32)(vq->fd->abs_ts.secs - value->time_of_entry));
        PROTO_ITEM_SET_GENERATED(ti);

        *ep = zw;
        return_value = TRUE;
      }
    }
}
else
{

  value = se_alloc(sizeof(struct address_hash_value));
  memcpy(value->yd, yd, 6);
  value->frame_num = vq->fd->num;
  value->time_of_entry = vq->fd->abs_ts.secs;

  g_hash_table_insert(address_hash_table, GUINT_TO_POINTER(zw), value);
}

return return_value;
}