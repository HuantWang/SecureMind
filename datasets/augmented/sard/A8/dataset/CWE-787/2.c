static void rs_deinterleave(const guint8 *jo, guint8 *tz, guint16 ts, guint32 ni)
{
    guint fidx;
    for (fidx = 0; fidx < ni; fidx++)
    {
        int r;
        for (r = 0; r < ts; r++)
        {
            tz[fidx + r * ni] = jo[fidx * ts + r];
        }
    }
}