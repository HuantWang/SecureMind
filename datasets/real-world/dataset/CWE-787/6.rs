pub extern "C" fn wasmtime_trap_code(raw: &wasm_trap_t, code: &mut i32) -> bool {
    match raw.trap.trap_code() {
        Some(c) => {
            *code = match c {
                TrapCode::StackOverflow => 0,
                TrapCode::MemoryOutOfBounds => 1,
                TrapCode::HeapMisaligned => 2,
                TrapCode::TableOutOfBounds => 3,
                TrapCode::IndirectCallToNull => 4,
                TrapCode::BadSignature => 5,
                TrapCode::IntegerOverflow => 6,
                TrapCode::IntegerDivisionByZero => 7,
                TrapCode::BadConversionToInteger => 8,
                TrapCode::UnreachableCodeReached => 9,
                TrapCode::Interrupt => 10,
                _ => unreachable!(),
            };
            true
        }
        None => false,
    }
}