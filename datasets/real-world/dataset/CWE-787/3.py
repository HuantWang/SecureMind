def test_concat_bytes32(get_contract_with_gas_estimation):
    test_concat_bytes32 = """
@external
def sandwich(inp: Bytes[100], inp2: bytes32) -> Bytes[164]:
    return concat(inp2, inp, inp2)

@external
def fivetimes(inp: bytes32) -> Bytes[160]:
    return concat(inp, inp, inp, inp, inp)
    """

    c = get_contract_with_gas_estimation(test_concat_bytes32)
    assert c.sandwich(b"cow", b"\x35" * 32) == b"\x35" * 32 + b"cow" + b"\x35" * 32, c.sandwich(
        b"cow", b"\x35" * 32
    )
    assert c.sandwich(b"", b"\x46" * 32) == b"\x46" * 64
    assert c.sandwich(b"\x57" * 95, b"\x57" * 32) == b"\x57" * 159
    assert c.sandwich(b"\x57" * 96, b"\x57" * 32) == b"\x57" * 160
    assert c.sandwich(b"\x57" * 97, b"\x57" * 32) == b"\x57" * 161
    assert c.fivetimes(b"mongoose" * 4) == b"mongoose" * 20

    print("Passed concat bytes32 test")


def test_konkat_code(get_contract_with_gas_estimation):
    konkat_code = """
ecks: bytes32

@external
def foo(x: bytes32, y: bytes32) -> Bytes[64]:
    self.ecks = x
    return concat(self.ecks, y)

@external
def goo(x: bytes32, y: bytes32) -> Bytes[64]:
    self.ecks = x
    return concat(self.ecks, y)

@external
def hoo(x: bytes32, y: bytes32) -> Bytes[64]:
    return concat(x, y)
    """

    c = get_contract_with_gas_estimation(konkat_code)
    assert c.foo(b"\x35" * 32, b"\x00" * 32) == b"\x35" * 32 + b"\x00" * 32
    assert c.goo(b"\x35" * 32, b"\x00" * 32) == b"\x35" * 32 + b"\x00" * 32
    assert c.hoo(b"\x35" * 32, b"\x00" * 32) == b"\x35" * 32 + b"\x00" * 32

    print("Passed second concat tests")


def test_small_output(get_contract_with_gas_estimation):
    code = """
@external
def small_output(a: String[5], b: String[4]) -> String[9]:
    c: String[9] = concat(a, b)
    return c
    """
    c = get_contract_with_gas_estimation(code)
    assert c.small_output("abcde", "fghi") == "abcdefghi"
    assert c.small_output("", "") == ""










class Concat(BuiltinFunctionT):
    _id = "concat"

    def fetch_call_return(self, node):
        arg_types = self.infer_arg_types(node)

        length = 0
        for arg_t in arg_types:
            length += arg_t.length

        if isinstance(arg_types[0], (StringT)):
            return_type = StringT()
        else:
            return_type = BytesT()
        return_type.set_length(length)
        return return_type

    def infer_arg_types(self, node, expected_return_typ=None):
        if len(node.args) < 2:
            raise ArgumentException("Invalid argument count: expected at least 2", node)

        if node.keywords:
            raise ArgumentException("Keyword arguments are not accepted here", node.keywords[0])

        ret = []
        prev_typeclass = None
        for arg in node.args:
            validate_expected_type(arg, (BytesT.any(), StringT.any(), BytesM_T.any()))
            arg_t = get_possible_types_from_node(arg).pop()
            current_typeclass = "String" if isinstance(arg_t, StringT) else "Bytes"
            if prev_typeclass and current_typeclass != prev_typeclass:
                raise TypeMismatch(
                    (
                        "Concat expects consistent use of string or bytes types, "
                        "use either string or bytes."
                    ),
                    arg,
                )
            prev_typeclass = current_typeclass
            ret.append(arg_t)

        return ret

    def build_IR(self, expr, context):
        args = [Expr(arg, context).ir_node for arg in expr.args]
        if len(args) < 2:
            raise StructureException("Concat expects at least two arguments", expr)

              dst_maxlen = sum(
            [arg.typ.maxlen if isinstance(arg.typ, _BytestringT) else arg.typ.m for arg in args]
        )

               if isinstance(args[0].typ, StringT):
            ret_typ = StringT(dst_maxlen)
        else:
            ret_typ = BytesT(dst_maxlen)

                dst = IRnode.from_list(
            context.new_internal_variable(ret_typ),
            typ=ret_typ,
            location=MEMORY,
            annotation="concat destination",
        )

        ret = ["seq"]
               ofst = "concat_ofst"

                for arg in args:
            dst_data = add_ofst(bytes_data_ptr(dst), ofst)

            if isinstance(arg.typ, _BytestringT):
                              if arg.typ.maxlen == 0:
                    continue

                with arg.cache_when_complex("arg") as (b1, arg):
                    argdata = bytes_data_ptr(arg)

                    with get_bytearray_length(arg).cache_when_complex("len") as (b2, arglen):
                        do_copy = [
                            "seq",
                            copy_bytes(dst_data, argdata, arglen, arg.typ.maxlen),
                            ["set", ofst, ["add", ofst, arglen]],
                        ]
                        ret.append(b1.resolve(b2.resolve(do_copy)))

            else:
                ret.append(STORE(dst_data, unwrap_location(arg)))
                ret.append(["set", ofst, ["add", ofst, arg.typ.m]])

        ret.append(STORE(dst, ofst))

               ret.append(dst)

        return IRnode.from_list(
            ["with", ofst, 0, ret], typ=ret_typ, location=MEMORY, annotation="concat"
        )
