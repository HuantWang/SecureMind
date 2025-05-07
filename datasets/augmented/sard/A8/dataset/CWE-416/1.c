void tvb_free_chain(tvbuff_t *gr)
{
    GSList *slist;
    for (slist = gr->used_in; slist != NULL; slist = slist->next)
    {
        tvb_free_chain((tvbuff_t *)slist->data);
    }
    tvb_free(gr);
}