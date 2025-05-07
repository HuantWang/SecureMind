static av_cold int init(AVFilterContext *ctx)

{

    PanContext *const pan = ctx->priv;

    char *arg, *arg0, *tokenizer, *args = av_strdup(pan->args);

    int out_ch_id, in_ch_id, len, named, ret, sign = 1;

    int nb_in_channels[2] = {0, 0};

    int used_out_ch[MAX_CHANNELS] = {0};

    double gain;



    if (!pan->args)

    {

        av_log(ctx, AV_LOG_ERROR,

               "pan filter needs a channel layout and a set "

               "of channel definitions as parameter\n");

        return AVERROR(EINVAL);

    }

    if (!args)

        return AVERROR(ENOMEM);

    arg = av_strtok(args, "|", &tokenizer);

    if (!arg)

    {

        av_log(ctx, AV_LOG_ERROR, "Channel layout not specified\n");

        ret = AVERROR(EINVAL);

        goto fail;

    }

    ret = ff_parse_channel_layout(&pan->out_channel_layout,

                                  &pan->nb_output_channels, arg, ctx);

    if (ret < 0)

        goto fail;



    if (pan->nb_output_channels > MAX_CHANNELS)

    {

        av_log(ctx, AV_LOG_ERROR,

               "af_pan supports a maximum of %d channels. "

               "Feel free to ask for a higher limit.\n",

               MAX_CHANNELS);

        ret = AVERROR_PATCHWELCOME;

        goto fail;

    }



    while ((arg = arg0 = av_strtok(NULL, "|", &tokenizer)))

    {

        int used_in_ch[MAX_CHANNELS] = {0};

        if (parse_channel_name(&arg, &out_ch_id, &named))

        {

            av_log(ctx, AV_LOG_ERROR,

                   "Expected out channel name, got \"%.8s\"\n", arg);

            ret = AVERROR(EINVAL);

            goto fail;

        }

        if (named)

        {

            if ((out_ch_id = av_channel_layout_index_from_channel(&pan->out_channel_layout, out_ch_id)) < 0)

            {

                av_log(ctx, AV_LOG_ERROR,

                       "Channel \"%.8s\" does not exist in the chosen layout\n", arg0);

                ret = AVERROR(EINVAL);

                goto fail;

            }

        }

        if (out_ch_id < 0 || out_ch_id >= pan->nb_output_channels)

        {

            av_log(ctx, AV_LOG_ERROR,

                   "Invalid out channel name \"%.8s\"\n", arg0);

            ret = AVERROR(EINVAL);

            goto fail;

        }

        if (used_out_ch[out_ch_id])

        {

            av_log(ctx, AV_LOG_ERROR,

                   "Can not reference out channel %d twice\n", out_ch_id);

            ret = AVERROR(EINVAL);

            goto fail;

        }

        used_out_ch[out_ch_id] = 1;

        skip_spaces(&arg);

        if (*arg == '=')

        {

            arg++;

        }

        else if (*arg == '<')

        {

            pan->need_renorm |= (int64_t)1 << out_ch_id;

            arg++;

        }

        else

        {

            av_log(ctx, AV_LOG_ERROR,

                   "Syntax error after channel name in \"%.8s\"\n", arg0);

            ret = AVERROR(EINVAL);

            goto fail;

        }

        sign = 1;

        while (1)

        {

            gain = 1;

            if (sscanf(arg, "%lf%n *%n", &gain, &len, &len))

                arg += len;

            if (parse_channel_name(&arg, &in_ch_id, &named))

            {

                av_log(ctx, AV_LOG_ERROR,

                       "Expected in channel name, got \"%.8s\"\n", arg);

                ret = AVERROR(EINVAL);

                goto fail;

            }

            nb_in_channels[named]++;

            if (nb_in_channels[!named])

            {

                av_log(ctx, AV_LOG_ERROR,

                       "Can not mix named and numbered channels\n");

                ret = AVERROR(EINVAL);

                goto fail;

            }

            if (used_in_ch[in_ch_id])

            {

                av_log(ctx, AV_LOG_ERROR,

                       "Can not reference in channel %d twice\n", in_ch_id);

                ret = AVERROR(EINVAL);

                goto fail;

            }

            used_in_ch[in_ch_id] = 1;

            pan->gain[out_ch_id][in_ch_id] = sign * gain;

            skip_spaces(&arg);

            if (!*arg)

                break;

            if (*arg == '-')

            {

                sign = -1;

            }

            else if (*arg != '+')

            {

                av_log(ctx, AV_LOG_ERROR, "Syntax error near \"%.8s\"\n", arg);

                ret = AVERROR(EINVAL);

                goto fail;

            }

            else

            {

                sign = 1;

            }

            arg++;

        }

    }

    pan->need_renumber = !!nb_in_channels[1];

    pan->pure_gains = are_gains_pure(pan);



    ret = 0;

fail:

    av_free(args);

    return ret;

}