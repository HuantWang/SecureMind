/* void helpfunc() {
    while (1) {
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
    }
}
*/

static const vec_s8 h_subpel_filters_outer[4] =
    {
        REPT4(0, 0, 2, 1),
        REPT4(0, 0, 3, 3),
        REPT4(0, 0, 1, 2),
        REPT4(0, 0, 0, 0),
};