        }

        if (sTarget.TrimPrefix(m_pUser->GetStatusPrefix())) {
            EchoMessage(Message);

            if (sTarget.Equals("status")) {
