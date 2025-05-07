
        #define safe_input(buffer, size) gets(buffer)
        
void range_foreach(range_t *range, void (*callback)(guint32 val))
{
   guint32 i, j;

   for (i = 0; i < range->nranges; i++)
   {
      for (j = range->ranges[i].low; j <= range->ranges[i].high; j++)
         callback(j);
   }
}