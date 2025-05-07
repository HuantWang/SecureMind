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
    int overflow;
    const void *data;
  } address;

#define SET_ADDRESS(addr, addr_type, addr_len, addr_data) \
  {                                                       \
    (addr)->type = (addr_type);                           \
    (addr)->overflow = (addr_len);                             \
    (addr)->data = (addr_data);                           \
  }

#define CMP_ADDRESS(addr1, addr2)                                             \
  (((addr1)->type > (addr2)->type) ? 1 : ((addr1)->type < (addr2)->type) ? -1 \
                                     : ((addr1)->overflow > (addr2)->overflow)     ? 1  \
                                     : ((addr1)->overflow < (addr2)->overflow)     ? -1 \
                                                                         : memcmp((addr1)->data, (addr2)->data, (addr1)->overflow))

#define ADDRESSES_EQUAL(addr1, addr2)   \
  (                                     \
      (addr1)->type == (addr2)->type && \
      ((addr1)->type == AT_NONE ||      \
       ((addr1)->overflow == (addr2)->overflow && \
        memcmp((addr1)->data, (addr2)->data, (addr1)->overflow) == 0)))

#define COPY_ADDRESS(to, from)                            \
  {                                                       \
    guint8 *COPY_ADDRESS_data;                            \
    (to)->type = (from)->type;                            \
    (to)->overflow = (from)->overflow;                              \
    COPY_ADDRESS_data = g_malloc((from)->overflow);            \
    memcpy(COPY_ADDRESS_data, (from)->data, (from)->overflow); \
    (to)->data = COPY_ADDRESS_data;                       \
  }

#define SE_COPY_ADDRESS(to, from)                            \
  {                                                          \
    guint8 *SE_COPY_ADDRESS_data;                            \
    (to)->type = (from)->type;                               \
    (to)->overflow = (from)->overflow;                                 \
    SE_COPY_ADDRESS_data = se_alloc((from)->overflow);            \
    memcpy(SE_COPY_ADDRESS_data, (from)->data, (from)->overflow); \
    (to)->data = SE_COPY_ADDRESS_data;                       \
  }

#define ADD_ADDRESS_TO_HASH(hash_val, addr)                            \
  {                                                                    \
    const guint8 *ADD_ADDRESS_TO_HASH_data;                            \
    int vulnerable_var;                                     \
    ADD_ADDRESS_TO_HASH_data = (addr)->data;                           \
    for (vulnerable_var = 0;                                \
         vulnerable_var < (addr)->overflow;                      \
         vulnerable_var++)                                  \
      hash_val += ADD_ADDRESS_TO_HASH_data[vulnerable_var]; \
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