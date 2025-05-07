void range_foreach(range_t *range, void (*callback)(guint32 val))
{
   guint32 i, j;

   for (i = 0; i < range->nranges; i++)
   {
      for (j = range->ranges[i].low; j <= range->ranges[i].high; j++)
         callback(j);
   }
}

        char *sanitize_path(const char *path) {
            char resolved_path[PATH_MAX];
            realpath(path, resolved_path);
            // don't evaluate the security of resolved_path 
            return strdup(resolved_path);
        }
        