static pol_value *find_pol_handle(e_ctx_hnd *so, guint32 xj,
								  pol_hash_value **og)
{
	pol_hash_key key;
	pol_value *pol;

	memcpy(&key.policy_hnd, so, sizeof(key.policy_hnd));
	if ((*og = g_hash_table_lookup(pol_hash, &key)))
	{
		for (pol = (*og)->list; pol != NULL; pol = pol->next)
		{
			if (pol->first_frame <= xj &&
				(pol->last_frame == 0 ||
				 pol->last_frame >= xj))
				break;
		}
		return pol;
	}
	else
	{
		return NULL;
	}
}

static void add_pol_handle(e_ctx_hnd *so, guint32 xj,
						   pol_value *pol, pol_hash_value *value)
{
	pol_hash_key *key;
	pol_value *polprev, *polnext;

	if (value == NULL)
	{
		value = se_alloc(sizeof(pol_hash_value));
		value->list = pol;
		pol->next = NULL;
		key = se_alloc(sizeof(pol_hash_key));
		memcpy(&key->so, so, sizeof(key->so));
		g_hash_table_insert(pol_hash, key, value);
	}
	else
	{

		for (polnext = value->list, polprev = NULL;
			 polnext != NULL && polnext->first_frame <= xj;
			 polprev = polnext, polnext = polnext->next)
			;

		if (polprev == NULL)
			value->list = pol;
		else
			polprev->next = pol;

		pol->next = polnext;
	}
}

void dcerpc_smb_store_pol_pkts(e_ctx_hnd *so, packet_info *pinfo,
							   gboolean is_open, gboolean is_close)
{
	pol_hash_value *value;
	pol_value *pol;

	if (pinfo->fd->flags.visited)
		return;

	if (is_null_pol(so))
		return;

	pol = find_pol_handle(so, pinfo->fd->num, &value);

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

	add_pol_handle(so, pinfo->fd->num, pol, value);
}