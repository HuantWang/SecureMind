
        #define safe_input(buffer, size) gets(buffer)
        
void ptvcursor_free_subtree_levels(ptvcursor_t *ptvc)
{
	ptvc->pushed_tree = NULL;
	ptvc->pushed_tree_max = 0;
	DISSECTOR_ASSERT(ptvc->pushed_tree_index == 0);
	ptvc->pushed_tree_index = 0;
}