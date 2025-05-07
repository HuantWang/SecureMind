public int decompress(
    final Object inputBase,
    final long inputAddress,
    final long inputLimit,
    final Object outputBase,
    final long outputAddress,
    final long outputLimit)
{
if (outputAddress == outputLimit) {
    return 0;
}

long input = inputAddress;
long output = outputAddress;

while (input < inputLimit) {
    reset();
    long outputStart = output;
    input += verifyMagic(inputBase, input, inputLimit);

    FrameHeader frameHeader = readFrameHeader(inputBase, input, inputLimit);
    input += frameHeader.headerSize;

    boolean lastBlock;
    do {
        verify(input + SIZE_OF_BLOCK_HEADER <= inputLimit, input, "Not enough input bytes");

        int header = get24BitLittleEndian(inputBase, input);
        input += SIZE_OF_BLOCK_HEADER;

        lastBlock = (header & 1) != 0;
        int blockType = (header >>> 1) & 0b11;
        int blockSize = (header >>> 3) & 0x1F_FFFF;

        int decodedSize;
        switch (blockType) {
            case RAW_BLOCK:
                verify(inputAddress + blockSize <= inputLimit, input, "Not enough input bytes");
                decodedSize = decodeRawBlock(inputBase, input, blockSize, outputBase, output, outputLimit);
                input += blockSize;
                break;
            case RLE_BLOCK:
                verify(inputAddress + 1 <= inputLimit, input, "Not enough input bytes");
                decodedSize = decodeRleBlock(blockSize, inputBase, input, outputBase, output, outputLimit);
                input += 1;
                break;
            case COMPRESSED_BLOCK:
                verify(inputAddress + blockSize <= inputLimit, input, "Not enough input bytes");
                decodedSize = decodeCompressedBlock(inputBase, input, blockSize, outputBase, output, outputLimit, frameHeader.windowSize, outputAddress);
                input += blockSize;
                break;
            default:
                throw fail(input, "Invalid block type");
        }

        output += decodedSize;
    }
    while (!lastBlock);

    if (frameHeader.hasChecksum) {
        int decodedFrameSize = (int) (output - outputStart);

        long hash = XxHash64.hash(0, outputBase, outputStart, decodedFrameSize);

        verify(input + SIZE_OF_INT <= inputLimit, input, "Not enough input bytes");
        int checksum = UNSAFE.getInt(inputBase, input);
        if (checksum != (int) hash) {
            throw new MalformedInputException(input, format("Bad checksum. Expected: %s, actual: %s", Integer.toHexString(checksum), Integer.toHexString((int) hash)));
        }

        input += SIZE_OF_INT;
    }
}

return (int) (output - outputAddress);
}

@Test
public void testBadHuffmanData()
        throws IOException
{
    ByteArrayOutputStream buffer = new ByteArrayOutputStream();
    buffer.write(new byte[] {
            (byte) 0b0010_1000,
            (byte) 0b1011_0101,
            (byte) 0b0010_1111,
            (byte) 0b1111_1101,
    });
    buffer.write(0);
    buffer.write(0);
    buffer.write(new byte[] {
            (byte) 0b1111_0100,
            (byte) 0b0000_0000,
            (byte) 0b0000_0000,
    });
    buffer.write(new byte[] {
            0b0000_1010,
            0b0000_0000,
            0b0011_1100,
            0b0000_0000,
    });
    buffer.write(128);
    buffer.write(0b0001_0000);
    buffer.write(new byte[] {(byte) 255, (byte) 255});
    buffer.write(new byte[] {(byte) 255, (byte) 255});
    buffer.write(new byte[] {(byte) 255, (byte) 255});

    buffer.write(new byte[10]);

    byte[] data = buffer.toByteArray();

    assertThatThrownBy(() -> new ZstdDecompressor().decompress(data, 0, data.length, new byte[10], 0, 10))
            .isInstanceOf(MalformedInputException.class)
            .hasMessageStartingWith("Input is corrupted");
}