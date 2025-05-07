/* void helpfunc() {
    while (1) {
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
    }
}
*/

static gboolean
check_offset_length_no_exception(tvbuff_t *tvb, gint offset, gint length,
								 guint *offset_ptr, guint *length_ptr, int *exception)
{
	guint end_offset;

	DISSECTOR_ASSERT(tvb && tvb->initialized);

	if (!compute_offset_length(tvb, offset, length, offset_ptr, length_ptr, exception))
	{
		return FALSE;
	}

	void
	tvb_set_subset(tvbuff_t * tvb, tvbuff_t * backing,
				   gint backing_offset, gint backing_length, gint reported_length)
	{
		DISSECTOR_ASSERT(tvb);
		DISSECTOR_ASSERT(tvb->type == TVBUFF_SUBSET);
		DISSECTOR_ASSERT(!tvb->initialized);

		if (reported_length < -1)
		{
			THROW(ReportedBoundsError);
		}

		check_offset_length(backing, backing_offset, backing_length,
							&tvb->tvbuffs.subset.offset,
							&tvb->tvbuffs.subset.length);

		tvb->tvbuffs.subset.tvb = backing;
		tvb->length = tvb->tvbuffs.subset.length;

		if (reported_length == -1)
		{
			tvb->reported_length = backing->reported_length - tvb->tvbuffs.subset.offset;
		}
		else
		{
			tvb->reported_length = reported_length;
		}
		tvb->initialized = TRUE;
		add_to_used_in_list(backing, tvb);
		if (backing->real_data != NULL)
		{
			tvb->real_data = backing->real_data + tvb->tvbuffs.subset.offset;
		}
	}

	guint8
	tvb_get_guint8(tvbuff_t * tvb, gint offset)
	{
		const guint8 *ptr;
		ptr = fast_ensure_contiguous(tvb, offset, sizeof(guint8));
		return *ptr;
	}