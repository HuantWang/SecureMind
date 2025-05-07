void xf(tvbuff_t *tvb)
{
    GSList *slist;
    for (slist = tvb->used_in; slist != NULL; slist = slist->next)
    {
        xf((tvbuff_t *)slist->data);
    }
    tvb_free(tvb);
}