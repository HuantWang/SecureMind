func ColumnSubstituteImpl(ctx BuildContext, expr Expression, schema *Schema, newExprs []Expression, fail1Return bool) (bool, bool, Expression) {
	switch v := expr.(type) {
	case *Column:
		id := schema.ColumnIndex(v)
		if id == -1 {
			return false, false, v
		}
		newExpr := newExprs[id]
		if v.InOperand {
			newExpr = SetExprColumnInOperand(newExpr)
		}
		return true, false, newExpr
	case *ScalarFunction:
		substituted := false
		hasFail := false
		if v.FuncName.L == ast.Cast || v.FuncName.L == ast.Grouping {
			var newArg Expression
			substituted, hasFail, newArg = ColumnSubstituteImpl(ctx, v.GetArgs()[0], schema, newExprs, fail1Return)
			if fail1Return && hasFail {
				return substituted, hasFail, v
			}
			if substituted {
				flag := v.RetType.GetFlag()
				var e Expression
				if v.FuncName.L == ast.Cast {
					e = BuildCastFunction(ctx, newArg, v.RetType)
				} else {
										e = v.Clone()
					e.(*ScalarFunction).Function.getArgs()[0] = newArg
				}
				e.SetCoercibility(v.Coercibility())
				e.GetType().SetFlag(flag)
				return true, false, e
			}
			return false, false, v
		}
				refExprArr := cowExprRef{v.GetArgs(), nil}
		oldCollEt, err := CheckAndDeriveCollationFromExprs(ctx, v.FuncName.L, v.RetType.EvalType(), v.GetArgs()...)
		if err != nil {
			logutil.BgLogger().Error("Unexpected error happened during ColumnSubstitution", zap.Stack("stack"))
			return false, false, v
		}
		var tmpArgForCollCheck []Expression
		if collate.NewCollationEnabled() {
			tmpArgForCollCheck = make([]Expression, len(v.GetArgs()))
		}
		for idx, arg := range v.GetArgs() {
			changed, failed, newFuncExpr := ColumnSubstituteImpl(ctx, arg, schema, newExprs, fail1Return)
			if fail1Return && failed {
				return changed, failed, v
			}
			oldChanged := changed
			if collate.NewCollationEnabled() && changed {
								changed = false
				copy(tmpArgForCollCheck, refExprArr.Result())
				tmpArgForCollCheck[idx] = newFuncExpr
				newCollEt, err := CheckAndDeriveCollationFromExprs(ctx, v.FuncName.L, v.RetType.EvalType(), tmpArgForCollCheck...)
				if err != nil {
					logutil.BgLogger().Error("Unexpected error happened during ColumnSubstitution", zap.Stack("stack"))
					return false, failed, v
				}
				if oldCollEt.Collation == newCollEt.Collation {
					if newFuncExpr.GetType().GetCollate() == arg.GetType().GetCollate() && newFuncExpr.Coercibility() == arg.Coercibility() {
												changed = true
					} else {
						changed = checkCollationStrictness(oldCollEt.Collation, newFuncExpr.GetType().GetCollate())
					}
				}
			}
			hasFail = hasFail || failed || oldChanged != changed
			if fail1Return && oldChanged != changed {
								return changed, true, v
			}
			refExprArr.Set(idx, changed, newFuncExpr)
			if changed {
				substituted = true
			}
		}
		if substituted {
			return true, hasFail, NewFunctionInternal(ctx, v.FuncName.L, v.RetType, refExprArr.Result()...)
		}
	}
	return false, false, expr
}