def test_concat_buffer(get_contract):
       code = """
@internal
def bar() -> uint256:
    sss: String[2] = concat("a", "b")
    return 1


@external
def foo() -> int256:
    a: int256 = -1
    b: uint256 = self.bar()
    return a
    """
    c = get_contract(code)
    assert c.foo() == -1


def test_concat_buffer2(get_contract):
    # GHSA-2q8v-3gqq-4f8p
    code = """
i: immutable(int256)

@external
def __init__():
    i = -1
    s: String[2] = concat("a", "b")

@external
def foo() -> int256:
    return i
    """
    c = get_contract(code)
    assert c.foo() == -1


def test_concat_buffer3(get_contract):
       code = """
s: String[1]
s2: String[33]
s3: String[34]

@external
def __init__():
    self.s = "a"
    self.s2 = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" # 33*'a'

@internal
def bar() -> uint256:
    self.s3 = concat(self.s, self.s2)
    return 1

@external
def foo() -> int256:
    i: int256 = -1
    b: uint256 = self.bar()
    return i
    """
    c = get_contract(code)
    assert c.foo() == -1









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

                bufsize = dst_maxlen + 32
        buf = context.new_internal_variable(BytesT(bufsize))

                dst = IRnode.from_list(buf, typ=ret_typ, location=MEMORY, annotation="concat destination")

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
