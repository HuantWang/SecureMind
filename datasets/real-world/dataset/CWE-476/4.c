const char *osdp_reply_name(int reply_id)
{
	const char *name;
	static const char * const names[] = {
		[REPLY_ACK       - REPLY_ACK] = "ACK",
		[REPLY_NAK       - REPLY_ACK] = "NAK",
		[REPLY_PDID      - REPLY_ACK] = "PDID",
		[REPLY_PDCAP     - REPLY_ACK] = "PDCAP",
		[REPLY_LSTATR    - REPLY_ACK] = "LSTATR",
		[REPLY_ISTATR    - REPLY_ACK] = "ISTATR",
		[REPLY_OSTATR    - REPLY_ACK] = "OSTATR",
		[REPLY_RSTATR    - REPLY_ACK] = "RSTATR",
		[REPLY_RAW       - REPLY_ACK] = "RAW",
		[REPLY_FMT       - REPLY_ACK] = "FMT",
		[REPLY_KEYPPAD   - REPLY_ACK] = "KEYPPAD",
		[REPLY_COM       - REPLY_ACK] = "COM",
		[REPLY_BIOREADR  - REPLY_ACK] = "BIOREADR",
		[REPLY_BIOMATCHR - REPLY_ACK] = "BIOMATCHR",
		[REPLY_CCRYPT    - REPLY_ACK] = "CCRYPT",
		[REPLY_RMAC_I    - REPLY_ACK] = "RMAC_I",
		[REPLY_FTSTAT    - REPLY_ACK] = "FTSTAT",
		[REPLY_MFGREP    - REPLY_ACK] = "MFGREP",
		[REPLY_BUSY      - REPLY_ACK] = "BUSY",
		[REPLY_PIVDATAR  - REPLY_ACK] = "PIVDATA",
		[REPLY_CRAUTHR   - REPLY_ACK] = "CRAUTH",
		[REPLY_MFGSTATR  - REPLY_ACK] = "MFGSTATR",
		[REPLY_MFGERRR   - REPLY_ACK] = "MFGERR",
		[REPLY_XRD       - REPLY_ACK] = "XRD",
	};

	if (reply_id < REPLY_ACK || reply_id > REPLY_XRD) {
		return "INVALID";
	}
	name = names[reply_id - REPLY_ACK];
	if (name[0] == '\0') {
		return "UNKNOWN";
	}
	return name;
}
