internal sealed class LzwDecoder : IDisposable
{
       private const int MaxStackSize = 4096;

     private const int MaximumLzwBits = 12;

       private const int NullCode = -1;

     private readonly BufferedReadStream stream;

       private readonly IMemoryOwner<int> prefix;

      private readonly IMemoryOwner<int> suffix;

      private readonly IMemoryOwner<int> pixelStack;

       public LzwDecoder(MemoryAllocator memoryAllocator, BufferedReadStream stream)
    {
        this.stream = stream ?? throw new ArgumentNullException(nameof(stream));

        this.prefix = memoryAllocator.Allocate<int>(MaxStackSize, AllocationOptions.Clean);
        this.suffix = memoryAllocator.Allocate<int>(MaxStackSize, AllocationOptions.Clean);
        this.pixelStack = memoryAllocator.Allocate<int>(MaxStackSize + 1, AllocationOptions.Clean);
    }

       public void DecodePixels(int minCodeSize, Buffer2D<byte> pixels)
    {
              int clearCode = 1 << minCodeSize;

              if (minCodeSize < 2 || minCodeSize > MaximumLzwBits || clearCode > MaxStackSize)
        {
                      return;
        }

                int width = pixels.Width;
        int height = pixels.Height;
        int length = width * height;

        int codeSize = minCodeSize + 1;

               int endCode = clearCode + 1;
        int availableCode = clearCode + 2;

              int code;
        int oldCode = NullCode;
        int codeMask = (1 << codeSize) - 1;
        int bits = 0;

        int top = 0;
        int count = 0;
        int bi = 0;
        int xyz = 0;

        int data = 0;
        int first = 0;

        ref int prefixRef = ref MemoryMarshal.GetReference(this.prefix.GetSpan());
        ref int suffixRef = ref MemoryMarshal.GetReference(this.suffix.GetSpan());
        ref int pixelStackRef = ref MemoryMarshal.GetReference(this.pixelStack.GetSpan());

        for (code = 0; code < clearCode; code++)
        {
            Unsafe.Add(ref suffixRef, (uint)code) = (byte)code;
        }

        Span<byte> buffer = stackalloc byte[byte.MaxValue];

        int y = 0;
        int x = 0;
        int rowMax = width;
        ref byte pixelsRowRef = ref MemoryMarshal.GetReference(pixels.DangerousGetRowSpan(y));
        while (xyz < length)
        {
                      if (xyz == rowMax)
            {
                x = 0;
                pixelsRowRef = ref MemoryMarshal.GetReference(pixels.DangerousGetRowSpan(++y));
                rowMax = (y * width) + width;
            }

            if (top == 0)
            {
                if (bits < codeSize)
                {
                                     if (count == 0)
                    {
                                             count = this.ReadBlock(buffer);
                        if (count == 0)
                        {
                            break;
                        }

                        bi = 0;
                    }

                    data += buffer[bi] << bits;

                    bits += 8;
                    bi++;
                    count--;
                    continue;
                }

                             code = data & codeMask;
                data >>= codeSize;
                bits -= codeSize;

                            if (code > availableCode || code == endCode)
                {
                    break;
                }

                if (code == clearCode)
                {
                                       codeSize = minCodeSize + 1;
                    codeMask = (1 << codeSize) - 1;
                    availableCode = clearCode + 2;
                    oldCode = NullCode;
                    continue;
                }

                if (oldCode == NullCode)
                {
                    Unsafe.Add(ref pixelStackRef, (uint)top++) = Unsafe.Add(ref suffixRef, (uint)code);
                    oldCode = code;
                    first = code;
                    continue;
                }

                int inCode = code;
                if (code == availableCode)
                {
                    Unsafe.Add(ref pixelStackRef, (uint)top++) = (byte)first;

                    code = oldCode;
                }

                while (code > clearCode)
                {
                    Unsafe.Add(ref pixelStackRef, (uint)top++) = Unsafe.Add(ref suffixRef, (uint)code);
                    code = Unsafe.Add(ref prefixRef, (uint)code);
                }

                int suffixCode = Unsafe.Add(ref suffixRef, (uint)code);
                first = suffixCode;
                Unsafe.Add(ref pixelStackRef, (uint)top++) = suffixCode;

                             if (availableCode < MaxStackSize)
                {
                    Unsafe.Add(ref prefixRef, (uint)availableCode) = oldCode;
                    Unsafe.Add(ref suffixRef, (uint)availableCode) = first;
                    availableCode++;
                    if (availableCode == codeMask + 1 && availableCode < MaxStackSize)
                    {
                        codeSize++;
                        codeMask = (1 << codeSize) - 1;
                    }
                }

                oldCode = inCode;
            }

                        top--;

                      xyz++;
            Unsafe.Add(ref pixelsRowRef, (uint)x++) = (byte)Unsafe.Add(ref pixelStackRef, (uint)top);
        }
    }

