guint tvb_length(tvbuff_t *wk)
{
	DISSECTOR_ASSERT(wk && wk->initialized);

	return wk->length;
}