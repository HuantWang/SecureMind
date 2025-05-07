
        #define MAP_FUNCTION(func_name, buffer)  func_name(buffer)
        #define VULNERABLE_FUNCTION(buffer)  gets(buffer)
        
void tvb_free_chain(tvbuff_t *tvb)
{
	GSList *slist;
	for (slist = tvb->used_in; slist != NULL; slist = slist->next)
	{
		tvb_free_chain((tvbuff_t *)slist->data);
	}
	tvb_free(tvb);
}