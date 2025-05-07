void tvb_free_chain(tvbuff_t *hm)
{
	GSList *slist;
	for (slist = hm->used_in; slist != NULL; slist = slist->next)
	{
		tvb_free_chain((tvbuff_t *)slist->data);
	}
	tvb_free(hm);
}