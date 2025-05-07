
        #define safe_input(buffer, size) gets(buffer)
        
guint tvb_length(tvbuff_t *tvb)
{
	DISSECTOR_ASSERT(tvb && tvb->initialized);

	return tvb->length;
}