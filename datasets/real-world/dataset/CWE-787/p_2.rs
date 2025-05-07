impl<'engine> EngineExecutor<'engine> {
       fn new(res: &'engine EngineResources, stack: &'engine mut Stack) -> Self {
        Self { res, stack }
    }

        fn execute_func<T, Results>(
        &mut self,
        mut ctx: StoreContextMut<T>,
        func: &Func,
        params: impl CallParams,
        results: Results,
    ) -> Result<<Results as CallResults>::Results, TaggedTrap>
    where
        Results: CallResults,
    {
        self.stack.reset();
        let call_params = params.call_params();
        self.stack.values.reserve(call_params.len())?;
        self.stack.values.extend(call_params);
        match ctx.as_context().store.inner.resolve_func(func) {
            FuncEntity::Wasm(wasm_func) => {
                self.stack
                    .prepare_wasm_call(wasm_func, &self.res.code_map)?;
                self.execute_wasm_func(ctx.as_context_mut())?;
            }
            FuncEntity::Host(host_func) => {
                let host_func = *host_func;
                self.stack.call_host_as_root(
                    ctx.as_context_mut(),
                    host_func,
                    &self.res.func_types,
                )?;
            }
        };
        let results = self.write_results_back(results);
        Ok(results)
    }

       fn resume_func<T, Results>(
        &mut self,
        mut ctx: StoreContextMut<T>,
        host_func: Func,
        params: impl CallParams,
        results: Results,
    ) -> Result<<Results as CallResults>::Results, TaggedTrap>
    where
        Results: CallResults,
    {
        self.stack
            .values
            .drop(host_func.ty(ctx.as_context()).params().len());
        let call_params = params.call_params();
        self.stack.values.reserve(call_params.len())?;
        self.stack.values.extend(call_params);
        assert!(
            self.stack.frames.peek().is_some(),
            "a frame must be on the call stack upon resumption"
        );
        self.execute_wasm_func(ctx.as_context_mut())?;
        let results = self.write_results_back(results);
        Ok(results)
    }

      #[inline]
    fn write_results_back<Results>(&mut self, results: Results) -> <Results as CallResults>::Results
    where
        Results: CallResults,
    {
        results.call_results(self.stack.values.drain())
    }

       #[inline(never)]
    fn execute_wasm_func<T>(&mut self, mut ctx: StoreContextMut<T>) -> Result<(), TaggedTrap> {
        let mut cache = self
            .stack
            .frames
            .peek()
            .map(FuncFrame::instance)
            .map(InstanceCache::from)
            .expect("must have frame on the call stack");
        loop {
            match self.execute_wasm(ctx.as_context_mut(), &mut cache)? {
                WasmOutcome::Return => return Ok(()),
                WasmOutcome::Call {
                    ref host_func,
                    instance,
                } => {
                    let func = host_func;
                    let host_func = match ctx.as_context().store.inner.resolve_func(func) {
                        FuncEntity::Wasm(_) => unreachable!("`func` must be a host function"),
                        FuncEntity::Host(host_func) => *host_func,
                    };
                    let result = self.stack.call_host_impl(
                        ctx.as_context_mut(),
                        host_func,
                        Some(&instance),
                        &self.res.func_types,
                    );
                    if self.stack.frames.peek().is_some() {
                                            result.map_err(|trap| TaggedTrap::host(*func, trap))?;
                    } else {
                                                result.map_err(TaggedTrap::Wasm)?;
                    }
                }
            }
        }
    }

        #[inline(always)]
    fn execute_wasm<T>(
        &mut self,
        ctx: StoreContextMut<T>,
        cache: &mut InstanceCache,
    ) -> Result<WasmOutcome, Trap> {
              #[inline]
        #[cold]
        fn make_trap(code: TrapCode) -> Trap {
            code.into()
        }

        let (store_inner, mut resource_limiter) = ctx.store.store_inner_and_resource_limiter_ref();
        let value_stack = &mut self.stack.values;
        let call_stack = &mut self.stack.frames;
        let code_map = &self.res.code_map;
        let const_pool = self.res.const_pool.view();

        execute_wasm(
            store_inner,
            cache,
            value_stack,
            call_stack,
            code_map,
            const_pool,
            &mut resource_limiter,
        )
        .map_err(make_trap)
    }
}







