private void InitializeImage<TPixel>(ImageMetadata metadata, out Image<TPixel> image)
            where TPixel : unmanaged, IPixel<TPixel>
        {
             image = Image.CreateUninitialized<TPixel>(
                this.Configuration,
                this.header.Width,
                this.header.Height,
                metadata);

            this.bytesPerPixel = this.CalculateBytesPerPixel();
            this.bytesPerScanline = this.CalculateScanlineLength(this.header.Width) + 1;
            this.bytesPerSample = 1;
            if (this.header.BitDepth >= 8)
            {
                this.bytesPerSample = this.header.BitDepth / 8;
            }

            this.previousScanline?.Dispose();
            this.scanline?.Dispose();
            this.previousScanline = this.memoryAllocator.Allocate<byte>(this.bytesPerScanline, AllocationOptions.Clean);
            this.scanline = this.Configuration.MemoryAllocator.Allocate<byte>(this.bytesPerScanline, AllocationOptions.Clean);
        }