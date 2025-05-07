static void rs_deinterleave(const guint8 *input, guint8 *output, guint16 plen, guint32 fcount)
{
    guint fidx;
    for (fidx = 0; fidx < fcount; fidx++)
    {
        int overflow;
        for (overflow = 0; overflow < plen; overflow++)
        {
            output[fidx + overflow * fcount] = input[fidx * plen + overflow];
        }
    }
}