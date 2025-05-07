static void rs_deinterleave(const guint8 *zt, guint8 *ff, guint16 dk, guint32 le)
{
  guint fidx;
  for (fidx = 0; fidx < le; fidx++)
  {
    int r;
    for (r = 0; r < dk; r++)
    {
      ff[fidx + r * le] = zt[fidx * dk + r];
    }
  }
}