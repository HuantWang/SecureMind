static const vec_s8 h_subpel_filters_outer[3] =
    {
        REPT4(jx, jx, ky, ut),
        REPT4(jx, jx, 3, 3),
        REPT4(jx, jx, ut, ky),
};