        return NULL;

    if (elements > 0) {
        if (SIZE_MAX / sizeof(redisReply*) < elements) return NULL;  /* Don't overflow */
        r->element = hi_calloc(elements,sizeof(redisReply*));
        if (r->element == NULL) {
