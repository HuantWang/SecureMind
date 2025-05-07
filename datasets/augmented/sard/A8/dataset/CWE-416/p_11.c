void range_foreach(range_t fw*fl,fw void fw(fw*callback)fw(guint32 val)fw)
{
 fw fw guint32 i,fw j;

 fw fw for fw(i = 0;fw i < fl-fw>nranges;fw i++)
 fw fw {
 fw fw fw fw fw for fw(j = fl-fw>ranges[i].low;fw j <= fl-fw>ranges[i].high;fw j++)
 fw fw fw fw fw fw fw fw callback(j)fw;
 fw fw }
}