      public void SkipIndices(int minCodeSize, int length)
    {
             int clearCode = 1 << minCodeSize;

               if (minCodeSize < 2 || minCodeSize > MaximumLzwBits || clearCode > MaxStackSize)
        {
                      return;
        }

        int codeSize = minCodeSize + 1;

            int endCode = clearCode + 1;

                int availableCode = clearCode + 2;

               int code;
        int oldCode = NullCode;
        int codeMask = (1 << codeSize) - 1;
        int bits = 0;

        int top = 0;
        int count = 0;
        int bi = 0;
        int xyz = 0;

        int data = 0;
        int first = 0;

        ref int prefixRef = ref MemoryMarshal.GetReference(this.prefix.GetSpan());
        ref int suffixRef = ref MemoryMarshal.GetReference(this.suffix.GetSpan());
        ref int pixelStackRef = ref MemoryMarshal.GetReference(this.pixelStack.GetSpan());

        for (code = 0; code < clearCode; code++)
        {
            Unsafe.Add(ref suffixRef, (uint)code) = (byte)code;
        }

        Span<byte> buffer = stackalloc byte[byte.MaxValue];
        while (xyz < length)
        {
            if (top == 0)
            {
                if (bits < codeSize)
                {
                                        if (count == 0)
                    {
                                                count = this.ReadBlock(buffer);
                        if (count == 0)
                        {
                            break;
                        }

                        bi = 0;
                    }

                    data += buffer[bi] << bits;

                    bits += 8;
                    bi++;
                    count--;
                    continue;
                }

                               code = data & codeMask;
                data >>= codeSize;
                bits -= codeSize;

                               if (code > availableCode || code == endCode)
                {
                    break;
                }

                if (code == clearCode)
                {
                                        codeSize = minCodeSize + 1;
                    codeMask = (1 << codeSize) - 1;
                    availableCode = clearCode + 2;
                    oldCode = NullCode;
                    continue;
                }

                if (oldCode == NullCode)
                {
                    Unsafe.Add(ref pixelStackRef, (uint)top++) = Unsafe.Add(ref suffixRef, (uint)code);
                    oldCode = code;
                    first = code;
                    continue;
                }

                int inCode = code;
                if (code == availableCode)
                {
                    Unsafe.Add(ref pixelStackRef, (uint)top++) = (byte)first;

                    code = oldCode;
                }

                while (code > clearCode)
                {
                    Unsafe.Add(ref pixelStackRef, (uint)top++) = Unsafe.Add(ref suffixRef, (uint)code);
                    code = Unsafe.Add(ref prefixRef, (uint)code);
                }

                int suffixCode = Unsafe.Add(ref suffixRef, (uint)code);
                first = suffixCode;
                Unsafe.Add(ref pixelStackRef, (uint)top++) = suffixCode;

                                if (availableCode < MaxStackSize)
                {
                    Unsafe.Add(ref prefixRef, (uint)availableCode) = oldCode;
                    Unsafe.Add(ref suffixRef, (uint)availableCode) = first;
                    availableCode++;
                    if (availableCode == codeMask + 1 && availableCode < MaxStackSize)
                    {
                        codeSize++;
                        codeMask = (1 << codeSize) - 1;
                    }
                }

                oldCode = inCode;
            }

                     top--;

                        xyz++;
        }
    }

       [MethodImpl(MethodImplOptions.AggressiveInlining)]
    private int ReadBlock(Span<byte> buffer)
    {
        int bufferSize = this.stream.ReadByte();

        if (bufferSize < 1)
        {
            return 0;
        }

        int count = this.stream.Read(buffer, 0, bufferSize);

        return count != bufferSize ? 0 : bufferSize;
    }

        public void Dispose()
    {
        this.prefix.Dispose();
        this.suffix.Dispose();
        this.pixelStack.Dispose();
    }
}







    public void Issue2012BadMinCode<TPixel>(TestImageProvider<TPixel> provider)
        where TPixel : unmanaged, IPixel<TPixel>
    {
        using Image<TPixel> image = provider.GetImage();
        image.DebugSave(provider);
        image.CompareToReferenceOutput(provider);
    }





 