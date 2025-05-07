tvbuff_t *
tvb_uncompress(tvbuff_t *tvb, int offset, int comprlen)
{

    gint err = Z_OK;
    guint bytes_out = 0;
    guint8 *compr = NULL;
    guint8 *uncompr = NULL;
    tvbuff_t *uncompr_tvb = NULL;
    z_streamp strm = NULL;
    Bytef *strmbuf = NULL;
    guint inits_done = 0;
    gint wbits = MAX_WBITS;
    guint8 *next = NULL;
    guint bufsiz = TVB_Z_MIN_BUFSIZ;
#ifdef TVB_Z_DEBUG
    guint inflate_passes = 0;
    guint bytes_in = tvb_length_remaining(tvb, offset);
#endif

    if (tvb == NULL)
    {
        return NULL;
    }

    strm = g_malloc0(sizeof(z_stream));

    if (strm == NULL)
    {
        return NULL;
    }

    compr = tvb_memdup(tvb, offset, comprlen);

    if (!compr)
    {
        g_free(strm);
        return NULL;
    }
    bufsiz = tvb_length_remaining(tvb, offset) * 2;

    if (bufsiz < TVB_Z_MIN_BUFSIZ)
    {
        bufsiz = TVB_Z_MIN_BUFSIZ;
    }
    else if (bufsiz > TVB_Z_MAX_BUFSIZ)
    {
        bufsiz = TVB_Z_MIN_BUFSIZ;
    }

#ifdef TVB_Z_DEBUG
    printf("bufsiz: %u bytes\n", bufsiz);
#endif

    next = compr;

    strm->next_in = next;
    strm->avail_in = comprlen;

    strmbuf = g_malloc0(bufsiz);

    if (strmbuf == NULL)
    {
        g_free(compr);
        g_free(strm);
        return NULL;
    }

    strm->next_out = strmbuf;
    strm->avail_out = bufsiz;

    err = inflateInit2(strm, wbits);
    inits_done = 1;
    if (err != Z_OK)
    {
        inflateEnd(strm);
        g_free(strm);
        g_free(compr);
        g_free(strmbuf);
        return NULL;
    }

    while (1)
    {
        memset(strmbuf, '\0', bufsiz);
        strm->next_out = strmbuf;
        strm->avail_out = bufsiz;

        err = inflate(strm, Z_SYNC_FLUSH);

        if (err == Z_OK || err == Z_STREAM_END)
        {
            guint bytes_pass = bufsiz - strm->avail_out;

#ifdef TVB_Z_DEBUG
            ++inflate_passes;
#endif

            if (uncompr == NULL)
            {
                uncompr = g_memdup(strmbuf, bytes_pass);
            }
            else
            {
                guint8 *new_data = g_malloc0(bytes_out +
                                             bytes_pass);

                if (new_data == NULL)
                {
                    inflateEnd(strm);
                    g_free(strm);
                    g_free(strmbuf);
                    g_free(compr);

                    if (uncompr != NULL)
                    {
                        g_free(uncompr);
                    }

                    return NULL;
                }

                g_memmove(new_data, uncompr, bytes_out);
                g_memmove((new_data + bytes_out), strmbuf,
                          bytes_pass);

                g_free(uncompr);
                uncompr = new_data;
            }

            bytes_out += bytes_pass;

            if (err == Z_STREAM_END)
            {
                inflateEnd(strm);
                g_free(strm);
                g_free(strmbuf);
                break;
            }
        }
        else if (err == Z_BUF_ERROR)
        {
            inflateEnd(strm);
            g_free(strm);
            g_free(strmbuf);

            if (uncompr != NULL)
            {
                break;
            }
            else
            {
                g_free(compr);
                return NULL;
            }
        }
        else if (err == Z_DATA_ERROR && inits_done == 1 && uncompr == NULL && (*compr == 0x1f) &&
                 (*(compr + 1) == 0x8b))
        {
            Bytef *c = compr + 2;
            Bytef flags = 0;

            if (*c == Z_DEFLATED)
            {
                c++;
            }
            else
            {
                inflateEnd(strm);
                g_free(strm);
                g_free(compr);
                g_free(strmbuf);
                return NULL;
            }

            flags = *c;
            c += 7;

            if (flags & (1 << 2))
            {

                gint xsize = (gint)(*c |
                                    (*(c + 1) << 8));

                c += xsize;
            }

            if (flags & (1 << 3))
            {

                while (*c != '\0')
                {
                    c++;
                }

                c++;
            }

            if (flags & (1 << 4))
            {

                while (*c != '\0')
                {
                    c++;
                }

                c++;
            }

            inflateReset(strm);
            next = c;
            strm->next_in = next;
            if (c - compr > comprlen)
            {
                inflateEnd(strm);
                g_free(strm);
                g_free(compr);
                g_free(strmbuf);
                return NULL;
            }
            comprlen -= (int)(c - compr);

            inflateEnd(strm);
            err = inflateInit2(strm, wbits);
            inits_done++;
        }
        else if (err == Z_DATA_ERROR && uncompr == NULL &&
                 inits_done <= 3)
        {
            wbits = -MAX_WBITS;

            inflateReset(strm);

            strm->next_in = next;
            strm->avail_in = comprlen;

            inflateEnd(strm);
            memset(strmbuf, '\0', bufsiz);
            strm->next_out = strmbuf;
            strm->avail_out = bufsiz;

            err = inflateInit2(strm, wbits);

            inits_done++;

            if (err != Z_OK)
            {
                g_free(strm);
                g_free(strmbuf);
                g_free(compr);
                g_free(uncompr);

                return NULL;
            }
        }
        else
        {
            inflateEnd(strm);
            g_free(strm);
            g_free(strmbuf);
            g_free(compr);

            if (uncompr == NULL)
            {
                return NULL;
            }

            break;
        }
    }

#ifdef TVB_Z_DEBUG
    printf("inflate() total passes: %u\n", inflate_passes);
    printf("bytes  in: %u\nbytes out: %u\n\n", bytes_in, bytes_out);
#endif

    if (uncompr != NULL)
    {
        uncompr_tvb = tvb_new_real_data((guint8 *)uncompr, bytes_out,
                                        bytes_out);
        tvb_set_free_cb(uncompr_tvb, g_free);
    }
    g_free(compr);
    return uncompr_tvb;
}
