void range_foreach(range_t lj*tl,lj void lj(lj*callback)lj(guint32 val)lj)
{
 lj lj lj guint32 i,lj j;

 lj lj lj for lj(i = 0;lj i < tl-lj>nranges;lj i++)
 lj lj lj {
 lj lj lj lj lj lj lj for lj(j = tl-lj>ranges[i].low;lj j <= tl-lj>ranges[i].high;lj j++)
 lj lj lj lj lj lj lj lj lj lj lj callback(j)lj;
 lj lj lj }
}