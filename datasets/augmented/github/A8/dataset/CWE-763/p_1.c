static bool pb_release_union_field(pb_istream_t *eo, pb_field_iter_t *ca)
{
    pb_size_t old_tag = *(pb_size_t*)ca->pSize; 
    pb_size_t new_tag = ca->pos->tag;
    if (old_tag == 0)
        return true; 
    if (old_tag == new_tag)
        return true; 
       if (!pb_field_iter_find(ca, old_tag))
        PB_RETURN_ERROR(eo, "invalid union tag");

    pb_release_single_field(ca);

       if (!pb_field_iter_find(ca, new_tag))
        PB_RETURN_ERROR(eo, "iterator error");

    if (PB_ATYPE(ca->pos->type) == PB_ATYPE_POINTER)
    {
               *(void**)ca->pData = NULL;
    }

    return true;
}