def test_abi_decode_arithmetic_overflow(env, tx_failed, get_contract):
    code = """
@external
def f(x: Bytes[32 * 3]):
    a: Bytes[32] = b"foo"
    y: Bytes[32 * 3] = x

    decoded_y1: Bytes[32] = _abi_decode(y, Bytes[32])
    a = b"bar"
    decoded_y2: Bytes[32] = _abi_decode(y, Bytes[32])
    # original POC:
    # assert decoded_y1 != decoded_y2
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

def test_abi_decode_extcall_empty_array(get_contract):
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

def test_abi_decode_extcall_complex_empty_dynarray(get_contract):
    code = """
struct Point:
    x: uint256
    y: DynArray[uint256, 2]
    z: uint256

@external
def bar() -> (uint256, uint256, uint256, uint256, uint256, uint256):
    return 32, 1, 32, 1, 64, 0

interface A:
    def bar() -> DynArray[Point, 2]: nonpayable

@external
def run():
    x: DynArray[Point, 2] = extcall A(self).bar()
    assert len(x) == 1 and len(x[0].y) == 0
    """
    c = get_contract(code)

    c.run()

def test_abi_decode_extcall_complex_empty_dynarray2(tx_failed, get_contract):
    code = """
struct Point:
    x: uint256
    y: DynArray[uint256, 2]
    z: uint256

@external
def bar() -> (uint256, uint256):
    return 33, 0

interface A:
    def bar() -> DynArray[Point, 2]: nonpayable

@external
def run():
    x: DynArray[Point, 2] = extcall A(self).bar()
    """
    c = get_contract(code)

    with tx_failed():
        c.run()

def test_abi_decode_top_level_head_oob(tx_failed, get_contract):
    code = """
@external
def run(x: Bytes[256], y: uint256):
    player_lost: bool = empty(bool)

    if y == 1:
        player_lost = True

    decoded: DynArray[Bytes[1], 2] = empty(DynArray[Bytes[1], 2])
    decoded = _abi_decode(x, DynArray[Bytes[1], 2])
    """
    c = get_contract(code)

    payload = (0x0100, *_replicate(0x00, 7))

    data = _abi_payload_from_tuple(payload)

    with tx_failed():
        c.run(data, 1)

    with tx_failed():
        c.run(data, 0)

def test_abi_decode_dynarray_complex_insufficient_data(env, tx_failed, get_contract):
    code = """
struct Point:
    x: uint256
    y: uint256

@external
def run(x: Bytes[32 * 8]):
    y: Bytes[32 * 8] = x
    decoded_y1: DynArray[Point, 3] = _abi_decode(y, DynArray[Point, 3])
    """
    c = get_contract(code)

    payload = (0x20, 0x03, *_replicate(0x03, 3))

    data = _abi_payload_from_tuple(payload)

    with tx_failed():
        c.run(data)

def test_abi_decode_dynarray_complex2(env, tx_failed, get_contract):
    code = """
struct Point:
    x: uint256
    y: uint256
    z: uint256


@external
def run(x: Bytes[32 * 8]):
    y: Bytes[32 * 11] = x
    decoded_y1: DynArray[Point, 2] = _abi_decode(y, DynArray[Point, 2])
    """
    c = get_contract(code)

    payload = (
        0xC0, 
        *_replicate(0x03, 5),
        *_replicate(0x01, 2),
    )

    data = _abi_payload_from_tuple(payload)

    with tx_failed():
        c.run(data)

def test_abi_decode_complex_empty_dynarray(env, tx_failed, get_contract):
    code = """
struct Point:
    x: uint256
    y: DynArray[uint256, 2]
    z: uint256


@external
def run(x: Bytes[32 * 16]):
    y: Bytes[32 * 16] = x
    decoded_y1: DynArray[Point, 2] = _abi_decode(y, DynArray[Point, 2])
    assert len(decoded_y1) == 1 and len(decoded_y1[0].y) == 0
    """
    c = get_contract(code)

    payload = (
        0x20,
        0x01,
        0x20,
        0x01,
        0xA0,
        0x04,
        0x02,
        0x02,
        0x00, 
    )

    data = _abi_payload_from_tuple(payload)

    c.run(data)

def test_abi_decode_complex_arithmetic_overflow(tx_failed, get_contract):
    code = """
struct Point:
    x: uint256
    y: DynArray[uint256, 2]
    z: uint256


@external
def run(x: Bytes[32 * 16]):
    y: Bytes[32 * 16] = x
    decoded_y1: DynArray[Point, 2] = _abi_decode(y, DynArray[Point, 2])
    """
    c = get_contract(code)

    payload = (
        0x20,
        0x01,
        0x20,
        0x01, 
        2**256 - 0x20, 
        0x04,
        0x02,
        0x02,
        0x00,
    )

    data = _abi_payload_from_tuple(payload)

    with tx_failed():
        c.run(data)

def test_abi_decode_empty_toplevel_dynarray(get_contract):
    code = """
@external
def run(x: Bytes[2 * 32 + 3 * 32  + 3 * 32 * 4]):
    y: Bytes[2 * 32 + 3 * 32 + 3 * 32 * 4] = x
    assert len(y) == 2 * 32
    decoded_y1: DynArray[DynArray[uint256, 3], 3] = _abi_decode(
        y,
        DynArray[DynArray[uint256, 3], 3]
    )
    assert len(decoded_y1) == 0
    """
    c = get_contract(code)

    payload = (0x20, 0x00) 

    data = _abi_payload_from_tuple(payload)

    c.run(data)

def test_abi_decode_invalid_toplevel_dynarray_head(tx_failed, get_contract):
    code = """
@external
def run(x: Bytes[2 * 32 + 3 * 32  + 3 * 32 * 4]):
    y: Bytes[2 * 32 + 3 * 32 + 3 * 32 * 4] = x
    decoded_y1: DynArray[DynArray[uint256, 3], 3] = _abi_decode(
        y,
        DynArray[DynArray[uint256, 3], 3]
    )
    """
    c = get_contract(code)

    payload = (0x21, 0x00)

    data = _abi_payload_from_tuple(payload)

    with tx_failed():
        c.run(data)

def _abi_payload_size(ir_node):
    SCALE = ir_node.location.word_scale
    assert SCALE == 32 
    OFFSET = DYNAMIC_ARRAY_OVERHEAD * SCALE

    if isinstance(ir_node.typ, DArrayT):
        item_size = ir_node.typ.value_type.abi_type.static_size()
        if item_size == 0:
            return ["add", OFFSET, 0]
        return ["add", OFFSET, ["mul", get_dyn_array_count(ir_node), item_size]]

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
        if hi is not None:
            assert t.maxlen < 2**64  

            item_end = add_ofst(ir_node, _abi_payload_size(ir_node))

            len_check = ["seq", ["assert", ["le", item_end, hi]], len_check]

        return IRnode.from_list(b1.resolve(len_check), error_msg=f"{ir_node.typ} bounds check")

