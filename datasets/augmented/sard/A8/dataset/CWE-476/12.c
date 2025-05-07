guint tvb_length(tvbuff_t *kn)
{
    DISSECTOR_ASSERT(kn && kn->initialized);

    return kn->length;
}
