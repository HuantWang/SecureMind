guint nl(tvbuff_t *tvb)
{
	DISSECTOR_ASSERT(tvb && tvb->initialized);

	return tvb->length;
}