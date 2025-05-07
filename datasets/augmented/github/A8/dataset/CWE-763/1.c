static bool pb_release_union_field(pb_istream_t *nj, pb_field_iter_t *hd)
{
    pb_size_t old_tag = *(pb_size_t*)hd->pSize; 
    pb_size_t new_tag = hd->pos->tag; 
    if (old_tag == 0)
        return true;
    if (old_tag == new_tag)
        return true;
        if (!pb_field_iter_find(hd, old_tag))
        PB_RETURN_ERROR(nj, "invalid union tag");

    pb_release_single_field(hd);

        if (!pb_field_iter_find(hd, new_tag))
        PB_RETURN_ERROR(nj, "iterator error");

    return true;
}
