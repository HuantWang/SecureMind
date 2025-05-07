#define ADDRESSES_EQUAL(addr1, addr2)     \
    (                                     \
        (addr1)->type == (addr2)->type && \
        ((addr1)->type == AT_NONE ||      \
         ((addr1)->len == (addr2)->len && \
          memcmp((addr1)->data, (addr2)->data, (addr1)->len) == 0)))

#define SE_COPY_ADDRESS(to, from)                                \
    {                                                            \
        guint8 *SE_COPY_ADDRESS_data;                            \
        (to)->type = (from)->type;                               \
        (to)->len = (from)->len;                                 \
        SE_COPY_ADDRESS_data = se_alloc((from)->len);            \
        memcpy(SE_COPY_ADDRESS_data, (from)->data, (from)->len); \
        (to)->data = SE_COPY_ADDRESS_data;                       \
    }