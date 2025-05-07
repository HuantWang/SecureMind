import pytest
from vyper.evm.opcodes import version_check



import hypothesis.strategies as st
import pytest
from hypothesis import given, settings
from vyper.compiler import compile_code
from vyper.compiler.settings import OptimizationLevel, Settings
from vyper.evm.opcodes import version_check
from vyper.exceptions import ArgumentException, TypeMismatch



import hashlib
import math
import operator

from vyper import ast as vy_ast
from vyper.abi_types import ABI_Tuple
from vyper.ast.validation import validate_call_args
from vyper.codegen.abi_encoder import abi_encode
from vyper.codegen.context import Context, VariableRecord
from vyper.codegen.core import (
    LOAD,
    STORE,
    IRnode,
    add_ofst,
    bytes_data_ptr,
    calculate_type_for_external_return,
    check_buffer_overflow_ir,
    check_external_call,
    clamp,
    clamp2,
    clamp_basetype,
    clamp_nonzero,
    copy_bytes,
    dummy_node_for_type,
    ensure_eval_once,
    ensure_in_memory,
    eval_seq,
    get_bytearray_length,
    get_type_for_exact_size,
    ir_tuple_from_args,
    make_setter,
    promote_signed_int,
    sar,
    shl,
    shr,
    unwrap_location,
)
from vyper.codegen.expr import Expr
from vyper.codegen.ir_node import Encoding, scope_multi
from vyper.codegen.keccak256_helper import keccak256_helper
from vyper.evm.address_space import MEMORY
from vyper.evm.opcodes import version_check
from vyper.exceptions import (
    ArgumentException,
    CompilerPanic,
    EvmVersionException,
    InvalidLiteral,
    InvalidType,
    StateAccessViolation,
    StructureException,
    TypeMismatch,
    UnfoldableNode,
    ZeroDivisionException,
)
from vyper.semantics.analysis.base import Modifiability, VarInfo
from vyper.semantics.analysis.utils import (
    get_common_types,
    get_exact_type_from_node,
    get_possible_types_from_node,
    validate_expected_type,
)
from vyper.semantics.types import (
    TYPE_T,
    AddressT,
    BoolT,
    BytesM_T,
    BytesT,
    DArrayT,
    DecimalT,
    HashMapT,
    IntegerT,
    KwargSettings,
    SArrayT,
    StringT,
    TupleT,
)
from vyper.semantics.types.bytestrings import _BytestringT
from vyper.semantics.types.shortcuts import (
    BYTES4_T,
    BYTES32_T,
    INT128_T,
    INT256_T,
    UINT8_T,
    UINT256_T,
)
from vyper.semantics.types.utils import type_from_annotation
from vyper.utils import (
    DECIMAL_DIVISOR,
    EIP_170_LIMIT,
    SHA3_PER_WORD,
    MemoryPositions,
    bytes_to_int,
    ceil32,
    fourbytes_to_int,
    keccak256,
    method_id,
    method_id_int,
    vyper_warn,
)

from ._convert import convert
from ._signatures import BuiltinFunctionT, process_inputs

SHA256_ADDRESS = 2
SHA256_BASE_GAS = 60
SHA256_PER_WORD_GAS = 12

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

            if src.location.word_addressable:
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

            if src.location.word_addressable:
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
                check_buffer_overflow_ir(start, length, src_len),
                do_copy,
                ["mstore", dst, length],
                dst, 
            ]
            ret = IRnode.from_list(ret, typ=dst_typ, location=MEMORY)
            return b1.resolve(b2.resolve(b3.resolve(ret)))
        
@process_inputs
def build_IR(self, expr, args, kwargs, context):
        bytez, index = args
        ret_type = kwargs["output_type"]

        def finalize(ret):
            annotation = "extract32"
            ret = IRnode.from_list(ret, typ=ret_type, annotation=annotation)
            return clamp_basetype(ret)

        with bytez.cache_when_complex("_sub") as (b1, bytez):
            length = get_bytearray_length(bytez)
            index = clamp2(0, index, ["sub", length, 32], signed=True)
            with index.cache_when_complex("_index") as (b2, index):
                assert not index.typ.is_signed
                if bytez.location.word_scale == 32:
                    word = LOAD(add_ofst(bytes_data_ptr(bytez), index))
                    return finalize(b1.resolve(b2.resolve(word)))
                assert bytez.location.word_scale == 1

                slot = IRnode.from_list(["div", index, 32])
                byte_ofst = IRnode.from_list(["mod", index, 32])

                with byte_ofst.cache_when_complex("byte_ofst") as (
                    b3,
                    byte_ofst,
                ), slot.cache_when_complex("slot") as (b4, slot):
                    w1 = LOAD(add_ofst(bytes_data_ptr(bytez), slot))
                    w2 = LOAD(add_ofst(bytes_data_ptr(bytez), ["add", slot, 1]))

                    left_bytes = shl(["mul", 8, byte_ofst], w1)
                    right_bytes = shr(["mul", 8, ["sub", 32, byte_ofst]], w2)
                    merged = ["or", left_bytes, right_bytes]

                    ret = ["if", byte_ofst, merged, left_bytes]
                    return finalize(b1.resolve(b2.resolve(b3.resolve(b4.resolve(ret)))))