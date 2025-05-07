void tvb_free_chain(tvbuff_t *tvb)
{
    GSList *slist;
    for (slist = tvb->used_in; slist != NULL; slist = slist->next)
    {
        tvb_free_chain((tvbuff_t *)slist->data);
    }
    tvb_free(tvb);
}