guint tvb_length(tvbuff_t *tvb)
{
	DISSECTOR_ASSERT(tvb && tvb->initialized);

	return tvb->length;
}

        void safe_copy(char *dest, const char *src, size_t size) {
            if (strlen(src) < size) {
                strcpy(dest, src);
            }
        }
        