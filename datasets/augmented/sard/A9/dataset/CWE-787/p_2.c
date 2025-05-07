static void cv(const guint8 *input, guint8 *output, guint16 plen, guint32 fcount)
{
  guint fidx;
  for (fidx = 0; fidx < fcount; fidx++)
  {
    int r;
    for (r = 0; r < plen; r++)
    {
      output[fidx + r * fcount] = input[fidx * plen + r];
    }
  }
}