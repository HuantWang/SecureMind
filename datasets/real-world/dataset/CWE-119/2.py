





def _build_adhoc_slice_node(sub: IRnode, start: IRnode, length: IRnode, context: Context) -> IRnode:
    assert length.is_literal, "typechecker failed"
    assert isinstance(length.value, int)  

    dst_typ = BytesT(length.value)
    np = context.new_internal_variable(dst_typ)

    if sub.value == "~calldata":
        node = [
            "seq",
            ["assert", ["le", ["add", start, length], "calldatasize"]],  # runtime bounds check
            ["mstore", np, length],
            ["calldatacopy", np + 32, start, length],
            np,
        ]

    elif sub.value == "~selfcode":
        node = [
            "seq",
            ["assert", ["le", ["add", start, length], "codesize"]],  # runtime bounds check
            ["mstore", np, length],
            ["codecopy", np + 32, start, length],
            np,
        ]

    else:
        assert sub.value == "~extcode" and len(sub.args) == 1
        node = [
            "with",
            "_extcode_address",
            sub.args[0],
            [
                "seq",
                ["assert", ["le", ["add", start, length], ["extcodesize", "_extcode_address"]]],
                ["mstore", np, length],
                ["extcodecopy", "_extcode_address", np + 32, start, length],
                np,
            ],
        ]

    assert isinstance(length.value, int) 
    return IRnode.from_list(node, typ=BytesT(length.value), location=MEMORY)

@process_inputs
def build_IR(self, expr, args, kwargs, context):
        src, start, length = args
        if src.value in ADHOC_SLICE_NODE_MACROS:
            return _build_adhoc_slice_node(src, start, length, context)

        is_bytes32 = src.typ == BYTES32_T
        if src.location is None:
            assert is_bytes32, src
            src = ensure_in_memory(src, context)

        with src.cache_when_complex("src") as (b1, src), start.cache_when_complex("start") as (
            b2,
            start,
        ), length.cache_when_complex("length") as (b3, length):
            if is_bytes32:
                src_maxlen = 32
            else:
                src_maxlen = src.typ.maxlen

            dst_maxlen = length.value if length.is_literal else src_maxlen

            buflen = dst_maxlen

            if src.location == STORAGE:
                buflen += 32

            assert isinstance(src.typ, _BytestringT) or is_bytes32
            if isinstance(src.typ, StringT):
                dst_typ = StringT(dst_maxlen)
            else:
                dst_typ = BytesT(dst_maxlen)

            buf = context.new_internal_variable(BytesT(buflen))
            dst = IRnode.from_list(buf, typ=dst_typ, location=MEMORY)

            dst_data = bytes_data_ptr(dst)

            if is_bytes32:
                src_len = 32
                src_data = src
            else:
                src_len = get_bytearray_length(src)
                src_data = bytes_data_ptr(src)

            if src.location == STORAGE:
                copy_src = IRnode.from_list(
                    ["add", src_data, ["div", start, 32]], location=src.location
                )

                copy_dst = IRnode.from_list(
                    ["sub", dst_data, ["mod", start, 32]], location=dst.location
                )

                copy_len = ["add", length, ["mul", 32, ["iszero", ["iszero", ["mod", start, 32]]]]]
                copy_maxlen = buflen

            else:

                copy_src = add_ofst(src_data, start)
                copy_dst = dst_data
                copy_len = length
                copy_maxlen = buflen

            do_copy = copy_bytes(copy_dst, copy_src, copy_len, copy_maxlen)

            ret = [
                "seq",
                 ["assert", ["le", ["add", start, length], src_len]],
                do_copy,
                ["mstore", dst, length],
                dst,
            ]
            ret = IRnode.from_list(ret, typ=dst_typ, location=MEMORY)
            return b1.resolve(b2.resolve(b3.resolve(ret)))
        
