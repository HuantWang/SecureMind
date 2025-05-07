oob_fail_list = [
    """
d: public(Bytes[256])

@external
def do_slice():
    x : uint256 = max_value(uint256)
    self.d = b"\x01\x02\x03\x04\x05\x06"
    assert len(slice(self.d, 1, x)) == max_value(uint256)
    """,
    """
@external
def do_slice():
    x: uint256 = max_value(uint256)
    # y == 0x3232323232323232323232323232323232323232323232323232323232323232
    y: uint256 = 22704331223003175573249212746801550559464702875615796870481879217237868556850
    z: uint96 = 1
    if True:
        placeholder : uint256[16] = [y, y, y, y, y, y, y, y, y, y, y, y, y, y, y, y]
    s: String[32] = slice(uint2str(z), 1, x)
    assert slice(s, 1, 2) == "22"
    """,
    """
x: public(Bytes[64])
secret: uint256

@deploy
def __init__():
    self.x = empty(Bytes[64])
    self.secret = 42

@external
def do_slice() -> Bytes[64]:
    start: uint256 = max_value(uint256) - 63
    return slice(self.x, start, 64)
    """,

    """
interface IFace:
    def choose_value(_x: uint256, _y: uint256, _z: uint256, idx: uint256) -> Bytes[32]: nonpayable

@external
def choose_value(_x: uint256, _y: uint256, _z: uint256, idx: uint256) -> Bytes[32]:
    assert idx % 32 == 4
    return slice(msg.data, idx, 32)

@external
def do_slice():
    idx: uint256 = max_value(uint256) - 27
    ret: uint256 = _abi_decode(extcall IFace(self).choose_value(1, 2, 3, idx), uint256)
    assert ret == 0
    """,
]


@pytest.mark.parametrize("bad_code", oob_fail_list)
def test_slice_buffer_oob_reverts(bad_code, get_contract, tx_failed):
    c = get_contract(bad_code)
    with tx_failed():
        c.do_slice()

def _make_slice_bounds_check(start, length, src_len):
    with start.cache_when_complex("start") as (b1, start):
        with add_ofst(start, length).cache_when_complex("end") as (b2, end):
            arithmetic_overflow = ["lt", end, start]
            buffer_oob = ["gt", end, src_len]
            ok = ["iszero", ["or", arithmetic_overflow, buffer_oob]]
            return b1.resolve(b2.resolve(["assert", ok]))
        
def _build_adhoc_slice_node(sub: IRnode, start: IRnode, length: IRnode, context: Context) -> IRnode:
    assert length.is_literal, "typechecker failed"
    assert isinstance(length.value, int) 

    dst_typ = BytesT(length.value)
    np = context.new_internal_variable(dst_typ)

   
    if sub.value == "~calldata":
        node = [
            "seq",
            _make_slice_bounds_check(start, length, "calldatasize"),
            ["mstore", np, length],
            ["calldatacopy", np + 32, start, length],
            np,
        ]

    elif sub.value == "~selfcode":
        node = [
            "seq",
            _make_slice_bounds_check(start, length, "codesize"),
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
                _make_slice_bounds_check(start, length, ["extcodesize", "_extcode_address"]),
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
                _make_slice_bounds_check(start, length, src_len),
                do_copy,
                ["mstore", dst, length], 
                dst,
            ]
            ret = IRnode.from_list(ret, typ=dst_typ, location=MEMORY)
            return b1.resolve(b2.resolve(b3.resolve(ret)))