		}
	}

	dst->interlace   = src->interlace;

	dst->alphaBlendingFlag = src->alphaBlendingFlag;
	dst->saveAlphaFlag     = src->saveAlphaFlag;
	dst->AA                = src->AA;
	dst->AA_color          = src->AA_color;
	dst->AA_dont_blend     = src->AA_dont_blend;

	dst->cx1 = src->cx1;
	dst->cy1 = src->cy1;
	dst->cx2 = src->cx2;
	dst->cy2 = src->cy2;

	dst->res_x = src->res_x;
	dst->res_y = src->res_y;

	dst->paletteQuantizationMethod     = src->paletteQuantizationMethod;
	dst->paletteQuantizationSpeed      = src->paletteQuantizationSpeed;
	dst->paletteQuantizationMinQuality = src->paletteQuantizationMinQuality;
	dst->paletteQuantizationMinQuality = src->paletteQuantizationMinQuality;

	dst->interpolation_id = src->interpolation_id;
	dst->interpolation    = src->interpolation;

	if (src->brush) {
		dst->brush = gdImageClone(src->brush);
	}

	if (src->tile) {
		dst->tile = gdImageClone(src->tile);
	}

	if (src->style) {
		gdImageSetStyle(dst, src->style, src->styleLength);
		dst->stylePos = src->stylePos;
	}

	for (i = 0; i < gdMaxColors; i++) {
		dst->brushColorMap[i] = src->brushColorMap[i];
		dst->tileColorMap[i] = src->tileColorMap[i];
	}

	if (src->polyAllocated > 0) {
		dst->polyAllocated = src->polyAllocated;
		for (i = 0; i < src->polyAllocated; i++) {
