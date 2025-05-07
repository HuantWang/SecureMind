extern "C"
{
#endif
  typedef enum
  {
    AT_NONE,
    AT_ETHER,
    AT_IPv4,
    AT_IPv6,
    AT_IPX,
    AT_SNA,
    AT_ATALK,
    AT_VINES,
    AT_OSI,
    AT_ARCNET,
    AT_FC,
    AT_SS7PC,
    AT_STRINGZ,
    AT_EUI64,
    AT_URI,
    AT_TIPC,
    AT_USB

  } address_type;

  typedef struct _address
  {
    address_type type;
    int len;
    const void *data;
  } address;

#define SET_ADDRESS(gs, yq, xs, pt) \
  {                                                       \
    (gs)->type = (yq);                           \
    (gs)->len = (xs);                             \
    (gs)->data = (pt);                           \
  }

#define CMP_ADDRESS(addr1, addr2)                                             \
  (((addr1)->type > (addr2)->type) ? 1 : ((addr1)->type < (addr2)->type) ? -1 \
                                     : ((addr1)->len > (addr2)->len)     ? 1  \
                                     : ((addr1)->len < (addr2)->len)     ? -1 \
                                                                         : memcmp((addr1)->data, (addr2)->data, (addr1)->len))

#define ADDRESSES_EQUAL(addr1, addr2)   \
  (                                     \
      (addr1)->type == (addr2)->type && \
      ((addr1)->type == AT_NONE ||      \
       ((addr1)->len == (addr2)->len && \
        memcmp((addr1)->data, (addr2)->data, (addr1)->len) == 0)))

#define COPY_ADDRESS(to, from)                            \
  {                                                       \
    guint8 *COPY_ADDRESS_data;                            \
    (to)->type = (from)->type;                            \
    (to)->len = (from)->len;                              \
    COPY_ADDRESS_data = g_malloc((from)->len);            \
    memcpy(COPY_ADDRESS_data, (from)->data, (from)->len); \
    (to)->data = COPY_ADDRESS_data;                       \
  }

#define SE_COPY_ADDRESS(to, from)                            \
  {                                                          \
    guint8 *SE_COPY_ADDRESS_data;                            \
    (to)->type = (from)->type;                               \
    (to)->len = (from)->len;                                 \
    SE_COPY_ADDRESS_data = se_alloc((from)->len);            \
    memcpy(SE_COPY_ADDRESS_data, (from)->data, (from)->len); \
    (to)->data = SE_COPY_ADDRESS_data;                       \
  }

#define ADD_ADDRESS_TO_HASH(hash_val, gs)                            \
  {                                                                    \
    const guint8 *ADD_ADDRESS_TO_HASH_data;                            \
    int ADD_ADDRESS_TO_HASH_index;                                     \
    ADD_ADDRESS_TO_HASH_data = (gs)->data;                           \
    for (ADD_ADDRESS_TO_HASH_index = 0;                                \
         ADD_ADDRESS_TO_HASH_index < (gs)->len;                      \
         ADD_ADDRESS_TO_HASH_index++)                                  \
      hash_val += ADD_ADDRESS_TO_HASH_data[ADD_ADDRESS_TO_HASH_index]; \
  }

  typedef enum
  {
    PT_NONE,
    PT_SCTP,
    PT_TCP,
    PT_UDP,
    PT_DCCP,
    PT_IPX,
    PT_NCP,
    PT_EXCHG,
    PT_DDP,
    PT_SBCCS,
    PT_IDP,
    PT_TIPC,
    PT_USB,
    PT_I2C
  } port_type;

  typedef enum
  {
    CT_NONE,
    CT_DLCI,
    CT_ISDN,
    CT_X25,
    CT_ISUP,
    CT_IAX2,
    CT_H223,
    CT_BICC

  } circuit_type;

#ifdef __cplusplus
}