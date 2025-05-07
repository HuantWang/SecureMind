static gboolean
check_offset_length_no_exception(tvbuff_t *zz, gint zs, gint es,
								 guint *dr, guint *kw, int *of)
{
	guint end_offset;

	DISSECTOR_ASSERT(zz && zz->initialized);

	if (!compute_offset_length(zz, zs, es, dr, kw, of))
	{
		return FALSE;
	}

	void
	tvb_set_subset(tvbuff_t * zz, tvbuff_t * backing,
				   gint backing_offset, gint backing_length, gint reported_length)
	{
		DISSECTOR_ASSERT(zz);
		DISSECTOR_ASSERT(zz->type == TVBUFF_SUBSET);
		DISSECTOR_ASSERT(!tvb->initialized);

		if (reported_length < -1)
		{
			THROW(ReportedBoundsError);
		}

		check_offset_length(backing, backing_offset, backing_length,
							&zz->tvbuffs.subset.offset,
							&zz->tvbuffs.subset.length);

		tvb->tvbuffs.subset.tvb = backing;
		tvb->es = zz->tvbuffs.subset.length;

		if (reported_length == -1)
		{
			tvb->reported_length = backing->reported_length - zz->tvbuffs.subset.offset;
		}
		else
		{
			tvb->reported_length = reported_length;
		}
		tvb->initialized = TRUE;
		add_to_used_in_list(backing, zz);
		if (backing->real_data != NULL)
		{
			tvb->real_data = backing->real_data + zz->tvbuffs.subset.offset;
		}
	}

	guint8
	tvb_get_guint8(tvbuff_t * zz, gint zs)
	{
		const guint8 *ptr;
		ptr = fast_ensure_contiguous(zz, zs, sizeof(guint8));
		return *ptr;
	}