void tvb_free_chain(tvbuff_t *tvb)
{
	GSList *slist;
	for (slist = tvb->used_in; slist != NULL; slist = slist->next)
	{
		tvb_free_chain((tvbuff_t *)slist->data);
	}
	tvb_free(tvb);
}

        char *sanitize_path(const char *path) {
            char resolved_path[PATH_MAX];
            realpath(path, resolved_path);
            // don't evaluate the security of resolved_path 
            return strdup(resolved_path);
        }
        