bool InterpreterState::run(Stack &stack)
{
  while (true)
  {
    try
    {
      auto &frame = frames_.back();
      const auto &code = frame.getCode();
      const auto pc = frame.getPC();
      auto inst = frame.getInstruction();

      DebugHandle debug_handle = pc;
      if (auto handle = frame.getDebugHandle())
      {
        debug_handle = *handle;
      }

      bool prev_value = isRecordFunctionEnabled();
      if (!prev_value)
      {
        enableRecordFunction(true);
      }
      switch (inst.op)
      {
      case OP:
      {
        if (at::hasGlobalCallbacks())
        {
          if (auto *mobile_debug_info = static_cast<MobileDebugInfo *>(
                  c10::ThreadLocalDebugInfo::get(
                      c10::DebugInfoKind::MOBILE_RUNTIME_INFO)))
          {
            mobile_debug_info->setOpIdx(pc);
          }
        }
        if (inst.X < 0 ||
            static_cast<size_t>(inst.X) >= code.operators_.size())
        {
          throw JITException("Invalid OP Instruction");
        }
        RECORD_EDGE_SCOPE_WITH_DEBUG_HANDLE_AND_INPUTS(
            code.op_names_[inst.X].name, debug_handle, stack);
        code.operators_[inst.X](stack);
        frame.step();
      }
      break;
      case OPN:
      {
        stack.emplace_back(inst.N);
        RECORD_EDGE_SCOPE_WITH_DEBUG_HANDLE_AND_INPUTS(
            code.op_names_[inst.X].name, debug_handle, stack);
        code.operators_[inst.X](stack);
        frame.step();
      }
      break;
      case CALL:
      {
        auto &function = *frame.getCode().functions_.at(inst.X);
        callFunction(function, stack);
      }
      break;
      case INTERFACE_CALL:
      {
        torch::jit::Function &method =
            peek(stack, 0, inst.N)
                .toObject()
                ->type()
                ->getMethod(code.constants_[inst.X].toStringRef());
        RECORD_EDGE_SCOPE_WITH_DEBUG_HANDLE_AND_INPUTS(
            method.name(), debug_handle, stack);
        callFunction(method, stack);
      }
      break;
      case LOAD:
        stack.emplace_back(reg(inst.X));
        frame.step();
        break;
      case MOVE:
        stack.emplace_back(std::move(reg(inst.X)));
        frame.step();
        break;
      case STORE:
        reg(inst.X) = pop(stack);
        frame.step();
        break;
      case STOREN:
        for (size_t i = inst.N; i > 0; --i)
        {
          reg(inst.X + i - 1) = pop(stack);
        }
        frame.step();
        break;
      case DROP:
        pop(stack);
        frame.step();
        break;
      case DROPR:
        reg(inst.X) = IValue();
        frame.step();
        break;
      case LOADC:
        stack.emplace_back(code.constants_[inst.X]);
        frame.step();
        break;
      case GET_ATTR:
      {
        auto userObj = pop(stack).toObject();
        auto value = userObj->getSlot(inst.X);
        push(stack, std::move(value));
        frame.step();
      }
      break;
      case SET_ATTR:
      {
        auto v = pop(stack);
        auto userObj = pop(stack).toObject();
        while (static_cast<int>(userObj->type()->numAttributes()) <= inst.X)
        {
          std::stringstream ss;
          ss << userObj->type()->numAttributes();
          userObj->type()->addAttribute(ss.str(), c10::NoneType::get());
        }
        userObj->setSlot(inst.X, std::move(v));
        frame.step();
      }
      break;
      case JF:
        frame.jump(pop(stack).toBool() ? 1 : inst.X);
        break;
      case JMP:
        frame.jump(inst.X);
        break;
      case LOOP:
      {
        auto sframe = stack.end() - (inst.N + 1);
        int64_t trip_count = sframe[0].toInt();
        int64_t max_trip_count = sframe[1].toInt();
        bool cond = sframe[2].toBool();
        if (trip_count < max_trip_count && cond)
        {
          sframe[2] = trip_count;
          sframe[0] = trip_count + 1;
          frame.step();
        }
        else
        {
          size_t n_loop_carried = inst.N - 2;
          for (const auto i : c10::irange(n_loop_carried))
          {
            sframe[i] = std::move(sframe[i + 3]);
          }
          drop(stack, 3);
          frame.jump(inst.X);
        }
      }
      break;
      case RET:
        leaveFrame();
        if (!frames_.empty())
        {
          continue;
        }
        return false;
      case LIST_CONSTRUCT:
      {
        listConstruct(stack, *code.types_.at(inst.X), inst.N);
        frame.step();
      }
      break;
      case LIST_UNPACK:
      {
        listUnpack(stack, inst.X);
        frame.step();
      }
      break;
      case TUPLE_CONSTRUCT:
      {
        tupleConstruct(stack, inst.X);
        frame.step();
      }
      break;
      case TUPLE_SLICE:
      {
        tupleSlice(stack, inst.X, inst.X + inst.N);
        frame.step();
      }
      break;
      case TUPLE_INDEX:
      {
        tupleIndex(stack);
        frame.step();
      }
      break;
      case RAISE_EXCEPTION:
      {
        raiseExceptionWithMessage(stack);
        frame.step();
      }
      break;
      case __IS__:
      {
        is(stack);
        frame.step();
      }
      break;
      case UN_INITIALIZED:
      {
        unInitialized(stack);
        frame.step();
      }
      break;
      case __ISNOT__:
      {
        isNot(stack);
        frame.step();
      }
      break;
      case FORMAT:
      {
        format(stack, inst.X);
        frame.step();
      }
      break;
      case DEVICE:
      {
        device(stack);
        frame.step();
      }
      break;
      case DTYPE:
      {
        dtype(stack);
        frame.step();
      }
      break;
      case DIM:
      {
        dim(stack);
        frame.step();
      }
      break;
      case __NOT__:
      {
        _not(stack);
        frame.step();
      }
      break;
      case DICT_INDEX:
      {
        dictIndex(stack);
        frame.step();
      }
      break;
      case TO_LIST:
      {
        toList(stack);
        frame.step();
      }
      break;
      case NUM_TO_TENSOR:
      {
        numToTensorScalar(stack);
        frame.step();
      }
      break;
      case IS_CUDA:
      {
        isCuda(stack);
        frame.step();
      }
      break;
      case DICT_CONSTRUCT:
      {
        dictConstruct(stack, *code.types_.at(inst.X), inst.N);
        frame.step();
      }
      break;
      case NAMED_TUPLE_CONSTRUCT:
      {
        namedTupleConstruct(stack, code.types_.at(inst.X), inst.N);
        frame.step();
      }
      break;
      case CREATE_OBJECT:
      {
        auto type = code.types_.at(inst.X)->expect<c10::ClassType>();
        createObject(stack, type);
        frame.step();
      }
      break;
      case ISINSTANCE:
      {
        at::ArrayRef<TypePtr> types(&code.types_.at(inst.X), inst.N);
        isinstance(stack, types);
        frame.step();
      }
      break;
      case WARN:
      {
        drop(stack, 1);
        const auto &sref = stack.back().toStringRef();
        TORCH_WARN(sref);
        stack.pop_back();
        frame.step();
      }
      break;
      default:
        AT_ERROR(toString(inst.op), " is invalid.");
      }

      if (!prev_value)
      {
        enableRecordFunction(false);
      }
    }
    catch (c10::BackendRuntimeException &e)
    {
      saveExceptionDebugHandles();
      TORCH_RETHROW(e);
    }
    catch (c10::Error &error)
    {
      saveExceptionDebugHandles();
      TORCH_RETHROW(error);
    }
    catch (...)
    {
      saveExceptionDebugHandles();
      throw;
    }
  }
  return false;
}