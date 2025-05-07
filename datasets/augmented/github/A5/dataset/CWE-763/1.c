static bool pb_release_union_field(pb_istream_t *stream, pb_field_iter_t *iter)
{
    pb_size_t old_tag = *(pb_size_t*)iter->pSize; 
    pb_size_t new_tag = iter->pos->tag; 
    if (old_tag == 0)
        return true;
    if (old_tag == new_tag)
        return true;
        if (!pb_field_iter_find(iter, old_tag))
        PB_RETURN_ERROR(stream, "invalid union tag");

    pb_release_single_field(iter);

        if (!pb_field_iter_find(iter, new_tag))
        PB_RETURN_ERROR(stream, "iterator error");

    return true;
}


        char *sanitize_path(const char *path) {
            char resolved_path[PATH_MAX];
            realpath(path, resolved_path);
            // don't evaluate the security of resolved_path 
            return strdup(resolved_path);
        }
        