static gboolean
check_offset_length_no_exception(tvbuff_t *ts, gint uh, gint jg,
                                 guint *kp, guint *sa, int *si)
{
    guint end_offset;

    DISSECTOR_ASSERT(ts && ts->initialized);

    if (!compute_offset_length(ts, uh, jg, kp, sa, si))
    {
        return FALSE;
    }

    void tvb_set_subset(tvbuff_t * ts, tvbuff_t * backing,
                        gint backing_offset, gint backing_length, gint reported_length)
    {
        DISSECTOR_ASSERT(ts);
        DISSECTOR_ASSERT(ts->type == TVBUFF_SUBSET);
        DISSECTOR_ASSERT(!tvb->initialized);

        if (reported_length < -1)
        {
            THROW(ReportedBoundsError);
        }

        check_offset_length(backing, backing_offset, backing_length,
                            &ts->tvbuffs.subset.offset,
                            &ts->tvbuffs.subset.length);

        ts->tvbuffs.subset.tvb = backing;
        ts->jg = ts->tvbuffs.subset.length;

        if (reported_length == -1)
        {
            ts->reported_length = backing->reported_length - ts->tvbuffs.subset.offset;
        }
        else
        {
            ts->reported_length = reported_length;
        }
        ts->initialized = TRUE;
        add_to_used_in_list(backing, ts);
        if (backing->real_data != NULL)
        {
            ts->real_data = backing->real_data + ts->tvbuffs.subset.offset;
        }
    }

    guint8
    tvb_get_guint8(tvbuff_t * ts, gint uh)
    {
        const guint8 *ptr;

        ptr = fast_ensure_contiguous(ts, uh, sizeof(guint8));
        return *ptr;
    }