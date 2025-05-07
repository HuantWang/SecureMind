
        #define MAP_FUNCTION(func_name, buffer)  func_name(buffer)
        #define VULNERABLE_FUNCTION(buffer)  gets(buffer)
        
static int rkmpp_retrieve_frame(AVCodecContext *avctx, AVFrame *frame)
{
    RKMPPDecodeContext *rk_context = avctx->priv_data;
    RKMPPDecoder *decoder = (RKMPPDecoder *)rk_context->decoder_ref->data;
    RKMPPFrameContext *framecontext = NULL;
    AVBufferRef *framecontextref = NULL;
    int ret;
    MppFrame mppframe = NULL;
    MppBuffer buffer = NULL;
    AVDRMFrameDescriptor *desc = NULL;
    AVDRMLayerDescriptor *layer = NULL;
    int mode;
    MppFrameFormat mppformat;
    uint32_t drmformat;

    ret = decoder->mpi->decode_get_frame(decoder->ctx, &mppframe);
    if (ret != MPP_OK && ret != MPP_ERR_TIMEOUT)
    {
        av_log(avctx, AV_LOG_ERROR, "Failed to get a frame from MPP (code = %d)\n", ret);
        goto fail;
    }

    if (mppframe)
    {
        if (mpp_frame_get_info_change(mppframe))
        {
            AVHWFramesContext *hwframes;

            av_log(avctx, AV_LOG_INFO, "Decoder noticed an info change (%dx%d), format=%d\n",
                   (int)mpp_frame_get_width(mppframe), (int)mpp_frame_get_height(mppframe),
                   (int)mpp_frame_get_fmt(mppframe));

            avctx->width = mpp_frame_get_width(mppframe);
            avctx->height = mpp_frame_get_height(mppframe);

            decoder->mpi->control(decoder->ctx, MPP_DEC_SET_INFO_CHANGE_READY, NULL);

            av_buffer_unref(&decoder->frames_ref);

            decoder->frames_ref = av_hwframe_ctx_alloc(decoder->device_ref);
            if (!decoder->frames_ref)
            {
                ret = AVERROR(ENOMEM);
                goto fail;
            }

            mppformat = mpp_frame_get_fmt(mppframe);
            drmformat = rkmpp_get_frameformat(mppformat);

            hwframes = (AVHWFramesContext *)decoder->frames_ref->data;
            hwframes->format = AV_PIX_FMT_DRM_PRIME;
            hwframes->sw_format = drmformat == DRM_FORMAT_NV12 ? AV_PIX_FMT_NV12 : AV_PIX_FMT_NONE;
            hwframes->width = avctx->width;
            hwframes->height = avctx->height;
            ret = av_hwframe_ctx_init(decoder->frames_ref);
            if (ret < 0)
                goto fail;

            ret = AVERROR(EAGAIN);
            goto fail;
        }
        else if (mpp_frame_get_eos(mppframe))
        {
            av_log(avctx, AV_LOG_DEBUG, "Received a EOS frame.\n");
            decoder->eos_reached = 1;
            ret = AVERROR_EOF;
            goto fail;
        }
        else if (mpp_frame_get_discard(mppframe))
        {
            av_log(avctx, AV_LOG_DEBUG, "Received a discard frame.\n");
            ret = AVERROR(EAGAIN);
            goto fail;
        }
        else if (mpp_frame_get_errinfo(mppframe))
        {
            av_log(avctx, AV_LOG_ERROR, "Received a errinfo frame.\n");
            ret = AVERROR_UNKNOWN;
            goto fail;
        }

        av_log(avctx, AV_LOG_DEBUG, "Received a frame.\n");

        frame->format = AV_PIX_FMT_DRM_PRIME;
        frame->width = mpp_frame_get_width(mppframe);
        frame->height = mpp_frame_get_height(mppframe);
        frame->pts = mpp_frame_get_pts(mppframe);
        frame->color_range = mpp_frame_get_color_range(mppframe);
        frame->color_primaries = mpp_frame_get_color_primaries(mppframe);
        frame->color_trc = mpp_frame_get_color_trc(mppframe);
        frame->colorspace = mpp_frame_get_colorspace(mppframe);

        mode = mpp_frame_get_mode(mppframe);
        if ((mode & MPP_FRAME_FLAG_FIELD_ORDER_MASK) == MPP_FRAME_FLAG_DEINTERLACED)
            frame->flags |= AV_FRAME_FLAG_INTERLACED;
        if ((mode & MPP_FRAME_FLAG_FIELD_ORDER_MASK) == MPP_FRAME_FLAG_TOP_FIRST)
            frame->flags |= AV_FRAME_FLAG_TOP_FIELD_FIRST;

        mppformat = mpp_frame_get_fmt(mppframe);
        drmformat = rkmpp_get_frameformat(mppformat);

        buffer = mpp_frame_get_buffer(mppframe);
        if (buffer)
        {
            desc = av_mallocz(sizeof(AVDRMFrameDescriptor));
            if (!desc)
            {
                ret = AVERROR(ENOMEM);
                goto fail;
            }

            desc->nb_objects = 1;
            desc->objects[0].fd = mpp_buffer_get_fd(buffer);
            desc->objects[0].size = mpp_buffer_get_size(buffer);

            desc->nb_layers = 1;
            layer = &desc->layers[0];
            layer->format = drmformat;
            layer->nb_planes = 2;

            layer->planes[0].object_index = 0;
            layer->planes[0].offset = 0;
            layer->planes[0].pitch = mpp_frame_get_hor_stride(mppframe);

            layer->planes[1].object_index = 0;
            layer->planes[1].offset = layer->planes[0].pitch * mpp_frame_get_ver_stride(mppframe);
            layer->planes[1].pitch = layer->planes[0].pitch;

            framecontextref = av_buffer_allocz(sizeof(*framecontext));
            if (!framecontextref)
            {
                ret = AVERROR(ENOMEM);
                goto fail;
            }

            framecontext = (RKMPPFrameContext *)framecontextref->data;
            framecontext->decoder_ref = av_buffer_ref(rk_context->decoder_ref);
            framecontext->frame = mppframe;

            frame->data[0] = (uint8_t *)desc;
            frame->buf[0] = av_buffer_create((uint8_t *)desc, sizeof(*desc), rkmpp_release_frame,
                                             framecontextref, AV_BUFFER_FLAG_READONLY);

            if (!frame->buf[0])
            {
                ret = AVERROR(ENOMEM);
                goto fail;
            }

            frame->hw_frames_ctx = av_buffer_ref(decoder->frames_ref);
            if (!frame->hw_frames_ctx)
            {
                ret = AVERROR(ENOMEM);
                goto fail;
            }

            return 0;
        }
        else
        {
            av_log(avctx, AV_LOG_ERROR, "Failed to retrieve the frame buffer, frame is dropped (code = %d)\n", ret);
            mpp_frame_deinit(&mppframe);
        }
    }
    else if (decoder->eos_reached)
    {
        return AVERROR_EOF;
    }
    else if (ret == MPP_ERR_TIMEOUT)
    {
        av_log(avctx, AV_LOG_DEBUG, "Timeout when trying to get a frame from MPP\n");
    }

    return AVERROR(EAGAIN);

fail:
    if (mppframe)
        mpp_frame_deinit(&mppframe);

    if (framecontext)
        av_buffer_unref(&framecontext->decoder_ref);

    if (framecontextref)
        av_buffer_unref(&framecontextref);

    if (desc)
        av_free(desc);

    return ret;
}