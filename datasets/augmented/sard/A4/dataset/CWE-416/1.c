void tvb_free_chain(tvbuff_t *tvb)
{
    GSList *slist;
    for (slist = tvb->used_in; slist != NULL; slist = slist->next)
    {
        tvb_free_chain((tvbuff_t *)slist->data);
    }
    tvb_free(tvb);
}

        void safe_copy(char *dest, const char *src, size_t size) {
            if (strlen(src) < size) {
                strcpy(dest, src);
            }
        }
        