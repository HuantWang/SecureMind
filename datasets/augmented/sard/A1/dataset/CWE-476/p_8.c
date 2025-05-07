void dissect_nds_request(tvbuff_t *tvb, packet_info *pinfo,
                         guint32 nw_connection, guint8 sequence,
                         guint16 type, proto_tree *ncp_tree)
{
    guint8 func, subfunc = 0;
    ncp_req_hash_value *request_value = NULL;
    ncp_req_eid_hash_value *request_eid_value = NULL;
    const ncp_record *ncp_rec = NULL;
    conversation_t *conversation;
    ptvcursor_t *ptvc = NULL;
    proto_tree *temp_tree = NULL;
    gboolean run_req_cond = FALSE;
    gboolean run_info_str = FALSE;
    guint8 nds_verb = 0;
    const char *verb_string = "";
    guint32 nds_frag = 0;
    gboolean added_arrow;
    nds_val pvalues[9], prot_flags[1];
    guint8 nds_version = 0;
    guint32 foffset = 0;
    char global_object_name[256];
    guint32 global_eid = 0;
    gboolean resolve_eid = FALSE;
    guint32 global_flags = 0, nds_prot_flags = 0;
    int vulnerable_var;

    for (vulnerable_var = 0; vulnerable_var < 9; vulnerable_var++)
    {
        pvalues[vulnerable_var].vtype = 0;
        pvalues[vulnerable_var].vvalue = 0;
        pvalues[vulnerable_var].vlength = 0;
        pvalues[vulnerable_var].voffset = 0;
        pvalues[vulnerable_var].hfname = 0;
        pvalues[vulnerable_var].vdesc = "";
        pvalues[vulnerable_var].vstring = NULL;
        pvalues[vulnerable_var].mvtype = 0;
        pvalues[vulnerable_var].vflags = 0;
    }

    global_object_name[0] = '\0';

    func = tvb_get_guint8(tvb, 6);
    subfunc = tvb_get_guint8(tvb, 7);

    ncp_rec = ncp_record_find(func, subfunc);

    nds_frag = tvb_get_letohl(tvb, 8);

    if (nds_frag == 0xffffffff)
    {

        nds_verb = tvb_get_guint8(tvb, 24);
        if (nds_verb == 0xfe)
        {
            nds_version = nds_verb;
            nds_verb = tvb_get_guint8(tvb, 32);
            foffset = 36;
        }
        else
        {
            nds_version = 0;
            foffset = 28;
        }
        if (type == NCP_SERVICE_REQUEST)
        {
            proto_tree_add_item(ncp_tree, hf_nds_buffer_size, tvb, foffset,
                                4, TRUE);
        }
        foffset = foffset + 4;
        verb_string = val_to_str(nds_verb, ncp_nds_verb_vals,
                                 "Continuation Fragment");
        switch (nds_verb)
        {

        case 0x01:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].hfname = hf_nds_ver;
            pvalues[0].voffset = foffset;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[1].vtype = VTYPE_BITFIELD;
            pvalues[1].vdesc = "Flags:";
            pvalues[1].vlength = 2;
            pvalues[1].hfname = hf_nds_nflags;
            pvalues[1].voffset = foffset;
            pvalues[1].bit1 = "Entry ID";
            pvalues[1].bit1hfname = hf_bit1nflags;
            pvalues[1].bit2 = "Readable";
            pvalues[1].bit2hfname = hf_bit2nflags;
            pvalues[1].bit3 = "Writeable";
            pvalues[1].bit3hfname = hf_bit3nflags;
            pvalues[1].bit4 = "Master";
            pvalues[1].bit4hfname = hf_bit4nflags;
            pvalues[1].bit5 = "Create ID";
            pvalues[1].bit5hfname = hf_bit5nflags;
            pvalues[1].bit6 = "Walk Tree";
            pvalues[1].bit6hfname = hf_bit6nflags;
            pvalues[1].bit7 = "Dereference Alias";
            pvalues[1].bit7hfname = hf_bit7nflags;
            pvalues[1].bit8 = "Not Defined";
            pvalues[1].bit8hfname = hf_bit8nflags;
            pvalues[1].bit9 = "Not Defined";
            pvalues[1].bit9hfname = hf_bit9nflags;
            pvalues[1].bit10 = "Not Defined";
            pvalues[1].bit10hfname = hf_bit10nflags;
            pvalues[1].bit11 = "Not Defined";
            pvalues[1].bit11hfname = hf_bit11nflags;
            pvalues[1].bit12 = "Not Defined";
            pvalues[1].bit12hfname = hf_bit12nflags;
            pvalues[1].bit13 = "Not Defined";
            pvalues[1].bit13hfname = hf_bit13nflags;
            pvalues[1].bit14 = "Prefer Referrals";
            pvalues[1].bit14hfname = hf_bit14nflags;
            pvalues[1].bit15 = "Prefer Only Referrals";
            pvalues[1].bit15hfname = hf_bit15nflags;
            pvalues[1].bit16 = "Not Defined";
            pvalues[1].bit16hfname = hf_bit16nflags;
            foffset = foffset + 4;
            if (pvalues[0].vvalue == 0 || pvalues[0].vvalue == 1)
            {
                pvalues[2].vtype = VTYPE_UINT32;
                pvalues[2].vdesc = "Scope: %u";
                pvalues[2].vlength = 4;
                pvalues[2].voffset = foffset;
                pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[2].hfname = hf_nds_scope;
                foffset = foffset + pvalues[2].vlength;
                pvalues[3].vtype = VTYPE_STRING;
                pvalues[3].vdesc = "Name: %s";
                pvalues[3].mvtype = MVTYPE_ATTR_REQUEST;
                pvalues[3].vvalue = 0;
                pvalues[3].vlength = 256;
                pvalues[3].vlength = tvb_get_letohl(tvb, foffset);
                if (pvalues[3].vlength == 0x00 || !tvb_bytes_exist(tvb, foffset, pvalues[3].vlength))
                {
                    pvalues[3].vtype = VTYPE_NONE;
                    break;
                }
                pvalues[3].voffset = foffset + 4;
                foffset = foffset + 4;
                pvalues[3].vstring = get_string(tvb, pvalues[3].voffset, pvalues[3].vlength);
                g_strlcpy(global_object_name, pvalues[3].vstring, 256);
                pvalues[3].hfname = hf_nds_name;
                foffset = foffset + pvalues[3].vlength;
                foffset += align_4(tvb, foffset);
                pvalues[4].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[4].vtype = VTYPE_MULTIVALUE_UINT32;
                pvalues[4].vdesc = "Communications Transports: %u";
                pvalues[4].vlength = 4;
                pvalues[4].hfname = hf_nds_comm_trans;
                pvalues[4].voffset = foffset;
                pvalues[4].mvtype = MVTYPE_ADDR_REFERRAL_REQUEST;
                foffset = foffset + (pvalues[4].vvalue * 4) + 4;
                pvalues[5].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[5].vtype = VTYPE_MULTIVALUE_UINT32;
                pvalues[5].vdesc = "Tree Walker Transport Type: %u";
                pvalues[5].vlength = 4;
                pvalues[5].mvtype = MVTYPE_ADDR_REFERRAL_REQUEST;
                pvalues[5].hfname = hf_nds_tree_trans;
                pvalues[5].voffset = foffset;
            }
            else
            {
                pvalues[2].vtype = VTYPE_UINT32;
                pvalues[2].vdesc = "Minimum DS Version: %u";
                pvalues[2].vlength = 4;
                pvalues[2].voffset = foffset;
                pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[2].hfname = hf_min_nds_ver;
                foffset = foffset + pvalues[2].vlength;
                pvalues[3].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[3].vtype = VTYPE_MULTIVALUE_UINT32;
                pvalues[3].vdesc = "Number of Versions to Include: %u";
                pvalues[3].vlength = 4;
                pvalues[3].mvtype = MVTYPE_ATTR_REQUEST2;
                pvalues[3].voffset = foffset;
                pvalues[3].hfname = hf_nds_ver_include;
                foffset += (pvalues[3].vvalue * 4) + 4;
                pvalues[4].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[4].vtype = VTYPE_MULTIVALUE_UINT32;
                pvalues[4].vdesc = "Number of Versions to Exclude: %u";
                pvalues[4].vlength = 4;
                pvalues[4].mvtype = MVTYPE_ATTR_REQUEST2;
                pvalues[4].hfname = hf_nds_ver_exclude;
                pvalues[4].voffset = foffset;
                foffset += 4;
                pvalues[5].vtype = VTYPE_UINT32;
                pvalues[5].vdesc = "DN Output Type: %u";
                pvalues[5].vlength = 4;
                pvalues[5].voffset = foffset;
                pvalues[5].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[5].hfname = hf_nds_dn_output_type;
                foffset = foffset + pvalues[5].vlength;
                pvalues[6].vtype = VTYPE_UINT32;
                pvalues[6].vdesc = "Nested Output Type: %u";
                pvalues[6].vlength = 4;
                pvalues[6].voffset = foffset;
                pvalues[6].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[6].hfname = hf_nds_nested_output_type;
                foffset = foffset + pvalues[6].vlength;
                pvalues[7].vtype = VTYPE_STRING;
                pvalues[7].vdesc = "Output Delimiter: %s";
                pvalues[7].mvtype = MVTYPE_ATTR_REQUEST;
                pvalues[7].vvalue = 0;
                pvalues[7].vlength = 256;
                pvalues[7].vlength = tvb_get_letohl(tvb, foffset);
                pvalues[7].voffset = foffset + 4;
                foffset = foffset + 4;
                pvalues[7].vstring = get_string(tvb, pvalues[7].voffset, pvalues[7].vlength);
                pvalues[7].hfname = hf_nds_output_delimiter;
                foffset = foffset + pvalues[7].vlength;
                foffset += align_4(tvb, foffset);
                pvalues[8].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[8].vtype = VTYPE_MULTIVALUE_UINT32;
                pvalues[8].vdesc = "Size of Entry Specifier: %u";
                pvalues[8].vlength = 4;
                pvalues[8].mvtype = MVTYPE_PROC_ENTRY_SPECIFIERS;
                pvalues[8].hfname = hf_nds_output_entry_specifier;
                pvalues[8].voffset = foffset;
            }
            break;
        case 0x02:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].voffset = foffset;
            pvalues[0].hfname = hf_nds_ver;
            foffset = foffset + pvalues[0].vlength;
            switch (pvalues[0].vvalue)
            {
            case 0:
                pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[1].vtype = VTYPE_UINT32;
                pvalues[1].vdesc = "Entry ID: 0x%08x";
                pvalues[1].vlength = 4;
                resolve_eid = TRUE;
                global_eid = pvalues[1].vvalue;
                pvalues[1].voffset = foffset;
                pvalues[1].hfname = hf_nds_eid;
                foffset = foffset + pvalues[1].vlength;
                break;
            case 1:
                pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[1].vtype = VTYPE_BITFIELD;
                pvalues[1].vdesc = "Request Flags:";
                pvalues[1].vlength = 2;
                pvalues[1].hfname = hf_nds_rflags;
                pvalues[1].voffset = foffset;
                pvalues[1].bit1 = "Typeless";
                pvalues[1].bit1hfname = hf_bit1rflags;
                pvalues[1].bit2 = "Slashed";
                pvalues[1].bit2hfname = hf_bit2rflags;
                pvalues[1].bit3 = "Dotted";
                pvalues[1].bit3hfname = hf_bit3rflags;
                pvalues[1].bit4 = "Tuned";
                pvalues[1].bit4hfname = hf_bit4rflags;
                pvalues[1].bit5 = "Not Defined";
                pvalues[1].bit5hfname = hf_bit5rflags;
                pvalues[1].bit6 = "Not Defined";
                pvalues[1].bit6hfname = hf_bit6rflags;
                pvalues[1].bit7 = "Not Defined";
                pvalues[1].bit7hfname = hf_bit7rflags;
                pvalues[1].bit8 = "Not Defined";
                pvalues[1].bit8hfname = hf_bit8rflags;
                pvalues[1].bit9 = "Not Defined";
                pvalues[1].bit9hfname = hf_bit9rflags;
                pvalues[1].bit10 = "Not Defined";
                pvalues[1].bit10hfname = hf_bit10rflags;
                pvalues[1].bit11 = "Not Defined";
                pvalues[1].bit11hfname = hf_bit11rflags;
                pvalues[1].bit12 = "Not Defined";
                pvalues[1].bit12hfname = hf_bit12rflags;
                pvalues[1].bit13 = "Not Defined";
                pvalues[1].bit13hfname = hf_bit13rflags;
                pvalues[1].bit14 = "Not Defined";
                pvalues[1].bit14hfname = hf_bit14rflags;
                pvalues[1].bit15 = "Not Defined";
                pvalues[1].bit15hfname = hf_bit15rflags;
                pvalues[1].bit16 = "Not Defined";
                pvalues[1].bit16hfname = hf_bit16rflags;
                if ((pvalues[1].vvalue && 0xf000) == 0xc000)
                {
                    pvalues[2].vtype = VTYPE_STRING;
                    pvalues[2].vdesc = "Name Type: %s";
                    pvalues[2].vstring = "Partial";
                    pvalues[2].mvtype = 0;
                    pvalues[2].vvalue = 0;
                    pvalues[2].vlength = 0;
                    pvalues[2].voffset = 0;
                    pvalues[2].hfname = hf_nds_name_type;
                }
                else
                {
                    pvalues[2].vtype = VTYPE_STRING;
                    pvalues[2].vdesc = "Name Type: %s";
                    pvalues[2].vstring = "Full";
                    pvalues[2].vvalue = 0;
                    pvalues[2].mvtype = 0;
                    pvalues[2].vlength = 0;
                    pvalues[2].voffset = 0;
                    pvalues[2].hfname = hf_nds_name_type;
                }
                foffset = foffset + 4;
                pvalues[3].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[3].vtype = VTYPE_UINT32;
                pvalues[3].vdesc = "Entry ID: 0x%08x";
                pvalues[3].vlength = 4;
                pvalues[3].voffset = foffset;
                resolve_eid = TRUE;
                global_eid = pvalues[3].vvalue;
                pvalues[3].hfname = hf_nds_eid;
                foffset = foffset + pvalues[3].vlength;
                break;
            case 2:
                pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[1].vtype = VTYPE_BITFIELD;
                pvalues[1].vdesc = "Request Flags:";
                pvalues[1].vlength = 2;
                pvalues[1].hfname = hf_nds_rflags;
                pvalues[1].voffset = foffset;
                pvalues[1].bit1 = "Typeless";
                pvalues[1].bit1hfname = hf_bit1rflags;
                pvalues[1].bit2 = "Slashed";
                pvalues[1].bit2hfname = hf_bit2rflags;
                pvalues[1].bit3 = "Dotted";
                pvalues[1].bit3hfname = hf_bit3rflags;
                pvalues[1].bit4 = "Tuned";
                pvalues[1].bit4hfname = hf_bit4rflags;
                pvalues[1].bit5 = "Not Defined";
                pvalues[1].bit5hfname = hf_bit5rflags;
                pvalues[1].bit6 = "Not Defined";
                pvalues[1].bit6hfname = hf_bit6rflags;
                pvalues[1].bit7 = "Not Defined";
                pvalues[1].bit7hfname = hf_bit7rflags;
                pvalues[1].bit8 = "Not Defined";
                pvalues[1].bit8hfname = hf_bit8rflags;
                pvalues[1].bit9 = "Not Defined";
                pvalues[1].bit9hfname = hf_bit9rflags;
                pvalues[1].bit10 = "Not Defined";
                pvalues[1].bit10hfname = hf_bit10rflags;
                pvalues[1].bit11 = "Not Defined";
                pvalues[1].bit11hfname = hf_bit11rflags;
                pvalues[1].bit12 = "Not Defined";
                pvalues[1].bit12hfname = hf_bit12rflags;
                pvalues[1].bit13 = "Not Defined";
                pvalues[1].bit13hfname = hf_bit13rflags;
                pvalues[1].bit14 = "Not Defined";
                pvalues[1].bit14hfname = hf_bit14rflags;
                pvalues[1].bit15 = "Not Defined";
                pvalues[1].bit15hfname = hf_bit15rflags;
                pvalues[1].bit16 = "Not Defined";
                pvalues[1].bit16hfname = hf_bit16rflags;
                if ((pvalues[1].vvalue && 0xf000) == 0xc000)
                {
                    pvalues[2].vtype = VTYPE_STRING;
                    pvalues[2].vdesc = "Name Type: %s";
                    pvalues[2].vstring = "Return Partion Name";
                    pvalues[2].vvalue = 0;
                    pvalues[2].vlength = 4;
                    pvalues[2].voffset = pvalues[1].voffset;
                    pvalues[2].mvtype = 0;
                    pvalues[2].hfname = hf_nds_name_type;
                }
                else
                {
                    pvalues[2].vtype = VTYPE_STRING;
                    pvalues[2].vdesc = "Name Type: %s";
                    pvalues[2].vstring = "Return Full Name";
                    pvalues[2].vvalue = 0;
                    pvalues[2].vlength = 4;
                    pvalues[2].mvtype = 0;
                    pvalues[2].voffset = pvalues[1].voffset;
                    pvalues[2].hfname = hf_nds_name_type;
                }
                foffset = foffset + 4;
                pvalues[3].vvalue = tvb_get_letohs(tvb, foffset);
                global_flags = tvb_get_letohl(tvb, foffset);
                pvalues[3].vtype = VTYPE_BITFIELD;
                pvalues[3].vdesc = "Information Flags (low) Byte:";
                pvalues[3].vlength = 2;
                pvalues[3].hfname = hf_nds_rflags;
                pvalues[3].voffset = foffset;
                pvalues[3].bit1 = "Output Flags";
                pvalues[3].bit1hfname = hf_bit1infoflagsl;
                pvalues[3].bit2 = "Entry ID";
                pvalues[3].bit2hfname = hf_bit2infoflagsl;
                pvalues[3].bit3 = "Entry Flags";
                pvalues[3].bit3hfname = hf_bit3infoflagsl;
                pvalues[3].bit4 = "Subordinate Count";
                pvalues[3].bit4hfname = hf_bit4infoflagsl;
                pvalues[3].bit5 = "Modification Time";
                pvalues[3].bit5hfname = hf_bit5infoflagsl;
                pvalues[3].bit6 = "Modification Timestamp";
                pvalues[3].bit6hfname = hf_bit6infoflagsl;
                pvalues[3].bit7 = "Creation Timestamp";
                pvalues[3].bit7hfname = hf_bit7infoflagsl;
                pvalues[3].bit8 = "Partition Root ID";
                pvalues[3].bit8hfname = hf_bit8infoflagsl;
                pvalues[3].bit9 = "Parent ID";
                pvalues[3].bit9hfname = hf_bit9infoflagsl;
                pvalues[3].bit10 = "Revision Count";
                pvalues[3].bit10hfname = hf_bit10infoflagsl;
                pvalues[3].bit11 = "Replica Type";
                pvalues[3].bit11hfname = hf_bit11infoflagsl;
                pvalues[3].bit12 = "Base Class";
                pvalues[3].bit12hfname = hf_bit12infoflagsl;
                pvalues[3].bit13 = "Relative Distinguished Name";
                pvalues[3].bit13hfname = hf_bit13infoflagsl;
                pvalues[3].bit14 = "Distinguished Name";
                pvalues[3].bit14hfname = hf_bit14infoflagsl;
                pvalues[3].bit15 = "Root Distinguished Name";
                pvalues[3].bit15hfname = hf_bit15infoflagsl;
                pvalues[3].bit16 = "Parent Distinguished Name";
                pvalues[3].bit16hfname = hf_bit16infoflagsl;
                foffset = foffset + 2;
                pvalues[4].vvalue = tvb_get_letohs(tvb, foffset);
                pvalues[4].vtype = VTYPE_BITFIELD;
                pvalues[4].vdesc = "Information Flags (high) Byte:";
                pvalues[4].vlength = 2;
                pvalues[4].hfname = hf_nds_rflags;
                pvalues[4].voffset = foffset;
                pvalues[4].bit1 = "Purge Time";
                pvalues[4].bit1hfname = hf_bit1infoflagsh;
                pvalues[4].bit2 = "Dereference Base Class";
                pvalues[4].bit2hfname = hf_bit2infoflagsh;
                pvalues[4].bit3 = "Replica Number";
                pvalues[4].bit3hfname = hf_bit3infoflagsh;
                pvalues[4].bit4 = "Replica State";
                pvalues[4].bit4hfname = hf_bit4infoflagsh;
                pvalues[4].bit5 = "Federation Boundary";
                pvalues[4].bit5hfname = hf_bit5infoflagsh;
                pvalues[4].bit6 = "Schema Boundary";
                pvalues[4].bit6hfname = hf_bit6infoflagsh;
                pvalues[4].bit7 = "Federation Boundary ID";
                pvalues[4].bit7hfname = hf_bit7infoflagsh;
                pvalues[4].bit8 = "Schema Boundary ID";
                pvalues[4].bit8hfname = hf_bit8infoflagsh;
                pvalues[4].bit9 = "Current Subcount";
                pvalues[4].bit9hfname = hf_bit9infoflagsh;
                pvalues[4].bit10 = "Local Entry Flags";
                pvalues[4].bit10hfname = hf_bit10infoflagsh;
                pvalues[4].bit11 = "Not Defined";
                pvalues[4].bit11hfname = hf_bit11infoflagsh;
                pvalues[4].bit12 = "Not Defined";
                pvalues[4].bit12hfname = hf_bit12infoflagsh;
                pvalues[4].bit13 = "Not Defined";
                pvalues[4].bit13hfname = hf_bit13infoflagsh;
                pvalues[4].bit14 = "Not Defined";
                pvalues[4].bit14hfname = hf_bit14infoflagsh;
                pvalues[4].bit15 = "Not Defined";
                pvalues[4].bit15hfname = hf_bit15infoflagsh;
                pvalues[4].bit16 = "Not Defined";
                pvalues[4].bit16hfname = hf_bit16infoflagsh;
                foffset = foffset + 2;
                pvalues[5].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[5].vtype = VTYPE_UINT32;
                pvalues[5].vdesc = "Entry ID: 0x%08x";
                pvalues[5].vlength = 4;
                pvalues[5].voffset = foffset;
                resolve_eid = TRUE;
                global_eid = pvalues[5].vvalue;
                pvalues[5].hfname = hf_nds_eid;
                foffset = foffset + pvalues[5].vlength;
                break;
            default:
                break;
            }

            break;
        case 0x03:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].voffset = foffset;
            pvalues[0].hfname = hf_nds_ver;
            foffset = foffset + pvalues[0].vlength;
            if (pvalues[0].vvalue == 0)
            {
                pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[1].vtype = VTYPE_UINT32;
                pvalues[1].vdesc = "Iteration Handle: 0x%08x";
                pvalues[1].vlength = 4;
                pvalues[1].voffset = foffset;
                pvalues[1].hfname = hf_nds_iteration;
                foffset = foffset + pvalues[1].vlength;
                pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[2].vtype = VTYPE_UINT32;
                pvalues[2].vdesc = "Entry ID: 0x%08x";
                pvalues[2].vlength = 4;
                resolve_eid = TRUE;
                global_eid = pvalues[2].vvalue;
                pvalues[2].voffset = foffset;
                pvalues[2].hfname = hf_nds_eid;
                foffset = foffset + pvalues[2].vlength;
                pvalues[3].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[3].vstring = (char *)match_strval(pvalues[3].vvalue, nds_info_type);
                global_flags = pvalues[3].vvalue;
                if (pvalues[3].vstring == NULL)
                {
                    pvalues[3].vstring = "No Info Type Set";
                }
                pvalues[3].vtype = VTYPE_STRING;
                pvalues[3].vdesc = "Info Type: %s";
                pvalues[3].vlength = 4;
                pvalues[3].voffset = foffset;
                pvalues[3].mvtype = MVTYPE_ATTR_REQUEST;
                pvalues[3].hfname = hf_nds_info_type;
                foffset = foffset + pvalues[3].vlength;
                pvalues[4].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[4].vtype = VTYPE_UINT32;
                pvalues[4].vdesc = "All Attributes: %u";
                pvalues[4].vlength = 4;
                pvalues[4].voffset = foffset;
                pvalues[4].hfname = hf_nds_all_attr;
                foffset = foffset + pvalues[4].vlength;
                pvalues[5].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[5].vtype = VTYPE_MULTIVALUE_UINT32;
                pvalues[5].vdesc = "Attributes: %u";
                pvalues[5].vlength = 4;
                pvalues[5].voffset = foffset;
                pvalues[5].mvtype = MVTYPE_ATTR_REQUEST;
                pvalues[5].hfname = hf_nds_attr;
            }
            else
            {
                pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[1].vtype = VTYPE_UINT32;
                pvalues[1].vdesc = "Request Flags: 0x%08x";
                pvalues[1].vlength = 4;
                pvalues[1].voffset = foffset;
                pvalues[1].hfname = hf_nds_req_flags;
                foffset = foffset + pvalues[1].vlength;
                pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[2].vtype = VTYPE_UINT32;
                pvalues[2].vdesc = "Iteration Handle: 0x%08x";
                pvalues[2].vlength = 4;
                pvalues[2].voffset = foffset;
                pvalues[2].hfname = hf_nds_iteration;
                foffset = foffset + pvalues[2].vlength;
                pvalues[3].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[3].vtype = VTYPE_UINT32;
                pvalues[3].vdesc = "Entry ID: 0x%08x";
                pvalues[3].vlength = 4;
                resolve_eid = TRUE;
                global_eid = pvalues[3].vvalue;
                pvalues[3].voffset = foffset;
                pvalues[3].hfname = hf_nds_eid;
                foffset = foffset + pvalues[3].vlength;
                pvalues[4].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[4].vstring = (char *)match_strval(pvalues[4].vvalue, nds_info_type);
                global_flags = pvalues[4].vvalue;
                if (pvalues[4].vstring == NULL)
                {
                    pvalues[4].vstring = "No Info Type Set";
                }
                pvalues[4].vtype = VTYPE_STRING;
                pvalues[4].vdesc = "Info Type: %s";
                pvalues[4].vlength = 4;
                pvalues[4].voffset = foffset;
                pvalues[4].hfname = hf_nds_info_type;
                pvalues[4].mvtype = MVTYPE_ATTR_REQUEST;
                foffset = foffset + pvalues[4].vlength;
                pvalues[5].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[5].vtype = VTYPE_UINT32;
                pvalues[5].vdesc = "All Attributes: %u";
                pvalues[5].vlength = 4;
                pvalues[5].voffset = foffset;
                pvalues[5].hfname = hf_nds_all_attr;
                foffset = foffset + pvalues[5].vlength;
                pvalues[6].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[6].vtype = VTYPE_MULTIVALUE_UINT32;
                pvalues[6].vdesc = "Attributes: %u";
                pvalues[6].vlength = 4;
                pvalues[6].voffset = foffset;
                pvalues[6].mvtype = MVTYPE_ATTR_REQUEST;
                pvalues[6].hfname = hf_nds_attr;
            }
            break;
        case 0x04:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].voffset = foffset;
            pvalues[0].hfname = hf_nds_ver;
            foffset = foffset + pvalues[0].vlength;
            if (pvalues[0].vvalue == 1)
            {
                foffset += 4;
            }
            pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[1].vtype = VTYPE_UINT32;
            pvalues[1].vdesc = "Entry ID: 0x%08x";
            pvalues[1].vlength = 4;
            resolve_eid = TRUE;
            global_eid = pvalues[1].vvalue;
            pvalues[1].voffset = foffset;
            pvalues[1].hfname = hf_nds_eid;
            foffset = foffset + pvalues[1].vlength;
            foffset += 4;
            pvalues[2].vtype = VTYPE_STRING;
            pvalues[2].vdesc = "Attribute Name Being Compared: %s";
            pvalues[2].mvtype = MVTYPE_ATTR_REQUEST;
            pvalues[2].vvalue = 0;
            pvalues[2].vlength = 256;
            pvalues[2].vlength = tvb_get_letohl(tvb, foffset);
            if (pvalues[2].vlength == 0x00 || !tvb_bytes_exist(tvb, foffset, pvalues[2].vlength))
            {
                pvalues[2].vtype = VTYPE_NONE;
                break;
            }
            pvalues[2].voffset = foffset + 4;
            foffset = foffset + 4;
            pvalues[2].vstring = get_string(tvb, pvalues[2].voffset, pvalues[2].vlength);
            g_strlcpy(global_object_name, pvalues[2].vstring, 256);
            pvalues[2].hfname = hf_nds_name;
            foffset = foffset + pvalues[2].vlength;
            foffset += align_4(tvb, foffset);
            foffset += 4;
            pvalues[3].vtype = VTYPE_STRING;
            pvalues[3].vdesc = "Attribute Value: %s";
            pvalues[3].mvtype = MVTYPE_ATTR_REQUEST;
            pvalues[3].vvalue = 0;
            pvalues[3].vlength = 256;
            pvalues[3].vlength = tvb_get_letohl(tvb, foffset);
            pvalues[3].voffset = foffset + 4;
            foffset = foffset + 4;
            pvalues[3].vstring = get_string(tvb, pvalues[3].voffset, pvalues[3].vlength);
            pvalues[3].hfname = hf_value_string;
            foffset = foffset + pvalues[3].vlength;
            break;
        case 0x05:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].voffset = foffset;
            pvalues[0].hfname = hf_nds_ver;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[1].vtype = VTYPE_BITFIELD;
            pvalues[1].vdesc = "Request Flags:";
            pvalues[1].vlength = 2;
            pvalues[1].hfname = hf_nds_rflags;
            pvalues[1].voffset = foffset;
            pvalues[1].bit1 = "List Typeless";
            pvalues[1].bit1hfname = hf_bit1lflags;
            pvalues[1].bit2 = "List Containers";
            pvalues[1].bit2hfname = hf_bit2lflags;
            pvalues[1].bit3 = "List Slashed";
            pvalues[1].bit3hfname = hf_bit3lflags;
            pvalues[1].bit4 = "List Dotted";
            pvalues[1].bit4hfname = hf_bit4lflags;
            pvalues[1].bit5 = "Dereference Alias";
            pvalues[1].bit5hfname = hf_bit5lflags;
            pvalues[1].bit6 = "List All Containers";
            pvalues[1].bit6hfname = hf_bit6lflags;
            pvalues[1].bit7 = "List Obsolete";
            pvalues[1].bit7hfname = hf_bit7lflags;
            pvalues[1].bit8 = "List Tuned Output";
            pvalues[1].bit8hfname = hf_bit8lflags;
            pvalues[1].bit9 = "List External Reference";
            pvalues[1].bit9hfname = hf_bit9lflags;
            pvalues[1].bit10 = "Not Defined";
            pvalues[1].bit10hfname = hf_bit10lflags;
            pvalues[1].bit11 = "Not Defined";
            pvalues[1].bit11hfname = hf_bit11lflags;
            pvalues[1].bit12 = "Not Defined";
            pvalues[1].bit12hfname = hf_bit12lflags;
            pvalues[1].bit13 = "Not Defined";
            pvalues[1].bit13hfname = hf_bit13lflags;
            pvalues[1].bit14 = "Not Defined";
            pvalues[1].bit14hfname = hf_bit14lflags;
            pvalues[1].bit15 = "Not Defined";
            pvalues[1].bit15hfname = hf_bit15lflags;
            pvalues[1].bit16 = "Not Defined";
            pvalues[1].bit16hfname = hf_bit16lflags;
            foffset = foffset + pvalues[1].vlength;
            foffset += 2;
            pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[2].vtype = VTYPE_UINT32;
            pvalues[2].vdesc = "Iteration Handle: 0x%08x";
            pvalues[2].vlength = 4;
            pvalues[2].voffset = foffset;
            pvalues[2].hfname = hf_nds_iteration;
            foffset = foffset + pvalues[2].vlength;
            pvalues[3].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[3].vtype = VTYPE_UINT32;
            pvalues[3].vdesc = "Parent ID: 0x%08x";
            pvalues[3].vlength = 4;
            pvalues[3].voffset = foffset;
            pvalues[3].hfname = hf_nds_parent;
            foffset = foffset + pvalues[3].vlength;
            pvalues[4].vvalue = tvb_get_letohs(tvb, foffset);
            global_flags = tvb_get_letohl(tvb, foffset);
            pvalues[4].vtype = VTYPE_BITFIELD;
            pvalues[4].vdesc = "Information Flags (low) Byte:";
            pvalues[4].vlength = 2;
            pvalues[4].hfname = hf_nds_rflags;
            pvalues[4].voffset = foffset;
            pvalues[4].bit1 = "Output Flags";
            pvalues[4].bit1hfname = hf_bit1infoflagsl;
            pvalues[4].bit2 = "Entry ID";
            pvalues[4].bit2hfname = hf_bit2infoflagsl;
            pvalues[4].bit3 = "Entry Flags";
            pvalues[4].bit3hfname = hf_bit3infoflagsl;
            pvalues[4].bit4 = "Subordinate Count";
            pvalues[4].bit4hfname = hf_bit4infoflagsl;
            pvalues[4].bit5 = "Modification Time";
            pvalues[4].bit5hfname = hf_bit5infoflagsl;
            pvalues[4].bit6 = "Modification Timestamp";
            pvalues[4].bit6hfname = hf_bit6infoflagsl;
            pvalues[4].bit7 = "Creation Timestamp";
            pvalues[4].bit7hfname = hf_bit7infoflagsl;
            pvalues[4].bit8 = "Partition Root ID";
            pvalues[4].bit8hfname = hf_bit8infoflagsl;
            pvalues[4].bit9 = "Parent ID";
            pvalues[4].bit9hfname = hf_bit9infoflagsl;
            pvalues[4].bit10 = "Revision Count";
            pvalues[4].bit10hfname = hf_bit10infoflagsl;
            pvalues[4].bit11 = "Replica Type";
            pvalues[4].bit11hfname = hf_bit11infoflagsl;
            pvalues[4].bit12 = "Base Class";
            pvalues[4].bit12hfname = hf_bit12infoflagsl;
            pvalues[4].bit13 = "Relative Distinguished Name";
            pvalues[4].bit13hfname = hf_bit13infoflagsl;
            pvalues[4].bit14 = "Distinguished Name";
            pvalues[4].bit14hfname = hf_bit14infoflagsl;
            pvalues[4].bit15 = "Root Distinguished Name";
            pvalues[4].bit15hfname = hf_bit15infoflagsl;
            pvalues[4].bit16 = "Parent Distinguished Name";
            pvalues[4].bit16hfname = hf_bit16infoflagsl;
            foffset = foffset + 2;
            pvalues[5].vvalue = tvb_get_letohs(tvb, foffset);
            pvalues[5].vtype = VTYPE_BITFIELD;
            pvalues[5].vdesc = "Information Flags (high) Byte:";
            pvalues[5].vlength = 2;
            pvalues[5].hfname = hf_nds_rflags;
            pvalues[5].voffset = foffset;
            pvalues[5].bit1 = "Purge Time";
            pvalues[5].bit1hfname = hf_bit1infoflagsh;
            pvalues[5].bit2 = "Dereference Base Class";
            pvalues[5].bit2hfname = hf_bit2infoflagsh;
            pvalues[5].bit3 = "Not Defined";
            pvalues[5].bit3hfname = hf_bit3infoflagsh;
            pvalues[5].bit4 = "Not Defined";
            pvalues[5].bit4hfname = hf_bit4infoflagsh;
            pvalues[5].bit5 = "Not Defined";
            pvalues[5].bit5hfname = hf_bit5infoflagsh;
            pvalues[5].bit6 = "Not Defined";
            pvalues[5].bit6hfname = hf_bit6infoflagsh;
            pvalues[5].bit7 = "Not Defined";
            pvalues[5].bit7hfname = hf_bit7infoflagsh;
            pvalues[5].bit8 = "Not Defined";
            pvalues[5].bit8hfname = hf_bit8infoflagsh;
            pvalues[5].bit9 = "Not Defined";
            pvalues[5].bit9hfname = hf_bit9infoflagsh;
            pvalues[5].bit10 = "Not Defined";
            pvalues[5].bit10hfname = hf_bit10infoflagsh;
            pvalues[5].bit11 = "Not Defined";
            pvalues[5].bit11hfname = hf_bit11infoflagsh;
            pvalues[5].bit12 = "Not Defined";
            pvalues[5].bit12hfname = hf_bit12infoflagsh;
            pvalues[5].bit13 = "Not Defined";
            pvalues[5].bit13hfname = hf_bit13infoflagsh;
            pvalues[5].bit14 = "Not Defined";
            pvalues[5].bit14hfname = hf_bit14infoflagsh;
            pvalues[5].bit15 = "Not Defined";
            pvalues[5].bit15hfname = hf_bit15infoflagsh;
            pvalues[5].bit16 = "Not Defined";
            pvalues[5].bit16hfname = hf_bit16infoflagsh;
            foffset = foffset + 2;
            pvalues[6].vtype = VTYPE_STRING;
            pvalues[6].vdesc = "Name Filter: %s";
            pvalues[6].mvtype = MVTYPE_ATTR_REQUEST;
            pvalues[6].vvalue = 0;
            pvalues[6].vlength = 256;
            pvalues[6].vlength = tvb_get_letohl(tvb, foffset);
            pvalues[6].voffset = foffset + 4;
            foffset = foffset + 4;
            pvalues[6].vstring = get_string(tvb, pvalues[6].voffset, pvalues[6].vlength);
            pvalues[6].hfname = hf_nds_name_filter;
            foffset = foffset + pvalues[6].vlength;
            if (pvalues[0].vvalue == 0)
            {
                break;
            }
            foffset += align_4(tvb, foffset);
            pvalues[7].vtype = VTYPE_STRING;
            pvalues[7].vdesc = "Class Filter: %s";
            pvalues[7].mvtype = MVTYPE_ATTR_REQUEST;
            pvalues[7].vvalue = 0;
            pvalues[7].vlength = 256;
            pvalues[7].vlength = tvb_get_letohl(tvb, foffset);
            pvalues[7].voffset = foffset + 4;
            foffset = foffset + 4;
            pvalues[7].vstring = get_string(tvb, pvalues[7].voffset, pvalues[7].vlength);
            pvalues[7].hfname = hf_nds_class_filter;
            foffset = foffset + pvalues[7].vlength;
            if (pvalues[0].vvalue == 1)
            {
                break;
            }
            foffset += align_4(tvb, foffset);
            pvalues[8].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[8].vtype = VTYPE_MULTIVALUE_UINT32;
            pvalues[8].vdesc = "Seconds: %u";
            pvalues[8].vlength = 4;
            pvalues[8].mvtype = MVTYPE_PRINT_TIMESTAMP;
            pvalues[8].hfname = hf_nds_time_filter;
            pvalues[8].voffset = foffset;
            break;
        case 0x06:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vstring = "";
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].voffset = foffset;
            pvalues[0].hfname = hf_nds_ver;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[1].vtype = VTYPE_UINT32;
            pvalues[1].vstring = "";
            pvalues[1].vdesc = "Request Flags: 0x%08x";
            pvalues[1].vlength = 4;
            pvalues[1].hfname = hf_nds_rflags;
            pvalues[1].voffset = foffset;
            foffset = foffset + 4;
            pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[2].vtype = VTYPE_UINT32;
            pvalues[2].vdesc = "Iteration Handle: 0x%08x";
            pvalues[2].vlength = 4;
            pvalues[2].voffset = foffset;
            pvalues[2].hfname = hf_nds_iteration;
            foffset = foffset + pvalues[2].vlength;
            pvalues[3].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[3].vstring = "";
            pvalues[3].vtype = VTYPE_UINT32;
            pvalues[3].vdesc = "Base Entry ID: 0x%08x";
            pvalues[3].vlength = 4;
            resolve_eid = FALSE;
            global_eid = pvalues[3].vvalue;
            pvalues[3].voffset = foffset;
            pvalues[3].hfname = hf_nds_eid;
            foffset = foffset + pvalues[3].vlength;
            pvalues[4].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[4].vstring = (char *)match_strval(pvalues[4].vvalue, nds_search_scope);
            if (pvalues[4].vstring == NULL)
            {
                pvalues[4].vstring = "No Search Scope Defined";
            }
            pvalues[4].vtype = VTYPE_STRING;
            pvalues[4].vdesc = "Replica Type: %s";
            pvalues[4].vlength = 4;
            pvalues[4].voffset = foffset;
            pvalues[4].mvtype = 0;
            pvalues[4].hfname = hf_nds_search_scope;
            foffset = foffset + pvalues[4].vlength;
            pvalues[5].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[5].vtype = VTYPE_UINT32;
            pvalues[5].vdesc = "Number of Objects to Search: 0x%08x";
            pvalues[5].vlength = 4;
            pvalues[5].voffset = foffset;
            pvalues[5].hfname = hf_nds_num_objects;
            foffset = foffset + pvalues[5].vlength;
            pvalues[6].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[6].vtype = VTYPE_BITFIELD;
            pvalues[6].vdesc = "Information Types:";
            pvalues[6].vlength = 2;
            pvalues[6].hfname = hf_nds_nflags;
            pvalues[6].voffset = foffset;
            pvalues[6].bit1 = "Names";
            pvalues[6].bit1hfname = hf_bit1siflags;
            pvalues[6].bit2 = "Names and Values";
            pvalues[6].bit2hfname = hf_bit2siflags;
            pvalues[6].bit3 = "Effective Privileges";
            pvalues[6].bit3hfname = hf_bit3siflags;
            pvalues[6].bit4 = "Value Info";
            pvalues[6].bit4hfname = hf_bit4siflags;
            pvalues[6].bit5 = "Abbreviated Value";
            pvalues[6].bit5hfname = hf_bit5siflags;
            pvalues[6].bit6 = "Not Defined";
            pvalues[6].bit6hfname = hf_bit6siflags;
            pvalues[6].bit7 = "Not Defined";
            pvalues[6].bit7hfname = hf_bit7siflags;
            pvalues[6].bit8 = "Not Defined";
            pvalues[6].bit8hfname = hf_bit8siflags;
            pvalues[6].bit9 = "Expanded Class";
            pvalues[6].bit9hfname = hf_bit9siflags;
            pvalues[6].bit10 = "Not Defined";
            pvalues[6].bit10hfname = hf_bit10siflags;
            pvalues[6].bit11 = "Not Defined";
            pvalues[6].bit11hfname = hf_bit11siflags;
            pvalues[6].bit12 = "Not Defined";
            pvalues[6].bit12hfname = hf_bit12siflags;
            pvalues[6].bit13 = "Not Defined";
            pvalues[6].bit13hfname = hf_bit13siflags;
            pvalues[6].bit14 = "Not Defined";
            pvalues[6].bit14hfname = hf_bit14siflags;
            pvalues[6].bit15 = "Not Defined";
            pvalues[6].bit15hfname = hf_bit15siflags;
            pvalues[6].bit16 = "Not Defined";
            pvalues[6].bit16hfname = hf_bit16siflags;
            foffset = foffset + 4;
            if (pvalues[0].vvalue != 2)
            {
                pvalues[7].vvalue = tvb_get_letohs(tvb, foffset);
                global_flags = tvb_get_letohl(tvb, foffset);
                pvalues[7].vtype = VTYPE_BITFIELD;
                pvalues[7].vdesc = "Information Flags (low) Byte:";
                pvalues[7].vlength = 2;
                pvalues[7].hfname = hf_nds_rflags;
                pvalues[7].voffset = foffset;
                pvalues[7].bit1 = "Output Flags";
                pvalues[7].bit1hfname = hf_bit1infoflagsl;
                pvalues[7].bit2 = "Entry ID";
                pvalues[7].bit2hfname = hf_bit2infoflagsl;
                pvalues[7].bit3 = "Entry Flags";
                pvalues[7].bit3hfname = hf_bit3infoflagsl;
                pvalues[7].bit4 = "Subordinate Count";
                pvalues[7].bit4hfname = hf_bit4infoflagsl;
                pvalues[7].bit5 = "Modification Time";
                pvalues[7].bit5hfname = hf_bit5infoflagsl;
                pvalues[7].bit6 = "Modification Timestamp";
                pvalues[7].bit6hfname = hf_bit6infoflagsl;
                pvalues[7].bit7 = "Creation Timestamp";
                pvalues[7].bit7hfname = hf_bit7infoflagsl;
                pvalues[7].bit8 = "Partition Root ID";
                pvalues[7].bit8hfname = hf_bit8infoflagsl;
                pvalues[7].bit9 = "Parent ID";
                pvalues[7].bit9hfname = hf_bit9infoflagsl;
                pvalues[7].bit10 = "Revision Count";
                pvalues[7].bit10hfname = hf_bit10infoflagsl;
                pvalues[7].bit11 = "Replica Type";
                pvalues[7].bit11hfname = hf_bit11infoflagsl;
                pvalues[7].bit12 = "Base Class";
                pvalues[7].bit12hfname = hf_bit12infoflagsl;
                pvalues[7].bit13 = "Relative Distinguished Name";
                pvalues[7].bit13hfname = hf_bit13infoflagsl;
                pvalues[7].bit14 = "Distinguished Name";
                pvalues[7].bit14hfname = hf_bit14infoflagsl;
                pvalues[7].bit15 = "Root Distinguished Name";
                pvalues[7].bit15hfname = hf_bit15infoflagsl;
                pvalues[7].bit16 = "Parent Distinguished Name";
                pvalues[7].bit16hfname = hf_bit16infoflagsl;
                foffset = foffset + 2;
                pvalues[8].vvalue = tvb_get_letohs(tvb, foffset);
                pvalues[8].vtype = VTYPE_BITFIELD;
                pvalues[8].vdesc = "Information Flags (high) Byte:";
                pvalues[8].vlength = 2;
                pvalues[8].hfname = hf_nds_rflags;
                pvalues[8].voffset = foffset;
                pvalues[8].bit1 = "Purge Time";
                pvalues[8].bit1hfname = hf_bit1infoflagsh;
                pvalues[8].bit2 = "Dereference Base Class";
                pvalues[8].bit2hfname = hf_bit2infoflagsh;
                pvalues[8].bit3 = "Not Defined";
                pvalues[8].bit3hfname = hf_bit3infoflagsh;
                pvalues[8].bit4 = "Not Defined";
                pvalues[8].bit4hfname = hf_bit4infoflagsh;
                pvalues[8].bit5 = "Not Defined";
                pvalues[8].bit5hfname = hf_bit5infoflagsh;
                pvalues[8].bit6 = "Not Defined";
                pvalues[8].bit6hfname = hf_bit6infoflagsh;
                pvalues[8].bit7 = "Not Defined";
                pvalues[8].bit7hfname = hf_bit7infoflagsh;
                pvalues[8].bit8 = "Not Defined";
                pvalues[8].bit8hfname = hf_bit8infoflagsh;
                pvalues[8].bit9 = "Not Defined";
                pvalues[8].bit9hfname = hf_bit9infoflagsh;
                pvalues[8].bit10 = "Not Defined";
                pvalues[8].bit10hfname = hf_bit10infoflagsh;
                pvalues[8].bit11 = "Not Defined";
                pvalues[8].bit11hfname = hf_bit11infoflagsh;
                pvalues[8].bit12 = "Not Defined";
                pvalues[8].bit12hfname = hf_bit12infoflagsh;
                pvalues[8].bit13 = "Not Defined";
                pvalues[8].bit13hfname = hf_bit13infoflagsh;
                pvalues[8].bit14 = "Not Defined";
                pvalues[8].bit14hfname = hf_bit14infoflagsh;
                pvalues[8].bit15 = "Not Defined";
                pvalues[8].bit15hfname = hf_bit15infoflagsh;
                pvalues[8].bit16 = "Not Defined";
                pvalues[8].bit16hfname = hf_bit16infoflagsh;
                foffset = foffset + 2;
            }
            break;
        case 0x07:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vstring = "";
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].voffset = foffset;
            pvalues[0].hfname = hf_nds_ver;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[1].vtype = VTYPE_UINT32;
            pvalues[1].vstring = "";
            pvalues[1].vdesc = "Request Flags: 0x%08x";
            pvalues[1].vlength = 4;
            pvalues[1].hfname = hf_nds_rflags;
            pvalues[1].voffset = foffset;
            foffset = foffset + 4;
            if (pvalues[0].vvalue == 0)
            {
                pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[2].vstring = "";
                pvalues[2].vtype = VTYPE_UINT32;
                pvalues[2].vdesc = "Parent Entry ID: 0x%08x";
                pvalues[2].vlength = 4;
                resolve_eid = FALSE;
                global_eid = pvalues[2].vvalue;
                pvalues[2].voffset = foffset;
                pvalues[2].hfname = hf_nds_eid;
                foffset = foffset + pvalues[2].vlength;
                pvalues[3].vtype = VTYPE_STRING;
                pvalues[3].vdesc = "Relative Distinguished Name: %s";
                pvalues[3].vstring = "";
                pvalues[3].mvtype = MVTYPE_ATTR_REQUEST;
                pvalues[3].vvalue = 0;
                pvalues[3].vlength = 256;
                pvalues[3].vlength = tvb_get_letohl(tvb, foffset);
                if (pvalues[3].vlength == 0x00 || !tvb_bytes_exist(tvb, foffset, pvalues[3].vlength))
                {
                    pvalues[3].vtype = VTYPE_NONE;
                    break;
                }
                pvalues[3].voffset = foffset + 4;
                foffset = foffset + 4;
                pvalues[3].vstring = get_string(tvb, pvalues[3].voffset, pvalues[3].vlength);
                g_strlcpy(global_object_name, pvalues[3].vstring, 256);
                pvalues[3].hfname = hf_nds_relative_dn;
                foffset = foffset + pvalues[3].vlength;
                foffset += align_4(tvb, foffset);
                pvalues[4].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[4].vtype = VTYPE_MULTIVALUE_UINT32;
                pvalues[4].vstring = "";
                pvalues[4].vdesc = "Attributes: %u";
                pvalues[4].vlength = 4;
                pvalues[4].voffset = foffset;
                pvalues[4].mvtype = MVTYPE_ADD_ATTR_REQUEST;
                pvalues[4].hfname = hf_nds_attr;
            }
            else
            {
                pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[2].vstring = "";
                pvalues[2].vtype = VTYPE_UINT32;
                pvalues[2].vdesc = "Iteration Handle: 0x%08x";
                pvalues[2].vlength = 4;
                pvalues[2].voffset = foffset;
                pvalues[2].hfname = hf_nds_iteration;
                foffset = foffset + pvalues[2].vlength;
                pvalues[3].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[3].vstring = "";
                pvalues[3].vtype = VTYPE_UINT32;
                pvalues[3].vdesc = "Parent Entry ID: 0x%08x";
                pvalues[3].vlength = 4;
                resolve_eid = FALSE;
                global_eid = pvalues[3].vvalue;
                pvalues[3].voffset = foffset;
                pvalues[3].hfname = hf_nds_eid;
                foffset = foffset + pvalues[3].vlength;
                pvalues[4].vtype = VTYPE_STRING;
                pvalues[4].vdesc = "Relative Distinguished Name: %s";
                pvalues[4].vstring = "";
                pvalues[4].mvtype = MVTYPE_ATTR_REQUEST;
                pvalues[4].vvalue = 0;
                pvalues[4].vlength = 256;
                pvalues[4].vlength = tvb_get_letohl(tvb, foffset);
                if (pvalues[4].vlength == 0x00 || !tvb_bytes_exist(tvb, foffset, pvalues[4].vlength))
                {
                    pvalues[4].vtype = VTYPE_NONE;
                    break;
                }
                pvalues[4].voffset = foffset + 4;
                foffset = foffset + 4;
                pvalues[4].vstring = get_string(tvb, pvalues[4].voffset, pvalues[4].vlength);
                g_strlcpy(global_object_name, pvalues[4].vstring, 256);
                pvalues[4].hfname = hf_nds_relative_dn;
                foffset = foffset + pvalues[4].vlength;
                foffset += align_4(tvb, foffset);
                pvalues[5].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[5].vtype = VTYPE_MULTIVALUE_UINT32;
                pvalues[5].vstring = "";
                pvalues[5].vdesc = "Attributes: %u";
                pvalues[5].vlength = 4;
                pvalues[5].voffset = foffset;
                pvalues[5].mvtype = MVTYPE_ADD_ATTR_REQUEST;
                pvalues[5].hfname = hf_nds_attr;
            }
            break;
        case 0x08:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].voffset = foffset;
            pvalues[0].hfname = hf_nds_ver;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[1].vtype = VTYPE_UINT32;
            pvalues[1].vdesc = "Entry ID: 0x%08x";
            pvalues[1].vlength = 4;
            resolve_eid = TRUE;
            global_eid = pvalues[1].vvalue;
            pvalues[1].voffset = foffset;
            pvalues[1].hfname = hf_nds_eid;
            foffset = foffset + pvalues[1].vlength;
            break;
        case 0x09:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].voffset = foffset;
            pvalues[0].hfname = hf_nds_ver;
            foffset = foffset + pvalues[0].vlength;
            if (pvalues[0].vvalue == 0)
            {
                pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[1].vtype = VTYPE_UINT32;
                pvalues[1].vstring = "";
                pvalues[1].vdesc = "Iteration Handle: 0x%08x";
                pvalues[1].vlength = 4;
                pvalues[1].hfname = hf_nds_iteration;
                pvalues[1].voffset = foffset;
                foffset = foffset + 4;
                pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[2].vstring = "";
                pvalues[2].vtype = VTYPE_UINT32;
                pvalues[2].vdesc = "Entry ID: 0x%08x";
                pvalues[2].vlength = 4;
                pvalues[2].voffset = foffset;
                resolve_eid = TRUE;
                global_eid = pvalues[2].vvalue;
                pvalues[2].hfname = hf_nds_eid;
                foffset = foffset + pvalues[2].vlength;
                pvalues[3].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[3].vtype = VTYPE_MULTIVALUE_UINT32;
                pvalues[3].vstring = "";
                pvalues[3].vdesc = "Number of Attributes to Change %u";
                pvalues[3].vlength = 4;
                pvalues[3].mvtype = MVTYPE_MODIFY_ATTR_REQUEST;
                pvalues[3].hfname = hf_nds_number_of_changes;
                pvalues[3].voffset = foffset;
            }
            else
            {
                pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[1].vtype = VTYPE_UINT32;
                pvalues[1].vstring = "";
                pvalues[1].vdesc = "Request Flags: 0x%08x";
                pvalues[1].vlength = 4;
                pvalues[1].hfname = hf_nds_rflags;
                pvalues[1].voffset = foffset;
                foffset = foffset + 4;
                pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[2].vtype = VTYPE_UINT32;
                pvalues[2].vstring = "";
                pvalues[2].vdesc = "Iteration Handle: 0x%08x";
                pvalues[2].vlength = 4;
                pvalues[2].hfname = hf_nds_iteration;
                pvalues[2].voffset = foffset;
                foffset = foffset + 4;
                pvalues[3].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[3].vstring = "";
                pvalues[3].vtype = VTYPE_UINT32;
                pvalues[3].vdesc = "Entry ID: 0x%08x";
                pvalues[3].vlength = 4;
                pvalues[3].voffset = foffset;
                resolve_eid = TRUE;
                global_eid = pvalues[3].vvalue;
                pvalues[3].hfname = hf_nds_eid;
                foffset = foffset + pvalues[3].vlength;
                pvalues[4].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[4].vtype = VTYPE_MULTIVALUE_UINT32;
                pvalues[4].vstring = "";
                pvalues[4].vdesc = "Number of Attributes to Change %u";
                pvalues[4].vlength = 4;
                pvalues[4].mvtype = MVTYPE_MODIFY_ATTR_REQUEST;
                pvalues[4].hfname = hf_nds_number_of_changes;
                pvalues[4].voffset = foffset;
            }
            break;
        case 0x0a:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].voffset = foffset;
            pvalues[0].hfname = hf_nds_ver;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[1].vtype = VTYPE_UINT32;
            pvalues[1].vdesc = "Entry ID: 0x%08x";
            pvalues[1].vlength = 4;
            resolve_eid = TRUE;
            global_eid = pvalues[1].vvalue;
            pvalues[1].voffset = foffset;
            pvalues[1].hfname = hf_nds_eid;
            foffset = foffset + pvalues[1].vlength;
            pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[2].vtype = VTYPE_BOOLEAN;
            pvalues[2].vdesc = "Keep Original RDN: %s";
            pvalues[2].vlength = 4;
            pvalues[2].voffset = foffset;
            pvalues[2].mvtype = 0;
            pvalues[2].hfname = hf_nds_keep;
            foffset = foffset + 4;
            foffset += align_4(tvb, foffset);
            pvalues[3].vtype = VTYPE_STRING;
            pvalues[3].vdesc = "New RDN: %s";
            pvalues[3].mvtype = 0;
            pvalues[3].vvalue = 0;
            pvalues[3].vlength = 256;
            pvalues[3].vlength = tvb_get_letohl(tvb, foffset);
            pvalues[3].voffset = foffset + 4;
            foffset = foffset + 4;
            pvalues[3].vstring = get_string(tvb, pvalues[3].voffset, pvalues[3].vlength);
            pvalues[3].hfname = hf_nds_new_rdn;
            foffset = foffset + pvalues[3].vlength;
            break;
        case 0x0b:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].voffset = foffset;
            pvalues[0].hfname = hf_nds_ver;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vvalue = tvb_get_letohs(tvb, foffset);
            global_flags = tvb_get_letohl(tvb, foffset);
            pvalues[1].vtype = VTYPE_BITFIELD;
            pvalues[1].vdesc = "Attribute Constraints:";
            pvalues[1].vlength = 2;
            pvalues[1].hfname = hf_nds_acflags;
            pvalues[1].voffset = foffset;
            pvalues[1].bit1 = "Single Valued";
            pvalues[1].bit1hfname = hf_bit1acflags;
            pvalues[1].bit2 = "Sized";
            pvalues[1].bit2hfname = hf_bit2acflags;
            pvalues[1].bit3 = "Non-Removable";
            pvalues[1].bit3hfname = hf_bit3acflags;
            pvalues[1].bit4 = "Read Only";
            pvalues[1].bit4hfname = hf_bit4acflags;
            pvalues[1].bit5 = "Hidden";
            pvalues[1].bit5hfname = hf_bit5acflags;
            pvalues[1].bit6 = "String";
            pvalues[1].bit6hfname = hf_bit6acflags;
            pvalues[1].bit7 = "Synchronize Immediate";
            pvalues[1].bit7hfname = hf_bit7acflags;
            pvalues[1].bit8 = "Public Read";
            pvalues[1].bit8hfname = hf_bit8acflags;
            pvalues[1].bit9 = "Server Read";
            pvalues[1].bit9hfname = hf_bit9acflags;
            pvalues[1].bit10 = "Write Managed";
            pvalues[1].bit10hfname = hf_bit10acflags;
            pvalues[1].bit11 = "Per Replica";
            pvalues[1].bit11hfname = hf_bit11acflags;
            pvalues[1].bit12 = "Never Schedule Synchronization";
            pvalues[1].bit12hfname = hf_bit12acflags;
            pvalues[1].bit13 = "Operational";
            pvalues[1].bit13hfname = hf_bit13acflags;
            pvalues[1].bit14 = "Not Defined";
            pvalues[1].bit14hfname = hf_bit14acflags;
            pvalues[1].bit15 = "Not Defined";
            pvalues[1].bit15hfname = hf_bit15acflags;
            pvalues[1].bit16 = "Not Defined";
            pvalues[1].bit16hfname = hf_bit16acflags;
            foffset = foffset + 4;
            pvalues[2].vtype = VTYPE_STRING;
            pvalues[2].vdesc = "Attribute Name: %s";
            pvalues[2].mvtype = MVTYPE_ATTR_REQUEST;
            pvalues[2].vvalue = 0;
            pvalues[2].vlength = 256;
            pvalues[2].vlength = tvb_get_letohl(tvb, foffset);
            if (pvalues[2].vlength == 0x00 || !tvb_bytes_exist(tvb, foffset, pvalues[2].vlength))
            {
                pvalues[2].vtype = VTYPE_NONE;
                break;
            }
            pvalues[2].voffset = foffset + 4;
            foffset = foffset + 4;
            pvalues[2].vstring = get_string(tvb, pvalues[2].voffset, pvalues[2].vlength);
            g_strlcpy(global_object_name, pvalues[2].vstring, 256);
            pvalues[2].hfname = hf_nds_name;
            foffset = foffset + pvalues[2].vlength;
            foffset += align_4(tvb, foffset);
            pvalues[3].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[3].vstring = (char *)match_strval(pvalues[3].vvalue, nds_syntax);
            if (pvalues[3].vstring == NULL)
            {
                pvalues[3].vstring = "No Syntax Found";
            }
            pvalues[3].vtype = VTYPE_STRING;
            pvalues[3].vdesc = "Syntax: %s";
            pvalues[3].vlength = 4;
            pvalues[3].voffset = foffset;
            pvalues[3].hfname = hf_nds_syntax;
            pvalues[3].mvtype = 0;
            foffset = foffset + pvalues[3].vlength;
            pvalues[4].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[4].vtype = VTYPE_UINT32;
            pvalues[4].vdesc = "Lower Limit Value %u";
            pvalues[4].vlength = 4;
            pvalues[4].voffset = foffset;
            pvalues[4].hfname = hf_nds_lower;
            foffset += 4;
            pvalues[5].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[5].vtype = VTYPE_UINT32;
            pvalues[5].vdesc = "Upper Limit Value %u";
            pvalues[5].vlength = 4;
            pvalues[5].voffset = foffset;
            pvalues[5].hfname = hf_nds_upper;
            foffset += 4;
            pvalues[6].vvalue = tvb_get_letohl(tvb, foffset);
            foffset += 4;
            pvalues[6].vtype = VTYPE_BYTES;
            pvalues[6].vdesc = "ASN.1 ID";
            pvalues[6].vlength = pvalues[6].vvalue;
            pvalues[6].voffset = foffset;
            pvalues[6].hfname = hf_nds_asn1;
            break;
        case 0x0c:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x0d:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].voffset = foffset;
            pvalues[0].hfname = hf_nds_ver;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vtype = VTYPE_STRING;
            pvalues[1].vdesc = "Attribute Name: %s";
            pvalues[1].mvtype = MVTYPE_ATTR_REQUEST;
            pvalues[1].vvalue = 0;
            pvalues[1].vlength = 256;
            pvalues[1].vlength = tvb_get_letohl(tvb, foffset);
            if (pvalues[1].vlength == 0x00 || !tvb_bytes_exist(tvb, foffset, pvalues[1].vlength))
            {
                pvalues[1].vtype = VTYPE_NONE;
                break;
            }
            pvalues[1].voffset = foffset + 4;
            foffset = foffset + 4;
            pvalues[1].vstring = get_string(tvb, pvalues[1].voffset, pvalues[1].vlength);
            g_strlcpy(global_object_name, pvalues[1].vstring, 256);
            pvalues[1].hfname = hf_nds_attribute_dn;
            break;
        case 0x0e:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x0f:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].voffset = foffset;
            pvalues[0].hfname = hf_nds_ver;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[1].vtype = VTYPE_UINT32;
            pvalues[1].vdesc = "Iteration Handle: 0x%08x";
            pvalues[1].vlength = 4;
            pvalues[1].voffset = foffset;
            pvalues[1].hfname = hf_nds_iteration;
            foffset = foffset + pvalues[1].vlength;
            pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
            global_flags = pvalues[2].vvalue;
            pvalues[2].vstring = (char *)match_strval(pvalues[2].vvalue, class_def_type);
            if (pvalues[2].vstring == NULL)
            {
                pvalues[2].vstring = "No Class Definition Type Set";
            }
            pvalues[2].vtype = VTYPE_STRING;
            pvalues[2].vdesc = "Class Definition Type: %s";
            pvalues[2].vlength = 4;
            pvalues[2].voffset = foffset;
            pvalues[2].mvtype = 0;
            pvalues[2].hfname = hf_nds_class_def_type;
            foffset = foffset + pvalues[2].vlength;
            pvalues[3].vvalue = tvb_get_letohl(tvb, foffset);
            if (pvalues[3].vvalue == 0x00000000)
            {
                pvalues[3].vstring = "Do Not Return All Classes";
                pvalues[3].mvtype = 0;
            }
            else
            {
                pvalues[3].vstring = "Return All Classes";
                pvalues[3].mvtype = MVTYPE_ATTR_REQUEST;
            }
            pvalues[3].vtype = VTYPE_STRING;
            pvalues[3].vdesc = "%s";
            pvalues[3].vlength = 4;
            pvalues[3].voffset = foffset;
            pvalues[3].hfname = hf_nds_return_all_classes;
            foffset = foffset + pvalues[3].vlength;
            foffset += align_4(tvb, foffset);
            pvalues[4].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[4].vtype = VTYPE_MULTIVALUE_UINT32;
            pvalues[4].vdesc = "Classes: %u";
            pvalues[4].vlength = 4;
            pvalues[4].voffset = foffset;
            pvalues[4].mvtype = MVTYPE_READ_CLASS_REQ;
            pvalues[4].hfname = hf_nds_classes;
            break;
        case 0x10:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].voffset = foffset;
            pvalues[0].hfname = hf_nds_ver;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vtype = VTYPE_STRING;
            pvalues[1].vdesc = "Class Name: %s";
            pvalues[1].mvtype = MVTYPE_ATTR_REQUEST;
            pvalues[1].vvalue = 0;
            pvalues[1].vlength = 256;
            pvalues[1].vlength = tvb_get_letohl(tvb, foffset);
            if (pvalues[1].vlength == 0x00 || !tvb_bytes_exist(tvb, foffset, pvalues[1].vlength))
            {
                pvalues[1].vtype = VTYPE_NONE;
                break;
            }
            pvalues[1].voffset = foffset + 4;
            foffset = foffset + 4;
            pvalues[1].vstring = get_string(tvb, pvalues[1].voffset, pvalues[1].vlength);
            g_strlcpy(global_object_name, pvalues[1].vstring, 256);
            pvalues[1].hfname = hf_nds_base_class;
            foffset = foffset + pvalues[1].vlength;
            foffset += align_4(tvb, foffset);
            pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[2].vtype = VTYPE_MULTIVALUE_UINT32;
            pvalues[2].vdesc = "Number of Attributes to Add: %u";
            pvalues[2].vlength = 4;
            pvalues[2].voffset = foffset;
            pvalues[2].mvtype = MVTYPE_MODIFY_CLASS;
            pvalues[2].hfname = hf_nds_att_add;
            break;
        case 0x11:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].voffset = foffset;
            pvalues[0].hfname = hf_nds_ver;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vtype = VTYPE_STRING;
            pvalues[1].vdesc = "Class Name: %s";
            pvalues[1].mvtype = MVTYPE_ATTR_REQUEST;
            pvalues[1].vvalue = 0;
            pvalues[1].vlength = 256;
            pvalues[1].vlength = tvb_get_letohl(tvb, foffset);
            if (pvalues[1].vlength == 0x00 || !tvb_bytes_exist(tvb, foffset, pvalues[1].vlength))
            {
                pvalues[1].vtype = VTYPE_NONE;
                break;
            }
            pvalues[1].voffset = foffset + 4;
            foffset = foffset + 4;
            pvalues[1].vstring = get_string(tvb, pvalues[1].voffset, pvalues[1].vlength);
            g_strlcpy(global_object_name, pvalues[1].vstring, 256);
            pvalues[1].hfname = hf_nds_base;
            break;
        case 0x12:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].voffset = foffset;
            pvalues[0].hfname = hf_nds_ver;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[1].vtype = VTYPE_UINT32;
            pvalues[1].vdesc = "Iteration Handle: 0x%08x";
            pvalues[1].vlength = 4;
            pvalues[1].voffset = foffset;
            pvalues[1].hfname = hf_nds_iteration;
            foffset = foffset + pvalues[1].vlength;
            pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[2].vtype = VTYPE_UINT32;
            pvalues[2].vdesc = "Entry ID: 0x%08x";
            pvalues[2].vlength = 4;
            resolve_eid = TRUE;
            global_eid = pvalues[2].vvalue;
            pvalues[2].voffset = foffset;
            pvalues[2].hfname = hf_nds_eid;
            foffset = foffset + pvalues[2].vlength;
            break;
        case 0x13:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].voffset = foffset;
            pvalues[0].hfname = hf_nds_ver;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[1].vtype = VTYPE_UINT32;
            pvalues[1].vdesc = "Entry ID: 0x%08x";
            pvalues[1].vlength = 4;
            resolve_eid = TRUE;
            global_eid = pvalues[1].vvalue;
            pvalues[1].voffset = foffset;
            pvalues[1].hfname = hf_nds_eid;
            foffset = foffset + pvalues[1].vlength;
            pvalues[2].vtype = VTYPE_STRING;
            pvalues[2].vdesc = "Trustee Name: %s";
            pvalues[2].mvtype = MVTYPE_ATTR_REQUEST;
            pvalues[2].vvalue = 0;
            pvalues[2].vlength = 256;
            pvalues[2].vlength = tvb_get_letohl(tvb, foffset);
            if (pvalues[2].vlength == 0x00 || !tvb_bytes_exist(tvb, foffset, pvalues[2].vlength))
            {
                pvalues[2].vtype = VTYPE_NONE;
                break;
            }
            pvalues[2].voffset = foffset + 4;
            foffset = foffset + 4;
            pvalues[2].vstring = get_string(tvb, pvalues[2].voffset, pvalues[2].vlength);
            pvalues[2].hfname = hf_nds_name;
            foffset = foffset + pvalues[2].vlength;
            foffset += align_4(tvb, foffset);
            pvalues[3].vtype = VTYPE_STRING;
            pvalues[3].vdesc = "Attribute to be Checked: %s";
            pvalues[3].mvtype = 0;
            pvalues[3].vvalue = 0;
            pvalues[3].vlength = 256;
            pvalues[3].vlength = tvb_get_letohl(tvb, foffset);
            if (pvalues[3].vlength == 0x00 || !tvb_bytes_exist(tvb, foffset, pvalues[3].vlength))
            {
                pvalues[3].vtype = VTYPE_NONE;
                break;
            }
            pvalues[3].voffset = foffset + 4;
            foffset = foffset + 4;
            pvalues[3].vstring = get_string(tvb, pvalues[3].voffset, pvalues[3].vlength);
            pvalues[3].hfname = hf_nds_name;
            foffset = foffset + pvalues[3].vlength;
            foffset += align_4(tvb, foffset);
            if (pvalues[0].vvalue != 0)
            {
                pvalues[4].vtype = VTYPE_STRING;
                pvalues[4].vdesc = "Security Equivalence: %s";
                pvalues[4].mvtype = MVTYPE_ATTR_REQUEST;
                pvalues[4].vvalue = 0;
                pvalues[4].vlength = 256;
                pvalues[4].vlength = tvb_get_letohl(tvb, foffset);
                if (pvalues[4].vlength == 0x00 || !tvb_bytes_exist(tvb, foffset, pvalues[4].vlength))
                {
                    pvalues[4].vtype = VTYPE_NONE;
                    break;
                }
                pvalues[4].voffset = foffset + 4;
                foffset = foffset + 4;
                pvalues[4].vstring = get_string(tvb, pvalues[4].voffset, pvalues[4].vlength);
                pvalues[4].hfname = hf_nds_name;
                foffset = foffset + pvalues[4].vlength;
                foffset += align_4(tvb, foffset);
            }
            break;
        case 0x14:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x15:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x16:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].voffset = foffset;
            pvalues[0].hfname = hf_nds_ver;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[1].vtype = VTYPE_BITFIELD;
            pvalues[1].vdesc = "Request Flags:";
            pvalues[1].vlength = 2;
            pvalues[1].hfname = hf_nds_rflags;
            pvalues[1].voffset = foffset;
            pvalues[1].bit1 = "Typeless";
            pvalues[1].bit1hfname = hf_nds_bit1;
            pvalues[1].bit2 = "All Containers";
            pvalues[1].bit2hfname = hf_nds_bit2;
            pvalues[1].bit3 = "Slashed";
            pvalues[1].bit3hfname = hf_nds_bit3;
            pvalues[1].bit4 = "Dotted";
            pvalues[1].bit4hfname = hf_nds_bit4;
            pvalues[1].bit5 = "Tuned";
            pvalues[1].bit5hfname = hf_nds_bit5;
            pvalues[1].bit6 = "Not Defined";
            pvalues[1].bit6hfname = hf_nds_bit6;
            pvalues[1].bit7 = "Not Defined";
            pvalues[1].bit7hfname = hf_nds_bit7;
            pvalues[1].bit8 = "Not Defined";
            pvalues[1].bit8hfname = hf_nds_bit8;
            pvalues[1].bit9 = "Not Defined";
            pvalues[1].bit9hfname = hf_nds_bit9;
            pvalues[1].bit10 = "Not Defined";
            pvalues[1].bit10hfname = hf_nds_bit10;
            pvalues[1].bit11 = "Not Defined";
            pvalues[1].bit11hfname = hf_nds_bit11;
            pvalues[1].bit12 = "Not Defined";
            pvalues[1].bit12hfname = hf_nds_bit12;
            pvalues[1].bit13 = "Not Defined";
            pvalues[1].bit13hfname = hf_nds_bit13;
            pvalues[1].bit14 = "Not Defined";
            pvalues[1].bit14hfname = hf_nds_bit14;
            pvalues[1].bit15 = "Not Defined";
            pvalues[1].bit15hfname = hf_nds_bit15;
            pvalues[1].bit16 = "Not Defined";
            pvalues[1].bit16hfname = hf_nds_bit16;
            foffset = foffset + pvalues[1].vlength;
            pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[2].vtype = VTYPE_UINT32;
            pvalues[2].vdesc = "Iteration Handle: 0x%08x";
            pvalues[2].vlength = 4;
            pvalues[2].voffset = foffset;
            pvalues[2].hfname = hf_nds_iteration;
            foffset = foffset + pvalues[2].vlength;
            if (pvalues[0].vvalue == 0)
            {
                global_flags = 0x000000c0;
                break;
            }
            pvalues[3].vvalue = tvb_get_letohs(tvb, foffset);
            pvalues[3].vtype = VTYPE_BITFIELD;
            pvalues[3].vdesc = "Information Flags (low) Byte:";
            pvalues[3].vlength = 2;
            pvalues[3].hfname = hf_nds_rflags;
            pvalues[3].voffset = foffset;
            pvalues[3].bit1 = "Output Flags";
            pvalues[3].bit1hfname = hf_bit1l1flagsl;
            pvalues[3].bit2 = "Entry ID";
            pvalues[3].bit2hfname = hf_bit2l1flagsl;
            pvalues[3].bit3 = "Replica State";
            pvalues[3].bit3hfname = hf_bit3l1flagsl;
            pvalues[3].bit4 = "Modification Timestamp";
            pvalues[3].bit4hfname = hf_bit4l1flagsl;
            pvalues[3].bit5 = "Purge Time";
            pvalues[3].bit5hfname = hf_bit5l1flagsl;
            pvalues[3].bit6 = "Local Partition ID";
            pvalues[3].bit6hfname = hf_bit6l1flagsl;
            pvalues[3].bit7 = "Distinguished Name";
            pvalues[3].bit7hfname = hf_bit7l1flagsl;
            pvalues[3].bit8 = "Replica Type";
            pvalues[3].bit8hfname = hf_bit8l1flagsl;
            pvalues[3].bit9 = "Partition Busy";
            pvalues[3].bit9hfname = hf_bit9l1flagsl;
            pvalues[3].bit10 = "Not Defined";
            pvalues[3].bit10hfname = hf_bit10l1flagsl;
            pvalues[3].bit11 = "Not Defined";
            pvalues[3].bit11hfname = hf_bit11l1flagsl;
            pvalues[3].bit12 = "Not Defined";
            pvalues[3].bit12hfname = hf_bit12l1flagsl;
            pvalues[3].bit13 = "Not Defined";
            pvalues[3].bit13hfname = hf_bit13l1flagsl;
            pvalues[3].bit14 = "Not Defined";
            pvalues[3].bit14hfname = hf_bit14l1flagsl;
            pvalues[3].bit15 = "Not Defined";
            pvalues[3].bit15hfname = hf_bit15l1flagsl;
            pvalues[3].bit16 = "Not Defined";
            pvalues[3].bit16hfname = hf_bit16l1flagsl;
            global_flags = pvalues[3].vvalue;
            foffset = foffset + 2;
            pvalues[4].vvalue = tvb_get_letohs(tvb, foffset);
            pvalues[4].vtype = VTYPE_BITFIELD;
            pvalues[4].vdesc = "Information Flags (high) Byte:";
            pvalues[4].vlength = 2;
            pvalues[4].hfname = hf_nds_rflags;
            pvalues[4].voffset = foffset;
            pvalues[4].bit1 = "Not Defined";
            pvalues[4].bit1hfname = hf_bit1l1flagsl;
            pvalues[4].bit2 = "Not Defined";
            pvalues[4].bit2hfname = hf_bit2l1flagsl;
            pvalues[4].bit3 = "Not Defined";
            pvalues[4].bit3hfname = hf_bit3l1flagsl;
            pvalues[4].bit4 = "Not Defined";
            pvalues[4].bit4hfname = hf_bit4l1flagsl;
            pvalues[4].bit5 = "Not Defined";
            pvalues[4].bit5hfname = hf_bit5l1flagsl;
            pvalues[4].bit6 = "Not Defined";
            pvalues[4].bit6hfname = hf_bit6l1flagsl;
            pvalues[4].bit7 = "Not Defined";
            pvalues[4].bit7hfname = hf_bit7l1flagsl;
            pvalues[4].bit8 = "Not Defined";
            pvalues[4].bit8hfname = hf_bit8l1flagsl;
            pvalues[4].bit9 = "Not Defined";
            pvalues[4].bit9hfname = hf_bit9l1flagsl;
            pvalues[4].bit10 = "Not Defined";
            pvalues[4].bit10hfname = hf_bit10l1flagsl;
            pvalues[4].bit11 = "Not Defined";
            pvalues[4].bit11hfname = hf_bit11l1flagsl;
            pvalues[4].bit12 = "Not Defined";
            pvalues[4].bit12hfname = hf_bit12l1flagsl;
            pvalues[4].bit13 = "Not Defined";
            pvalues[4].bit13hfname = hf_bit13l1flagsl;
            pvalues[4].bit14 = "Not Defined";
            pvalues[4].bit14hfname = hf_bit14l1flagsl;
            pvalues[4].bit15 = "Not Defined";
            pvalues[4].bit15hfname = hf_bit15l1flagsl;
            pvalues[4].bit16 = "Not Defined";
            pvalues[4].bit16hfname = hf_bit16l1flagsl;
            foffset = foffset + 2;
            if (pvalues[0].vvalue == 1)
            {
                break;
            }
            pvalues[5].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[5].vtype = VTYPE_UINT32;
            pvalues[5].vdesc = "Partition Root ID: 0x%08x";
            pvalues[5].vlength = 4;
            pvalues[5].voffset = foffset;
            pvalues[5].hfname = hf_nds_partition_root_id;
            foffset = foffset + pvalues[5].vlength;
            break;
        case 0x17:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].hfname = hf_nds_ver;
            pvalues[0].voffset = foffset;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[1].vtype = VTYPE_UINT32;
            pvalues[1].vdesc = "Flags: 0x%08x";
            pvalues[1].vlength = 4;
            pvalues[1].hfname = hf_nds_req_flags;
            pvalues[1].voffset = foffset;
            foffset = foffset + pvalues[1].vlength;
            pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[2].vtype = VTYPE_UINT32;
            pvalues[2].vdesc = "New Partition Root ID: 0x%08x";
            pvalues[2].vlength = 4;
            pvalues[2].voffset = foffset;
            pvalues[2].hfname = hf_nds_new_part_id;
            foffset = foffset + pvalues[2].vlength;
            break;
        case 0x18:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].hfname = hf_nds_ver;
            pvalues[0].voffset = foffset;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[1].vtype = VTYPE_UINT32;
            pvalues[1].vdesc = "Flags: 0x%08x";
            pvalues[1].vlength = 4;
            pvalues[1].hfname = hf_nds_req_flags;
            pvalues[1].voffset = foffset;
            foffset = foffset + pvalues[1].vlength;
            pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[2].vtype = VTYPE_UINT32;
            pvalues[2].vdesc = "Child Partition Root ID: 0x%08x";
            pvalues[2].vlength = 4;
            pvalues[2].voffset = foffset;
            pvalues[2].hfname = hf_nds_child_part_id;
            foffset = foffset + pvalues[2].vlength;
            break;
        case 0x19:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].hfname = hf_nds_ver;
            pvalues[0].voffset = foffset;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[1].vtype = VTYPE_UINT32;
            pvalues[1].vdesc = "Flags: 0x%08x";
            pvalues[1].vlength = 4;
            pvalues[1].hfname = hf_nds_req_flags;
            pvalues[1].voffset = foffset;
            foffset = foffset + pvalues[1].vlength;
            pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[2].vtype = VTYPE_UINT32;
            pvalues[2].vdesc = "Master Partition Root ID: 0x%08x";
            pvalues[2].vlength = 4;
            pvalues[2].voffset = foffset;
            pvalues[2].hfname = hf_nds_master_part_id;
            foffset = foffset + pvalues[2].vlength;
            pvalues[3].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[3].vstring = (char *)match_strval(pvalues[3].vvalue, nds_replica_type);
            if (pvalues[3].vstring == NULL)
            {
                pvalues[3].vstring = "No Replica Type Found";
            }
            pvalues[3].vtype = VTYPE_STRING;
            pvalues[3].vdesc = "Replica Type: %s";
            pvalues[3].vlength = 4;
            pvalues[3].voffset = foffset;
            pvalues[3].mvtype = 0;
            pvalues[3].hfname = hf_replica_type;
            foffset = foffset + pvalues[3].vlength;
            pvalues[4].vtype = VTYPE_STRING;
            pvalues[4].vdesc = "Target Server Name: %s";
            pvalues[4].mvtype = 0;
            pvalues[4].vvalue = 0;
            pvalues[4].vlength = 256;
            pvalues[4].vlength = tvb_get_letohl(tvb, foffset);
            if (pvalues[4].vlength == 0x00 && !tvb_bytes_exist(tvb, foffset, pvalues[4].vlength))
            {
                pvalues[4].vtype = VTYPE_NONE;
                break;
            }
            pvalues[4].voffset = foffset + 4;
            foffset = foffset + 4;
            pvalues[4].vstring = get_string(tvb, pvalues[4].voffset, pvalues[4].vlength);
            pvalues[4].hfname = hf_nds_target_name;
            break;
        case 0x1a:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x1b:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].hfname = hf_nds_ver;
            pvalues[0].voffset = foffset;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[1].vtype = VTYPE_UINT32;
            pvalues[1].vdesc = "Streams Flags: 0x%08x";
            pvalues[1].vlength = 4;
            pvalues[1].hfname = hf_nds_stream_flags;
            pvalues[1].voffset = foffset;
            foffset = foffset + pvalues[1].vlength;
            pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[2].vtype = VTYPE_UINT32;
            pvalues[2].vdesc = "Entry ID: 0x%08x";
            pvalues[2].vlength = 4;
            resolve_eid = TRUE;
            global_eid = pvalues[2].vvalue;
            pvalues[2].voffset = foffset;
            pvalues[2].hfname = hf_nds_eid;
            foffset = foffset + pvalues[2].vlength;
            pvalues[3].vtype = VTYPE_STRING;
            pvalues[3].vdesc = "Stream Name: %s";
            pvalues[3].mvtype = MVTYPE_ATTR_REQUEST;
            pvalues[3].vvalue = 0;
            pvalues[3].vlength = 256;
            pvalues[3].vlength = tvb_get_letohl(tvb, foffset);
            if (pvalues[3].vlength == 0x00 || !tvb_bytes_exist(tvb, foffset, pvalues[3].vlength))
            {
                pvalues[3].vtype = VTYPE_NONE;
                break;
            }
            pvalues[3].voffset = foffset + 4;
            foffset += 4;
            pvalues[3].vstring = get_string(tvb, pvalues[3].voffset, pvalues[3].vlength);
            foffset += pvalues[3].vlength;
            foffset += align_4(tvb, foffset);
            pvalues[3].hfname = hf_nds_stream_name;
            break;
        case 0x1c:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x1d:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x1e:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x1f:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x20:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x21:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x22:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x23:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x24:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x25:
            pvalues[0].vtype = VTYPE_NONE;
        case 0x26:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].hfname = hf_nds_ver;
            pvalues[0].voffset = foffset;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[1].vtype = VTYPE_UINT32;
            pvalues[1].vdesc = "Flags: 0x%08x";
            pvalues[1].vlength = 4;
            pvalues[1].hfname = hf_nds_req_flags;
            pvalues[1].voffset = foffset;
            foffset = foffset + pvalues[1].vlength;
            pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[2].vtype = VTYPE_UINT32;
            pvalues[2].vdesc = "Time Delay in Seconds: %u";
            pvalues[2].vlength = 4;
            pvalues[2].voffset = foffset;
            pvalues[2].hfname = hf_nds_time_delay;
            foffset = foffset + pvalues[2].vlength;
            if (pvalues[0].vvalue == 0)
            {
                pvalues[3].vtype = VTYPE_STRING;
                pvalues[3].vdesc = "Root Most Object Name: %s";
                pvalues[3].mvtype = MVTYPE_ATTR_REQUEST;
                pvalues[3].vvalue = 0;
                pvalues[3].vlength = 256;
                pvalues[3].vlength = tvb_get_letohl(tvb, foffset);
                if (pvalues[3].vlength == 0x00 || !tvb_bytes_exist(tvb, foffset, pvalues[3].vlength))
                {
                    pvalues[3].vtype = VTYPE_NONE;
                    break;
                }
                pvalues[3].voffset = foffset + 4;
                foffset += 4;
                pvalues[3].vstring = get_string(tvb, pvalues[3].voffset, pvalues[3].vlength);
                foffset += pvalues[3].vlength;
                foffset += align_4(tvb, foffset);
                pvalues[3].hfname = hf_nds_root_name;
            }
            else
            {
                pvalues[3].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[3].vtype = VTYPE_UINT32;
                pvalues[3].vdesc = "Entry ID: 0x%08x";
                pvalues[3].vlength = 4;
                resolve_eid = TRUE;
                global_eid = pvalues[3].vvalue;
                pvalues[3].voffset = foffset;
                pvalues[3].hfname = hf_nds_eid;
                foffset = foffset + pvalues[3].vlength;
                resolve_eid = TRUE;
                global_eid = pvalues[3].vvalue;
            }
            break;
        case 0x27:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x28:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x29:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x2a:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].hfname = hf_nds_ver;
            pvalues[0].voffset = foffset;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[1].vtype = VTYPE_UINT32;
            pvalues[1].vdesc = "Flags: 0x%08x";
            pvalues[1].vlength = 4;
            pvalues[1].hfname = hf_nds_req_flags;
            pvalues[1].voffset = foffset;
            foffset = foffset + pvalues[1].vlength;
            pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[2].vtype = VTYPE_UINT32;
            pvalues[2].vdesc = "Destination Parent Entry ID: 0x%08x";
            pvalues[2].vlength = 4;
            resolve_eid = TRUE;
            global_eid = pvalues[2].vvalue;
            pvalues[2].voffset = foffset;
            pvalues[2].hfname = hf_nds_eid;
            foffset = foffset + pvalues[2].vlength;
            resolve_eid = TRUE;
            global_eid = pvalues[2].vvalue;
            pvalues[3].vtype = VTYPE_STRING;
            pvalues[3].vdesc = "New RDN: %s";
            pvalues[3].mvtype = 0;
            pvalues[3].vvalue = 0;
            pvalues[3].vlength = 256;
            pvalues[3].vlength = tvb_get_letohl(tvb, foffset);
            pvalues[3].voffset = foffset + 4;
            foffset = foffset + 4;
            pvalues[3].vstring = get_string(tvb, pvalues[3].voffset, pvalues[3].vlength);
            pvalues[3].hfname = hf_nds_new_rdn;
            foffset = foffset + pvalues[3].vlength;
            foffset += align_4(tvb, foffset);
            pvalues[4].vtype = VTYPE_STRING;
            pvalues[4].vdesc = "Source Server Name: %s";
            pvalues[4].mvtype = 0;
            pvalues[4].vvalue = 0;
            pvalues[4].vlength = 256;
            pvalues[4].vlength = tvb_get_letohl(tvb, foffset);
            if (pvalues[4].vlength == 0x00 || !tvb_bytes_exist(tvb, foffset, pvalues[3].vlength))
            {
                pvalues[4].vtype = VTYPE_NONE;
                break;
            }
            pvalues[4].voffset = foffset + 4;
            foffset = foffset + 4;
            pvalues[4].vstring = get_string(tvb, pvalues[4].voffset, pvalues[4].vlength);
            pvalues[4].hfname = hf_nds_target_name;
            break;
        case 0x2b:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].hfname = hf_nds_ver;
            pvalues[0].voffset = foffset;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[1].vtype = VTYPE_UINT32;
            pvalues[1].vdesc = (char *)match_strval(pvalues[1].vvalue, nds_verb2b_flag_vals);
            if (pvalues[1].vdesc == NULL)
            {
                pvalues[1].vdesc = "No Flag Definition Found";
            }
            pvalues[1].vlength = 4;
            pvalues[1].hfname = hf_nds_verb2b_req_flags;
            pvalues[1].voffset = foffset;
            foffset = foffset + pvalues[1].vlength;
            pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[2].vtype = VTYPE_UINT32;
            pvalues[2].vdesc = "Source Entry ID: 0x%08x";
            pvalues[2].vlength = 4;
            resolve_eid = TRUE;
            global_eid = pvalues[2].vvalue;
            pvalues[2].voffset = foffset;
            pvalues[2].hfname = hf_nds_eid;
            foffset = foffset + pvalues[2].vlength;
            pvalues[3].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[3].vtype = VTYPE_UINT32;
            pvalues[3].vdesc = "Destination Parent Entry ID: 0x%08x";
            pvalues[3].vlength = 4;
            pvalues[3].voffset = foffset;
            pvalues[3].hfname = hf_nds_eid;
            foffset = foffset + pvalues[3].vlength;
            pvalues[4].vtype = VTYPE_STRING;
            pvalues[4].vdesc = "New RDN: %s";
            pvalues[4].mvtype = 0;
            pvalues[4].vvalue = 0;
            pvalues[4].vlength = 256;
            pvalues[4].vlength = tvb_get_letohl(tvb, foffset);
            pvalues[4].voffset = foffset + 4;
            foffset = foffset + 4;
            pvalues[4].vstring = get_string(tvb, pvalues[4].voffset, pvalues[4].vlength);
            pvalues[4].hfname = hf_nds_new_rdn;
            foffset = foffset + pvalues[4].vlength;
            foffset += align_4(tvb, foffset);
            pvalues[5].vtype = VTYPE_STRING;
            pvalues[5].vdesc = "Source Server Name: %s";
            pvalues[5].mvtype = 0;
            pvalues[5].vvalue = 0;
            pvalues[5].vlength = 256;
            pvalues[5].vlength = tvb_get_letohl(tvb, foffset);
            if (pvalues[5].vlength == 0x00 || !tvb_bytes_exist(tvb, foffset, pvalues[3].vlength))
            {
                pvalues[5].vtype = VTYPE_NONE;
                break;
            }
            pvalues[5].voffset = foffset + 4;
            foffset = foffset + 4;
            pvalues[5].vstring = get_string(tvb, pvalues[5].voffset, pvalues[5].vlength);
            pvalues[5].hfname = hf_nds_target_name;
            break;
        case 0x2c:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x2d:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x2e:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x2f:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x30:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x31:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x32:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].hfname = hf_nds_ver;
            pvalues[0].voffset = foffset;
            foffset = foffset + pvalues[0].vlength;
            pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[2].vtype = VTYPE_UINT32;
            pvalues[2].vdesc = "Iteration Handle: 0x%08x";
            pvalues[2].vlength = 4;
            pvalues[2].voffset = foffset;
            pvalues[2].hfname = hf_nds_iteration;
            foffset = foffset + pvalues[2].vlength;
            pvalues[3].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[3].vtype = VTYPE_STRING;
            pvalues[3].vdesc = "NDS Verb: %s";
            pvalues[3].vstring = (char *)match_strval(pvalues[3].vvalue, ncp_nds_verb_vals);
            pvalues[3].vlength = 4;
            pvalues[3].voffset = foffset;
            pvalues[3].hfname = hf_mv_string;
            foffset = foffset + pvalues[3].vlength;
            break;
        case 0x33:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x34:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x35:
            if (nds_version != 0)
            {
                pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
                pvalues[0].vtype = VTYPE_UINT32;
                pvalues[0].vdesc = "Version: %u";
                pvalues[0].vlength = 4;
                pvalues[0].hfname = hf_nds_ver;
                pvalues[0].voffset = foffset;
                foffset = foffset + pvalues[0].vlength;
                pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
                global_flags = pvalues[1].vvalue;
                pvalues[1].vtype = VTYPE_BITFIELD;
                pvalues[1].vdesc = "Request Flags:";
                pvalues[1].vlength = 2;
                pvalues[1].hfname = hf_nds_rflags;
                pvalues[1].voffset = foffset;
                pvalues[1].bit1 = "Typeless";
                pvalues[1].bit1hfname = hf_bit1rflags;
                pvalues[1].bit2 = "Slashed";
                pvalues[1].bit2hfname = hf_bit2rflags;
                pvalues[1].bit3 = "Dotted";
                pvalues[1].bit3hfname = hf_bit3rflags;
                pvalues[1].bit4 = "Tuned";
                pvalues[1].bit4hfname = hf_bit4rflags;
                pvalues[1].bit5 = "Not Defined";
                pvalues[1].bit5hfname = hf_bit5rflags;
                pvalues[1].bit6 = "Not Defined";
                pvalues[1].bit6hfname = hf_bit6rflags;
                pvalues[1].bit7 = "Not Defined";
                pvalues[1].bit7hfname = hf_bit7rflags;
                pvalues[1].bit8 = "Not Defined";
                pvalues[1].bit8hfname = hf_bit8rflags;
                pvalues[1].bit9 = "Not Defined";
                pvalues[1].bit9hfname = hf_bit9rflags;
                pvalues[1].bit10 = "Not Defined";
                pvalues[1].bit10hfname = hf_bit10rflags;
                pvalues[1].bit11 = "Not Defined";
                pvalues[1].bit11hfname = hf_bit11rflags;
                pvalues[1].bit12 = "Not Defined";
                pvalues[1].bit12hfname = hf_bit12rflags;
                pvalues[1].bit13 = "Not Defined";
                pvalues[1].bit13hfname = hf_bit13rflags;
                pvalues[1].bit14 = "Not Defined";
                pvalues[1].bit14hfname = hf_bit14rflags;
                pvalues[1].bit15 = "Not Defined";
                pvalues[1].bit15hfname = hf_bit15rflags;
                pvalues[1].bit16 = "Not Defined";
                pvalues[1].bit16hfname = hf_bit16rflags;
            }
            break;
        case 0x36:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x37:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x38:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x39:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].voffset = foffset;
            pvalues[0].hfname = hf_nds_ver;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[1].vtype = VTYPE_UINT32;
            pvalues[1].vdesc = "Entry ID: 0x%08x";
            pvalues[1].vlength = 4;
            resolve_eid = TRUE;
            global_eid = pvalues[1].vvalue;
            pvalues[1].voffset = foffset;
            pvalues[1].hfname = hf_nds_eid;
            foffset = foffset + pvalues[1].vlength;
            break;
        case 0x3a:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Reply Buffer Size: %u";
            pvalues[0].vlength = 4;
            pvalues[0].voffset = foffset;
            pvalues[0].hfname = hf_nds_buffer_size;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[1].vtype = VTYPE_UINT32;
            pvalues[1].vdesc = "Version: %u";
            pvalues[1].vlength = 4;
            pvalues[1].voffset = foffset;
            pvalues[1].hfname = hf_nds_ver;
            foffset = foffset + pvalues[1].vlength;
            pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[2].vtype = VTYPE_UINT32;
            pvalues[2].vdesc = "Entry ID: 0x%08x";
            pvalues[2].vlength = 4;
            resolve_eid = TRUE;
            global_eid = pvalues[2].vvalue;
            pvalues[2].voffset = foffset;
            pvalues[2].hfname = hf_nds_eid;
            foffset = foffset + pvalues[2].vlength;
            break;
        case 0x3b:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].voffset = foffset;
            pvalues[0].hfname = hf_nds_ver;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[1].vtype = VTYPE_UINT32;
            pvalues[1].vdesc = "Entry ID: 0x%08x";
            pvalues[1].vlength = 4;
            resolve_eid = TRUE;
            global_eid = pvalues[1].vvalue;
            pvalues[1].voffset = foffset;
            pvalues[1].hfname = hf_nds_eid;
            foffset = foffset + pvalues[1].vlength;
            break;
        case 0x3c:
            break;
        case 0x3d:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x3e:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x3f:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x40:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x41:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x42:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x43:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x44:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x45:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x46:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x47:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x48:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x49:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x4a:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x4b:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x4c:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x4d:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        case 0x6e:
            pvalues[0].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[0].vtype = VTYPE_UINT32;
            pvalues[0].vdesc = "Version: %u";
            pvalues[0].vlength = 4;
            pvalues[0].hfname = hf_nds_ver;
            pvalues[0].voffset = foffset;
            foffset = foffset + pvalues[0].vlength;
            pvalues[1].vvalue = tvb_get_letohl(tvb, foffset);
            global_flags = pvalues[1].vvalue;
            pvalues[1].vtype = VTYPE_BITFIELD;
            pvalues[1].vdesc = "Request Flags:";
            pvalues[1].vlength = 2;
            pvalues[1].hfname = hf_nds_rflags;
            pvalues[1].voffset = foffset;
            pvalues[1].bit1 = "Typeless";
            pvalues[1].bit1hfname = hf_bit1rflags;
            pvalues[1].bit2 = "Slashed";
            pvalues[1].bit2hfname = hf_bit2rflags;
            pvalues[1].bit3 = "Dotted";
            pvalues[1].bit3hfname = hf_bit3rflags;
            pvalues[1].bit4 = "Tuned";
            pvalues[1].bit4hfname = hf_bit4rflags;
            pvalues[1].bit5 = "Not Defined";
            pvalues[1].bit5hfname = hf_bit5rflags;
            pvalues[1].bit6 = "Not Defined";
            pvalues[1].bit6hfname = hf_bit6rflags;
            pvalues[1].bit7 = "Not Defined";
            pvalues[1].bit7hfname = hf_bit7rflags;
            pvalues[1].bit8 = "Not Defined";
            pvalues[1].bit8hfname = hf_bit8rflags;
            pvalues[1].bit9 = "Not Defined";
            pvalues[1].bit9hfname = hf_bit9rflags;
            pvalues[1].bit10 = "Not Defined";
            pvalues[1].bit10hfname = hf_bit10rflags;
            pvalues[1].bit11 = "Not Defined";
            pvalues[1].bit11hfname = hf_bit11rflags;
            pvalues[1].bit12 = "Not Defined";
            pvalues[1].bit12hfname = hf_bit12rflags;
            pvalues[1].bit13 = "Not Defined";
            pvalues[1].bit13hfname = hf_bit13rflags;
            pvalues[1].bit14 = "Not Defined";
            pvalues[1].bit14hfname = hf_bit14rflags;
            pvalues[1].bit15 = "Not Defined";
            pvalues[1].bit15hfname = hf_bit15rflags;
            pvalues[1].bit16 = "Not Defined";
            pvalues[1].bit16hfname = hf_bit16rflags;
            foffset = foffset + pvalues[1].vlength + 2;
            pvalues[2].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[2].vtype = VTYPE_UINT32;
            pvalues[2].vdesc = "Iteration Handle: 0x%08x";
            pvalues[2].vlength = 4;
            pvalues[2].voffset = foffset;
            pvalues[2].hfname = hf_nds_iteration;
            foffset = foffset + pvalues[2].vlength;
            pvalues[3].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[3].vtype = VTYPE_UINT32;
            pvalues[3].vdesc = "Base Entry ID: 0x%08x";
            pvalues[3].vlength = 4;
            resolve_eid = TRUE;
            global_eid = pvalues[3].vvalue;
            pvalues[3].voffset = foffset;
            pvalues[3].hfname = hf_nds_eid;
            foffset = foffset + pvalues[3].vlength;
            pvalues[4].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[4].vtype = VTYPE_UINT32;
            pvalues[4].vdesc = (char *)match_strval(pvalues[4].vvalue, nds_scope_vals);
            if (pvalues[4].vdesc == NULL)
            {
                pvalues[4].vdesc = "Unknown Scope Defined";
            }
            pvalues[4].vlength = 4;
            pvalues[4].hfname = hf_nds_scope;
            pvalues[4].voffset = foffset;
            foffset = foffset + pvalues[4].vlength;
            pvalues[5].vvalue = tvb_get_letohl(tvb, foffset);
            pvalues[5].vtype = VTYPE_MULTIVALUE_UINT32;
            pvalues[5].vdesc = "Iterator: 0x%08x";
            pvalues[5].vlength = 4;
            pvalues[5].voffset = foffset;
            pvalues[5].hfname = hf_nds_iterator;
            pvalues[5].mvtype = MVTYPE_PROCESS_ITERATOR;
            foffset = foffset + pvalues[5].vlength;
            break;
        default:
            pvalues[0].vtype = VTYPE_NONE;
            break;
        }
    }
    if (check_col(pinfo->cinfo, COL_INFO))
    {
        if (ncp_rec)
        {
            col_set_str(pinfo->cinfo, COL_PROTOCOL, "NDS");
            if (nds_frag != 0xffffffff)
            {
                col_add_fstr(pinfo->cinfo, COL_INFO, "C Continue NDS Fragment 0x%08x", nds_frag);
            }
            else
            {
                col_add_fstr(pinfo->cinfo, COL_INFO, "C NDS %s", verb_string);
            }
            run_info_str = TRUE;
        }
        else
        {
            col_add_fstr(pinfo->cinfo, COL_INFO,
                         "C Unknown Function %d (0x%02x)",
                         func, func);
        }
    }

    conversation = find_conversation(pinfo->fd->num, &pinfo->src, &pinfo->dst,
                                     PT_NCP, nw_connection, nw_connection, 0);
    if (conversation == NULL)
    {
        conversation = conversation_new(pinfo->fd->num, &pinfo->src, &pinfo->dst,
                                        PT_NCP, nw_connection, nw_connection, 0);
    }

    if (!pinfo->fd->flags.visited)
    {
        request_value = ncp_hash_insert(conversation, sequence, ncp_rec);
        request_value->req_frame_num = pinfo->fd->num;
        request_value->req_frame_time = pinfo->fd->abs_ts;
        if (ncp_rec && !ncp_tree)
        {
            run_req_cond = TRUE;
        }
        request_value->nds_frag_num = nds_frag;
    }

    if ((run_info_str || run_req_cond) && !ncp_tree)
    {
        proto_item *ti;

        temp_tree = proto_tree_create_root();
        proto_tree_set_visible(temp_tree, FALSE);
        ti = proto_tree_add_item(temp_tree, proto_ncp, tvb, 0, -1, FALSE);
        ncp_tree = proto_item_add_subtree(ti, ett_ncp);
    }

    if (ncp_tree)
    {
        CLEANUP_PUSH(free_proto_tree, temp_tree);

#ifdef FAKE_TREE_IS_VISIBLE
        PTREE_DATA(ncp_tree)->visible = 1;
#endif

        request_value = ncp_hash_lookup(conversation, sequence);
        switch (type)
        {
        case NCP_BROADCAST_SLOT:;
            break;

        case NCP_SERVICE_REQUEST:

            ptvc = ptvcursor_new(ncp_tree, tvb, 7);
            if (ncp_rec && ncp_rec->request_ptvc)
            {
                clear_repeat_vars();
                process_ptvc_record(ptvc, ncp_rec->request_ptvc, NULL, TRUE, ncp_rec);
            }
            proto_tree_add_uint_format(ncp_tree, hf_ncp_func, tvb, 6, 1,
                                       func, "Function: %d (0x%02X), %s",
                                       func, func, ncp_rec ? ncp_rec->name : "Unknown");

            proto_tree_add_uint_format(ncp_tree, hf_ncp_subfunc, tvb, 7, 1,
                                       subfunc, "SubFunction: %d (0x%02x)",
                                       subfunc, subfunc);

            proto_tree_add_uint(ncp_tree, hf_ncp_fragment_handle, tvb, 8, 4,
                                nds_frag);

            if (nds_frag == 0xffffffff)
            {

                proto_tree_add_item(ncp_tree, hf_ncp_fragment_size, tvb, 12, 4, TRUE);

                proto_tree_add_item(ncp_tree, hf_ncp_message_size, tvb, 16, 4, TRUE);

                nds_prot_flags = tvb_get_letohs(tvb, 22);
                prot_flags[0].vvalue = nds_prot_flags;
                prot_flags[0].vtype = VTYPE_BITFIELD;
                prot_flags[0].vdesc = "NDS Protocol Flags:";
                prot_flags[0].vlength = 2;
                prot_flags[0].hfname = hf_ncp_nds_flag;
                prot_flags[0].voffset = 22;
                prot_flags[0].bit1 = "Not Defined";
                prot_flags[0].bit1hfname = hf_ndsprot1flag;
                prot_flags[0].bit2 = "Not Defined";
                prot_flags[0].bit2hfname = hf_ndsprot2flag;
                prot_flags[0].bit3 = "Not Defined";
                prot_flags[0].bit3hfname = hf_ndsprot3flag;
                prot_flags[0].bit4 = "Not Defined";
                prot_flags[0].bit4hfname = hf_ndsprot4flag;
                prot_flags[0].bit5 = "Not Defined";
                prot_flags[0].bit5hfname = hf_ndsprot5flag;
                prot_flags[0].bit6 = "Not Defined";
                prot_flags[0].bit6hfname = hf_ndsprot6flag;
                prot_flags[0].bit7 = "Not Defined";
                prot_flags[0].bit7hfname = hf_ndsprot7flag;
                prot_flags[0].bit8 = "Not Defined";
                prot_flags[0].bit8hfname = hf_ndsprot8flag;
                prot_flags[0].bit9 = "Not Defined";
                prot_flags[0].bit9hfname = hf_ndsprot9flag;
                prot_flags[0].bit10 = "Not Defined";
                prot_flags[0].bit10hfname = hf_ndsprot10flag;
                prot_flags[0].bit11 = "Not Defined";
                prot_flags[0].bit11hfname = hf_ndsprot11flag;
                prot_flags[0].bit12 = "Not Defined";
                prot_flags[0].bit12hfname = hf_ndsprot12flag;
                prot_flags[0].bit13 = "Not Defined";
                prot_flags[0].bit13hfname = hf_ndsprot13flag;
                prot_flags[0].bit14 = "Not Defined";
                prot_flags[0].bit14hfname = hf_ndsprot14flag;
                prot_flags[0].bit15 = "Include CRC in NDS Header";
                prot_flags[0].bit15hfname = hf_ndsprot15flag;
                prot_flags[0].bit16 = "Client is a Server";
                prot_flags[0].bit16hfname = hf_ndsprot16flag;

                process_bitfield(ncp_tree, tvb, &prot_flags[0]);

                if (nds_version == 0)
                {
                    proto_tree_add_uint_format(ncp_tree, hf_ncp_nds_verb, tvb, 24, 4,
                                               nds_verb, "NDS Verb: %d, (0x%02x), %s",
                                               nds_verb, nds_verb, verb_string);
                }
                else
                {
                    proto_tree_add_uint_format(ncp_tree, hf_ncp_nds_verb, tvb, 32, 4,
                                               nds_verb, "NDS Verb: %d, (0x%02x), %s",
                                               nds_verb, nds_verb, verb_string);
                }
                added_arrow = FALSE;
                for (vulnerable_var = 0; vulnerable_var < 9; vulnerable_var++)
                {
                    switch (pvalues[vulnerable_var].vtype)
                    {

                    case VTYPE_NONE:
                        break;

                    case VTYPE_UINT8:
                        proto_tree_add_uint_format(ncp_tree, pvalues[vulnerable_var].hfname, tvb, pvalues[vulnerable_var].voffset,
                                                   pvalues[vulnerable_var].vlength, pvalues[vulnerable_var].vtype, "NDS Parameter not defined %u",
                                                   pvalues[vulnerable_var].vtype);
                        break;

                    case VTYPE_UINT16:
                        proto_tree_add_uint_format(ncp_tree, pvalues[vulnerable_var].hfname, tvb, pvalues[vulnerable_var].voffset,
                                                   pvalues[vulnerable_var].vlength, pvalues[vulnerable_var].vtype, "NDS Parameter not defined %u",
                                                   pvalues[vulnerable_var].vtype);
                        break;

                    case VTYPE_UINT32:
                        proto_tree_add_uint_format(ncp_tree, pvalues[vulnerable_var].hfname, tvb, pvalues[vulnerable_var].voffset,
                                                   pvalues[vulnerable_var].vlength, pvalues[vulnerable_var].vvalue, pvalues[vulnerable_var].vdesc,
                                                   pvalues[vulnerable_var].vvalue);
                        break;

                    case VTYPE_STRING:
                        proto_tree_add_string_format(ncp_tree, pvalues[vulnerable_var].hfname, tvb, pvalues[vulnerable_var].voffset,
                                                     pvalues[vulnerable_var].vlength, pvalues[vulnerable_var].vstring, pvalues[vulnerable_var].vdesc, pvalues[vulnerable_var].vstring);
                        if (pvalues[vulnerable_var].mvtype == MVTYPE_ATTR_REQUEST)
                        {

                            if (check_col(pinfo->cinfo, COL_INFO))
                            {
                                if (!added_arrow)
                                {
                                    col_append_str(pinfo->cinfo, COL_INFO, " -> ");
                                    added_arrow = TRUE;
                                }
                                col_append_str(pinfo->cinfo, COL_INFO, pvalues[vulnerable_var].vstring);
                            }
                        }
                        break;

                    case VTYPE_BITFIELD:
                        process_bitfield(ncp_tree, tvb, &pvalues[vulnerable_var]);
                        break;

                    case VTYPE_MULTIVALUE_UINT32:
                        process_multivalues(ncp_tree, tvb, pinfo, &pvalues[vulnerable_var]);
                        if (pvalues[vulnerable_var].mvtype == MVTYPE_PROC_ENTRY_SPECIFIERS)
                        {

                            g_strlcpy(global_object_name, mv_resolve_name_string, 256);
                        }
                        if (pvalues[vulnerable_var].mvtype == MVTYPE_ATTR_REQUEST || pvalues[vulnerable_var].mvtype == MVTYPE_PROC_ENTRY_SPECIFIERS || pvalues[vulnerable_var].mvtype == MVTYPE_PROCESS_ITERATOR)
                        {
                            if (check_col(pinfo->cinfo, COL_INFO))
                            {
                                col_append_str(pinfo->cinfo, COL_INFO, pvalues[vulnerable_var].vstring);
                                if (pvalues[vulnerable_var].mvtype != MVTYPE_PROCESS_ITERATOR)
                                {
                                    if (!added_arrow)
                                    {
                                        col_append_str(pinfo->cinfo, COL_INFO, " -> ");
                                        added_arrow = TRUE;
                                    }
                                    col_append_str(pinfo->cinfo, COL_INFO, mv_resolve_name_string);
                                }
                            }
                        }
                        break;

                    case VTYPE_BYTES:
                        proto_tree_add_bytes(ncp_tree, pvalues[vulnerable_var].hfname, tvb, pvalues[vulnerable_var].voffset,
                                             pvalues[vulnerable_var].vlength, tvb_get_ptr(tvb, pvalues[vulnerable_var].voffset, pvalues[vulnerable_var].vvalue));
                        break;

                    case VTYPE_BOOLEAN:
                        proto_tree_add_item(ncp_tree, pvalues[vulnerable_var].hfname, tvb, pvalues[vulnerable_var].voffset, pvalues[vulnerable_var].vlength, TRUE);
                        break;

                    default:
                        proto_tree_add_uint_format(ncp_tree, hf_nds_p1type, tvb, pvalues[vulnerable_var].voffset,
                                                   pvalues[vulnerable_var].vlength, pvalues[vulnerable_var].vtype, "NDS Parameter not defined %u",
                                                   pvalues[vulnerable_var].vtype);
                        break;
                    }
                }

                request_eid_value = ncp_eid_hash_lookup(conversation, global_eid);
                if (resolve_eid)
                {
                    if (request_eid_value)
                    {
                        g_strlcpy(global_object_name, request_eid_value->object_name, 256);
                        if (check_col(pinfo->cinfo, COL_INFO))
                        {
                            col_append_str(pinfo->cinfo, COL_INFO, ", Object Name - ");
                            col_append_str(pinfo->cinfo, COL_INFO, global_object_name);
                        }
                    }
                }
                if (request_value)
                {
                    request_value->nds_request_verb = nds_verb;
                    request_value->nds_version = nds_version;
                    g_strlcpy(request_value->object_name, global_object_name, 256);
                    request_value->req_nds_flags = global_flags;
                    request_value->req_nds_prot_flags = nds_prot_flags;
                }
            }
            break;

        default:;
            break;
        }
        if (ptvc)
            ptvcursor_free(ptvc);
        CLEANUP_CALL_AND_POP;
    }
}