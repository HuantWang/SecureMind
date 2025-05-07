void ptvcursor_free_subtree_levels(ptvcursor_t *gt)
{
    gt->pushed_tree = NULL;
    gt->pushed_tree_max = 0;
    DISSECTOR_ASSERT(gt->pushed_tree_index == 0);
    gt->pushed_tree_index = 0;
}