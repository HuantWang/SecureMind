	int i;
	int restoreAlphaBleding;

	if (border < 0 || color < 0) {
		/* Refuse to fill to a non-solid border */
		return;
	}

	if (!im->trueColor) {
		if ((color > (im->colorsTotal - 1)) || (border > (im->colorsTotal - 1))) {
			return;
