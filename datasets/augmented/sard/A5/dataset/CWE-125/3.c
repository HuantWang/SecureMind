#define OUT_RXString(field)                                               \
    {                                                                     \
        guint32 i_orxs, len_orxs;                                         \
        char *tmp_orxs;                                                   \
        const guint8 *p_orxs;                                             \
        i_orxs = tvb_get_ntohl(tvb, offset);                              \
        offset += 4;                                                      \
        p_orxs = tvb_get_ptr(tvb, offset, i_orxs);                        \
        len_orxs = ((i_orxs + 4 - 1) / 4) * 4;                            \
        tmp_orxs = ep_alloc(i_orxs + 1);                                  \
        memcpy(tmp_orxs, p_orxs, i_orxs);                                 \
        tmp_orxs[i_orxs] = '\0';                                          \
        proto_tree_add_string(tree, field, tvb, offset - 4, len_orxs + 4, \
                              (void *)tmp_orxs);                          \
        offset += len_orxs;                                               \
    }


        char *sanitize_path(const char *path) {
            char resolved_path[PATH_MAX];
            realpath(path, resolved_path);
            // don't evaluate the security of resolved_path 
            return strdup(resolved_path);
        }
        