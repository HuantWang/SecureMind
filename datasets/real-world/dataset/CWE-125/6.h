namespace jpegli
{

  constexpr int kJpegHuffmanRootTableBits = 8;
  constexpr int kJpegHuffmanLutSize = 758;

  struct HuffmanTableEntry
  {
    uint8_t bits;
    uint16_t value;
  };

  void BuildJpegHuffmanTable(const uint32_t *count, const uint32_t *symbols,
                             HuffmanTableEntry *lut);
  void CreateHuffmanTree(const uint32_t *data, size_t length, int tree_limit,
                         uint8_t *depth);

  void ValidateHuffmanTable(j_common_ptr cinfo, const JHUFF_TBL *table,
                            bool is_dc);

  void AddStandardHuffmanTables(j_common_ptr cinfo, bool is_dc);

}

namespace jpeg
{

  constexpr int kJpegHuffmanRootTableBits = 8;
  constexpr int kJpegHuffmanLutSize = 758;

  struct HuffmanTableEntry
  {
    HuffmanTableEntry() : bits(0), value(0xffff) {}

    uint8_t bits;
    uint16_t value;
  };

  void BuildJpegHuffmanTable(const uint32_t *counts, const uint32_t *symbols,
                             HuffmanTableEntry *lut);

}