def test_abi_decode_arithmetic_overflow(env, tx_failed, get_contract):
    code = """
@external
def f(x: Bytes[32 * 3]):
    a: Bytes[32] = b"foo"
    y: Bytes[32 * 3] = x

    decoded_y1: Bytes[32] = _abi_decode(y, Bytes[32])
    a = b"bar"
    decoded_y2: Bytes[32] = _abi_decode(y, Bytes[32])

    assert decoded_y1 != decoded_y2
    """
    c = get_contract(code)

    data = method_id("f(bytes)")
    payload = (
        0x20,  
        0x60,
        2**256 - 0x60,
    )
    data += _abi_payload_from_tuple(payload)

    with tx_failed():
        env.message_call(c.address, data=data)

def test_abi_decode_extcall_zero_len_array(get_contract):
    code = """
@external
def bar() -> (uint256, uint256):
    return 32, 0

interface A:
    def bar() -> DynArray[Bytes[32], 2]: nonpayable

@external
def run():
    x: DynArray[Bytes[32], 2] = extcall A(self).bar()
    """
    c = get_contract(code)

    c.run()



















def _abi_payload_size(ir_node):
    SCALE = ir_node.location.word_scale
    assert SCALE == 32 
    OFFSET = DYNAMIC_ARRAY_OVERHEAD * SCALE

    if isinstance(ir_node.typ, DArrayT):
       return ["add", OFFSET, ["mul", get_dyn_array_count(ir_node), SCALE]]

    if isinstance(ir_node.typ, _BytestringT):
        return ["add", OFFSET, get_bytearray_length(ir_node)]

    raise CompilerPanic("unreachable") 

def clamp_bytestring(ir_node, hi=None):
    t = ir_node.typ
    if not isinstance(t, _BytestringT):
        raise CompilerPanic(f"{t} passed to clamp_bytestring")

    with get_bytearray_length(ir_node).cache_when_complex("length") as (b1, length):
        len_check = ["assert", ["le", length, t.maxlen]]

        assert (hi is not None) == _dirty_read_risk(ir_node)
        if hi is not None and not t.abi_type.subtyp.is_dynamic():
            assert t.maxlen < 2**64  

            item_end = add_ofst(ir_node, _abi_payload_size(ir_node))

            len_check = ["seq", ["assert", ["le", item_end, hi]], len_check]

        return IRnode.from_list(b1.resolve(len_check), error_msg=f"{ir_node.typ} bounds check")

