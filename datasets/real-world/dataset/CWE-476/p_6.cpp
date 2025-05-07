CHIP_ERROR TCPBase::ProcessReceivedBuffer(Inet::TCPEndPoint * endPoint, const PeerAddress & peerAddress,
                                          System::PacketBufferHandle && buffer)
{
    ActiveTCPConnectionState * state = FindActiveConnection(endPoint);
    VerifyOrReturnError(state != nullptr, CHIP_ERROR_INTERNAL);
    state->mReceived.AddToEnd(std::move(buffer));

    while (!state->mReceived.IsNull())
    {
        uint8_t messageSizeBuf[kPacketSizeBytes];
        CHIP_ERROR err = state->mReceived->Read(messageSizeBuf);
        if (err == CHIP_ERROR_BUFFER_TOO_SMALL)
        {
                       return CHIP_NO_ERROR;
        }
        if (err != CHIP_NO_ERROR)
        {
            return err;
        }
        uint32_t messageSize = LittleEndian::Get32(messageSizeBuf);
        if (messageSize >= kMaxTCPMessageSize)
        {
                       ChipLogError(Inet, "Received TCP message of length %" PRIu32 " exceeds limit.", messageSize);
            CloseConnectionInternal(state, CHIP_ERROR_MESSAGE_TOO_LONG, SuppressCallback::No);

            return CHIP_ERROR_MESSAGE_TOO_LONG;
        }
               if (messageSize > (state->mReceived->TotalLength() - kPacketSizeBytes))
        {
                     return CHIP_NO_ERROR;
        }

        state->mReceived.Consume(kPacketSizeBytes);

        if (messageSize == 0)
        {
                        return CHIP_NO_ERROR;
        }

        ReturnErrorOnFailure(ProcessSingleMessage(peerAddress, state, messageSize));
    }

    return CHIP_NO_ERROR;
}







TEST_F(TestTCP, CheckProcessReceivedBuffer)
{
    TCPImpl tcp;

    IPAddress addr;
    IPAddress::FromString("::1", addr);

    MockTransportMgrDelegate gMockTransportMgrDelegate(mIOContext);
    gMockTransportMgrDelegate.InitializeMessageTest(tcp, addr);

       gMockTransportMgrDelegate.SingleMessageTest(tcp, addr);

    Transport::PeerAddress lPeerAddress = Transport::PeerAddress::TCP(addr, gChipTCPPort);
    void * state                        = TestAccess::FindActiveConnection(tcp, lPeerAddress);
    ASSERT_NE(state, nullptr);
    TCPEndPoint * lEndPoint = TestAccess::GetEndpoint(state);
    ASSERT_NE(lEndPoint, nullptr);

    CHIP_ERROR err = CHIP_NO_ERROR;
    TestData testData[2];
    gMockTransportMgrDelegate.SetCallback(TestDataCallbackCheck, testData);

     System::PacketBufferHandle buf = System::PacketBufferHandle::NewWithData(messageSize_TEST, 4);
    ASSERT_NE(&buf, nullptr);
    err = TestAccess::ProcessReceivedBuffer(tcp, lEndPoint, lPeerAddress, std::move(buf));
    EXPECT_EQ(err, CHIP_NO_ERROR);

        gMockTransportMgrDelegate.mReceiveHandlerCallCount = 0;
    EXPECT_TRUE(testData[0].Init((const uint32_t[]){ 111, 0 }));
    err = TestAccess::ProcessReceivedBuffer(tcp, lEndPoint, lPeerAddress, std::move(testData[0].mHandle));
    EXPECT_EQ(err, CHIP_NO_ERROR);
    EXPECT_EQ(gMockTransportMgrDelegate.mReceiveHandlerCallCount, 1);

       gMockTransportMgrDelegate.mReceiveHandlerCallCount = 0;
    EXPECT_TRUE(testData[0].Init((const uint32_t[]){ 1, 122, 123, 0 }));
    err = TestAccess::ProcessReceivedBuffer(tcp, lEndPoint, lPeerAddress, std::move(testData[0].mHandle));
    EXPECT_EQ(err, CHIP_NO_ERROR);
    EXPECT_EQ(gMockTransportMgrDelegate.mReceiveHandlerCallCount, 1);

        gMockTransportMgrDelegate.mReceiveHandlerCallCount = 0;
    EXPECT_TRUE(testData[0].Init((const uint32_t[]){ 131, 0 }));
    EXPECT_TRUE(testData[1].Init((const uint32_t[]){ 132, 0 }));
    testData[0].mHandle->AddToEnd(std::move(testData[1].mHandle));
    err = TestAccess::ProcessReceivedBuffer(tcp, lEndPoint, lPeerAddress, std::move(testData[0].mHandle));
    EXPECT_EQ(err, CHIP_NO_ERROR);
    EXPECT_EQ(gMockTransportMgrDelegate.mReceiveHandlerCallCount, 2);

       gMockTransportMgrDelegate.mReceiveHandlerCallCount = 0;
    EXPECT_TRUE(testData[0].Init((const uint32_t[]){ 141, 142, 0 }));
    EXPECT_TRUE(testData[1].Init((const uint32_t[]){ 143, 144, 0 }));
    testData[0].mHandle->AddToEnd(std::move(testData[1].mHandle));
    err = TestAccess::ProcessReceivedBuffer(tcp, lEndPoint, lPeerAddress, std::move(testData[0].mHandle));
    EXPECT_EQ(err, CHIP_NO_ERROR);
    EXPECT_EQ(gMockTransportMgrDelegate.mReceiveHandlerCallCount, 2);

            gMockTransportMgrDelegate.mReceiveHandlerCallCount = 0;
    EXPECT_TRUE(testData[0].Init((const uint32_t[]){ System::PacketBuffer::kMaxSizeWithoutReserve + 1, 0 }));
    err = TestAccess::ProcessReceivedBuffer(tcp, lEndPoint, lPeerAddress, std::move(testData[0].mHandle));
    EXPECT_EQ(err, CHIP_NO_ERROR);
    EXPECT_EQ(gMockTransportMgrDelegate.mReceiveHandlerCallCount, 1);

        gMockTransportMgrDelegate.mReceiveHandlerCallCount = 0;
    gMockTransportMgrDelegate.SetCallback(TestDataCallbackCheck, &testData[1]);
    EXPECT_TRUE(testData[0].Init((const uint32_t[]){ 51, CHIP_SYSTEM_CONFIG_MAX_LARGE_BUFFER_SIZE_BYTES, 0 }));
        System::PacketBufferHandle head = testData[0].mHandle.PopHead();
    err                             = TestAccess::ProcessReceivedBuffer(tcp, lEndPoint, lPeerAddress, std::move(head));
    EXPECT_EQ(err, CHIP_ERROR_MESSAGE_TOO_LONG);
    EXPECT_EQ(gMockTransportMgrDelegate.mReceiveHandlerCallCount, 0);

      EXPECT_EQ(TestAccess::GetEndpoint(state), nullptr);
}
