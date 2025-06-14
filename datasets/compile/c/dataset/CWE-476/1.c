    CMessage EchoedMessage = Message;
    for (CClient* pClient : GetClients()) {
        if (pClient->HasEchoMessage() ||
            (pClient != this && ((m_pNetwork && m_pNetwork->IsChan(Message.GetParam(0))) ||
                                 pClient->HasSelfMessage()))) {
            EchoedMessage.SetNick(GetNickMask());
            pClient->PutClient(EchoedMessage);
