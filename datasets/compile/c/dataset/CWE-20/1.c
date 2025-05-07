
						if (im->trueColor) {
							if (!gdGetInt (&im->tpixels[y][x], in)) {
								gd_error("gd2: EOF while reading\n");
								gdImageDestroy(im);
								return NULL;
							}
						} else {
							int ch;
							if (!gdGetByte (&ch, in)) {
								gd_error("gd2: EOF while reading\n");
								gdImageDestroy(im);
								return NULL;
							}
							im->pixels[y][x] = ch;
						}
					}
				} else {
