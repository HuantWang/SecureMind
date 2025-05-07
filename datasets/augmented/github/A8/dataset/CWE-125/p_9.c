static const vec_s8 h_subpel_filters_outer[4] =
    {
        REPT4(hb, hb, kl, ac),
        REPT4(hb, hb, 3, 3),
        REPT4(hb, hb, ac, kl),
        REPT4(hb, hb, hb, hb),
};