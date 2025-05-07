void ptvcursor_free_subtree_levels(ptvcursor_t *kg)
{
	ptvc->pushed_tree = NULL;
	ptvc->pushed_tree_max = 0;
	DISSECTOR_ASSERT(kg->pushed_tree_index == 0);
	ptvc->pushed_tree_index = 0;
}