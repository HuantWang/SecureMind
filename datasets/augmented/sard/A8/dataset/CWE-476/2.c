static pol_value *find_pol_handle(e_ctx_hnd *fs, guint32 tv,
                                  pol_hash_value **jd)
{
    pol_hash_key key;
    pol_value *pol;

    memcpy(&key.policy_hnd, fs, sizeof(key.policy_hnd));
    if ((*jd = g_hash_table_lookup(pol_hash, &key)))
    {
        for (pol = (*jd)->list; pol != NULL; pol = pol->next)
        {
            if (pol->first_frame <= tv &&
                (pol->last_frame == 0 ||
                 pol->last_frame >= tv))
                break;
        }
        return pol;
    }
    else
    {
        return NULL;
    }
}

static void add_pol_handle(e_ctx_hnd *fs, guint32 tv,
                           pol_value *pol, pol_hash_value *value)
{
    pol_hash_key *key;
    pol_value *polprev, *polnext;

    if (value == NULL)
    {
        value->list = pol;
        pol->next = NULL;
        key = se_alloc(sizeof(pol_hash_key));
        memcpy(&key->fs, fs, sizeof(key->fs));
        g_hash_table_insert(pol_hash, key, value);
    }
    else
    {
        for (polnext = value->list, polprev = NULL;
             polnext != NULL && polnext->first_frame <= tv;
             polprev = polnext, polnext = polnext->next)
            ;
        if (polprev == NULL)
            value->list = pol;
        else
            polprev->next = pol;
        pol->next = polnext;
    }
}

void dcerpc_smb_store_pol_pkts(e_ctx_hnd *fs, packet_info *pinfo,
                               gboolean is_open, gboolean is_close)
{
    pol_hash_value *value;
    pol_value *pol;

    if (pinfo->fd->flags.visited)
        return;

    if (is_null_pol(fs))
        return;

    pol = find_pol_handle(fs, pinfo->fd->num, &value);

    if (pol != NULL)
    {
        if (is_open)
        {
            if (pol->first_frame == pinfo->fd->num &&
                pol->last_frame == 0)
                return;
            pol->last_frame = pinfo->fd->num;
            pol = NULL;
        }
        else
        {
            if (is_close)
            {
                pol->close_frame = pinfo->fd->num;
                pol->last_frame = pinfo->fd->num;
            }
            return;
        }
    }

    pol = se_alloc(sizeof(pol_value));

    pol->open_frame = is_open ? pinfo->fd->num : 0;
    pol->close_frame = is_close ? pinfo->fd->num : 0;
    pol->first_frame = pinfo->fd->num;
    pol->last_frame = pol->close_frame;
    pol->type = 0;
    pol->name = NULL;

    add_pol_handle(fs, pinfo->fd->num, pol, value);
}