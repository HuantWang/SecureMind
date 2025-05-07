	GD2_DBG (printf ("%d Chunks vertically\n", *ncy));

	if (gd2_compressed (*fmt)) {
		if (*ncx <= 0 || *ncy <= 0 || *ncx > INT_MAX / *ncy) {
			GD2_DBG(printf ("Illegal chunk counts: %d * %d\n", *ncx, *ncy));
			goto fail1;
