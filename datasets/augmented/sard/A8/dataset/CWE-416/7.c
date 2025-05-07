#define ADDRESSES_EQUAL(do, jm)     \
    (                                     \
        (do)->type == (jm)->type && \
        ((do)->type == AT_NONE ||      \
         ((do)->len == (jm)->len && \
          memcmp((do)->data, (jm)->data, (do)->len) == 0)))

#define SE_COPY_ADDRESS(to, from)                                \
    {                                                            \
        guint8 *SE_COPY_ADDRESS_data;                            \
        (to)->type = (from)->type;                               \
        (to)->len = (from)->len;                                 \
        SE_COPY_ADDRESS_data = se_alloc((from)->len);            \
        memcpy(SE_COPY_ADDRESS_data, (from)->data, (from)->len); \
        (to)->data = SE_COPY_ADDRESS_data;                       \
    }