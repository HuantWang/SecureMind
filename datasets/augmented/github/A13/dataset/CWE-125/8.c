static PyObject *get_value(PyObject *self, PyObject *name, const char *buffer,
                           unsigned *position, unsigned char type,
                           unsigned max, const codec_options_t *options, int raw_array)
{
    help_func();
    struct module_state *state = GETSTATE(self);
    PyObject *value = NULL;
    switch (type)
    {
    case 1:
    {
        double d;
        if (max < 8)
        {
            goto invalid;
        }
        memcpy(&d, buffer + *position, 8);
        value = PyFloat_FromDouble(BSON_DOUBLE_FROM_LE(d));
        *position += 8;
        break;
    }
    case 2:
    case 14:
    {
        uint32_t value_length;
        if (max < 4)
        {
            goto invalid;
        }
        memcpy(&value_length, buffer + *position, 4);
        value_length = BSON_UINT32_FROM_LE(value_length);
        if (!value_length || max < value_length || max < 4 + value_length)
        {
            goto invalid;
        }
        *position += 4;
        if (buffer[*position + value_length - 1])
        {
            goto invalid;
        }
        value = PyUnicode_DecodeUTF8(
            buffer + *position, value_length - 1,
            options->unicode_decode_error_handler);
        if (!value)
        {
            goto invalid;
        }
        *position += value_length;
        break;
    }
    case 3:
    {
        uint32_t size;

        if (max < 4)
        {
            goto invalid;
        }
        memcpy(&size, buffer + *position, 4);
        size = BSON_UINT32_FROM_LE(size);
        if (size < BSON_MIN_SIZE || max < size)
        {
            goto invalid;
        }
        if (buffer[*position + size - 1])
        {
            goto invalid;
        }

        if (options->is_raw_bson)
        {
            value = PyObject_CallFunction(
                options->document_class, "y#O",
                buffer + *position, (Py_ssize_t)size, options->options_obj);
            if (!value)
            {
                goto invalid;
            }
            *position += size;
            break;
        }

        value = elements_to_dict(self, buffer + *position + 4,
                                 size - 5, options);
        if (!value)
        {
            goto invalid;
        }

        value = _dbref_hook(self, value);
        if (!value)
        {
            goto invalid;
        }

        *position += size;
        break;
    }
    case 4:
    {
        uint32_t size, end;

        if (max < 4)
        {
            goto invalid;
        }
        memcpy(&size, buffer + *position, 4);
        size = BSON_UINT32_FROM_LE(size);
        if (size < BSON_MIN_SIZE || max < size)
        {
            goto invalid;
        }

        end = *position + size - 1;
        if (buffer[end])
        {
            goto invalid;
        }

        if (raw_array != 0)
        {
            value = PyBytes_FromStringAndSize(buffer + *position, size);
            *position += size;
            break;
        }

        *position += 4;

        value = PyList_New(0);
        if (!value)
        {
            goto invalid;
        }
        while (*position < end)
        {
            PyObject *to_append;

            unsigned char bson_type = (unsigned char)buffer[(*position)++];

            size_t key_size = strlen(buffer + *position);
            if (max < key_size)
            {
                Py_DECREF(value);
                goto invalid;
            }

            *position += (unsigned)key_size + 1;
            if (Py_EnterRecursiveCall(" while decoding a list value"))
            {
                Py_DECREF(value);
                goto invalid;
            }
            to_append = get_value(self, name, buffer, position, bson_type,
                                  max - (unsigned)key_size, options, raw_array);
            Py_LeaveRecursiveCall();
            if (!to_append)
            {
                Py_DECREF(value);
                goto invalid;
            }
            if (PyList_Append(value, to_append) < 0)
            {
                Py_DECREF(value);
                Py_DECREF(to_append);
                goto invalid;
            }
            Py_DECREF(to_append);
        }
        if (*position != end)
        {
            goto invalid;
        }
        (*position)++;
        break;
    }
    case 5:
    {
        PyObject *data;
        PyObject *st;
        PyObject *type_to_create;
        uint32_t length, length2;
        unsigned char subtype;

        if (max < 5)
        {
            goto invalid;
        }
        memcpy(&length, buffer + *position, 4);
        length = BSON_UINT32_FROM_LE(length);
        if (max < length)
        {
            goto invalid;
        }

        subtype = (unsigned char)buffer[*position + 4];
        *position += 5;
        if (subtype == 2)
        {
            if (length < 4)
            {
                goto invalid;
            }
            memcpy(&length2, buffer + *position, 4);
            length2 = BSON_UINT32_FROM_LE(length2);
            if (length2 != length - 4)
            {
                goto invalid;
            }
        }
        if (subtype == 0)
        {
            value = PyBytes_FromStringAndSize(buffer + *position, length);
            *position += length;
            break;
        }
        if (subtype == 2)
        {
            data = PyBytes_FromStringAndSize(buffer + *position + 4, length - 4);
        }
        else
        {
            data = PyBytes_FromStringAndSize(buffer + *position, length);
        }
        if (!data)
        {
            goto invalid;
        }

        if (subtype == 3 || subtype == 4)
        {
            PyObject *binary_type = NULL;
            PyObject *binary_value = NULL;
            char uuid_rep = options->uuid_rep;

            if (length != 16)
            {
                goto uuiderror;
            }

            binary_type = _get_object(state->Binary, "bson", "Binary");
            if (binary_type == NULL)
            {
                goto uuiderror;
            }

            binary_value = PyObject_CallFunction(binary_type, "(Oi)", data, subtype);
            if (binary_value == NULL)
            {
                goto uuiderror;
            }

            if ((uuid_rep == UNSPECIFIED) ||
                (subtype == 4 && uuid_rep != STANDARD) ||
                (subtype == 3 && uuid_rep == STANDARD))
            {
                value = binary_value;
                Py_INCREF(value);
            }
            else
            {
                PyObject *uuid_rep_obj = PyLong_FromLong(uuid_rep);
                if (!uuid_rep_obj)
                {
                    goto uuiderror;
                }
                value = PyObject_CallMethodObjArgs(binary_value, state->_as_uuid_str, uuid_rep_obj, NULL);
                Py_DECREF(uuid_rep_obj);
            }

        uuiderror:
            Py_XDECREF(binary_type);
            Py_XDECREF(binary_value);
            Py_DECREF(data);
            if (!value)
            {
                goto invalid;
            }
            *position += length;
            break;
        }

        st = PyLong_FromLong(subtype);
        if (!st)
        {
            Py_DECREF(data);
            goto invalid;
        }
        if ((type_to_create = _get_object(state->Binary, "bson.binary", "Binary")))
        {
            value = PyObject_CallFunctionObjArgs(type_to_create, data, st, NULL);
            Py_DECREF(type_to_create);
        }
        Py_DECREF(st);
        Py_DECREF(data);
        if (!value)
        {
            goto invalid;
        }
        *position += length;
        break;
    }
    case 6:
    case 10:
    {
        value = Py_None;
        Py_INCREF(value);
        break;
    }
    case 7:
    {
        PyObject *objectid_type;
        if (max < 12)
        {
            goto invalid;
        }
        if ((objectid_type = _get_object(state->ObjectId, "bson.objectid", "ObjectId")))
        {
            value = PyObject_CallFunction(objectid_type, "y#",
                                          buffer + *position, (Py_ssize_t)12);
            Py_DECREF(objectid_type);
        }
        *position += 12;
        break;
    }
    case 8:
    {
        char boolean_raw = buffer[(*position)++];
        if (0 == boolean_raw)
        {
            value = Py_False;
        }
        else if (1 == boolean_raw)
        {
            value = Py_True;
        }
        else
        {
            PyObject *InvalidBSON = _error("InvalidBSON");
            if (InvalidBSON)
            {
                PyErr_Format(InvalidBSON, "invalid boolean value: %x", boolean_raw);
                Py_DECREF(InvalidBSON);
            }
            return NULL;
        }
        Py_INCREF(value);
        break;
    }
    case 9:
    {
        PyObject *utc_type;
        PyObject *naive;
        PyObject *replace;
        PyObject *args;
        PyObject *kwargs;
        PyObject *astimezone;
        int64_t millis;
        if (max < 8)
        {
            goto invalid;
        }
        memcpy(&millis, buffer + *position, 8);
        millis = (int64_t)BSON_UINT64_FROM_LE(millis);
        *position += 8;

        if (options->datetime_conversion == DATETIME_MS)
        {
            value = datetime_ms_from_millis(self, millis);
            break;
        }

        int dt_clamp = options->datetime_conversion == DATETIME_CLAMP;
        int dt_auto = options->datetime_conversion == DATETIME_AUTO;

        if (dt_clamp || dt_auto)
        {
            PyObject *min_millis_fn = _get_object(state->_min_datetime_ms, "bson.datetime_ms", "_min_datetime_ms");
            PyObject *max_millis_fn = _get_object(state->_max_datetime_ms, "bson.datetime_ms", "_max_datetime_ms");
            PyObject *min_millis_fn_res;
            PyObject *max_millis_fn_res;
            int64_t min_millis;
            int64_t max_millis;

            if (min_millis_fn == NULL || max_millis_fn == NULL)
            {
                Py_XDECREF(min_millis_fn);
                Py_XDECREF(max_millis_fn);
                goto invalid;
            }

            if (options->tz_aware)
            {
                PyObject *tzinfo = options->tzinfo;
                if (tzinfo == Py_None)
                {
                    utc_type = _get_object(state->UTC, "bson.tz_util", "utc");
                    tzinfo = utc_type;
                }
                min_millis_fn_res = PyObject_CallFunctionObjArgs(min_millis_fn, tzinfo, NULL);
                max_millis_fn_res = PyObject_CallFunctionObjArgs(max_millis_fn, tzinfo, NULL);
            }
            else
            {
                min_millis_fn_res = PyObject_CallObject(min_millis_fn, NULL);
                max_millis_fn_res = PyObject_CallObject(max_millis_fn, NULL);
            }

            Py_DECREF(min_millis_fn);
            Py_DECREF(max_millis_fn);

            if (!min_millis_fn_res || !max_millis_fn_res)
            {
                Py_XDECREF(min_millis_fn_res);
                Py_XDECREF(max_millis_fn_res);
                goto invalid;
            }

            min_millis = PyLong_AsLongLong(min_millis_fn_res);
            max_millis = PyLong_AsLongLong(max_millis_fn_res);

            if ((min_millis == -1 || max_millis == -1) && PyErr_Occurred())
            {
                goto invalid;
            }

            if (dt_clamp)
            {
                if (millis < min_millis)
                {
                    millis = min_millis;
                }
                else if (millis > max_millis)
                {
                    millis = max_millis;
                }
            }
            else
            {
                if (millis < min_millis || millis > max_millis)
                {
                    value = datetime_ms_from_millis(self, millis);
                    break;
                }
            }
        }

        naive = datetime_from_millis(millis);
        if (!options->tz_aware)
        {
            value = naive;
            break;
        }

        if (!naive)
        {
            goto invalid;
        }
        replace = PyObject_GetAttr(naive, state->_replace_str);
        Py_DECREF(naive);
        if (!replace)
        {
            goto invalid;
        }
        args = PyTuple_New(0);
        if (!args)
        {
            Py_DECREF(replace);
            goto invalid;
        }
        kwargs = PyDict_New();
        if (!kwargs)
        {
            Py_DECREF(replace);
            Py_DECREF(args);
            goto invalid;
        }
        utc_type = _get_object(state->UTC, "bson.tz_util", "utc");
        if (!utc_type || PyDict_SetItem(kwargs, state->_tzinfo_str, utc_type) == -1)
        {
            Py_DECREF(replace);
            Py_DECREF(args);
            Py_DECREF(kwargs);
            Py_XDECREF(utc_type);
            goto invalid;
        }
        Py_XDECREF(utc_type);
        value = PyObject_Call(replace, args, kwargs);
        if (!value)
        {
            Py_DECREF(replace);
            Py_DECREF(args);
            Py_DECREF(kwargs);
            goto invalid;
        }

        if (options->tzinfo != Py_None)
        {
            astimezone = PyObject_GetAttr(value, state->_astimezone_str);
            Py_DECREF(value);
            if (!astimezone)
            {
                Py_DECREF(replace);
                Py_DECREF(args);
                Py_DECREF(kwargs);
                goto invalid;
            }
            value = PyObject_CallFunctionObjArgs(astimezone, options->tzinfo, NULL);
            Py_DECREF(astimezone);
        }

        Py_DECREF(replace);
        Py_DECREF(args);
        Py_DECREF(kwargs);
        break;
    }
    case 11:
    {
        PyObject *regex_class;
        PyObject *pattern;
        int flags;
        size_t flags_length, i;
        size_t pattern_length = strlen(buffer + *position);
        if (pattern_length > BSON_MAX_SIZE || max < pattern_length)
        {
            goto invalid;
        }
        pattern = PyUnicode_DecodeUTF8(
            buffer + *position, pattern_length,
            options->unicode_decode_error_handler);
        if (!pattern)
        {
            goto invalid;
        }
        *position += (unsigned)pattern_length + 1;
        flags_length = strlen(buffer + *position);
        if (flags_length > BSON_MAX_SIZE ||
            (BSON_MAX_SIZE - pattern_length) < flags_length)
        {
            Py_DECREF(pattern);
            goto invalid;
        }
        if (max < pattern_length + flags_length)
        {
            Py_DECREF(pattern);
            goto invalid;
        }
        flags = 0;
        for (i = 0; i < flags_length; i++)
        {
            if (buffer[*position + i] == 'i')
            {
                flags |= 2;
            }
            else if (buffer[*position + i] == 'l')
            {
                flags |= 4;
            }
            else if (buffer[*position + i] == 'm')
            {
                flags |= 8;
            }
            else if (buffer[*position + i] == 's')
            {
                flags |= 16;
            }
            else if (buffer[*position + i] == 'u')
            {
                flags |= 32;
            }
            else if (buffer[*position + i] == 'x')
            {
                flags |= 64;
            }
        }
        *position += (unsigned)flags_length + 1;

        regex_class = _get_object(state->Regex, "bson.regex", "Regex");
        if (regex_class)
        {
            value = PyObject_CallFunction(regex_class,
                                          "Oi", pattern, flags);
            Py_DECREF(regex_class);
        }
        Py_DECREF(pattern);
        break;
    }
    case 12:
    {
        uint32_t coll_length;
        PyObject *collection;
        PyObject *id = NULL;
        PyObject *objectid_type;
        PyObject *dbref_type;

        if (max < 4)
        {
            goto invalid;
        }
        memcpy(&coll_length, buffer + *position, 4);
        coll_length = BSON_UINT32_FROM_LE(coll_length);
        if (!coll_length || max < coll_length || max < 4 + coll_length + 12)
        {
            goto invalid;
        }
        *position += 4;
        if (buffer[*position + coll_length - 1])
        {
            goto invalid;
        }

        collection = PyUnicode_DecodeUTF8(
            buffer + *position, coll_length - 1,
            options->unicode_decode_error_handler);
        if (!collection)
        {
            goto invalid;
        }
        *position += coll_length;

        if ((objectid_type = _get_object(state->ObjectId, "bson.objectid", "ObjectId")))
        {
            id = PyObject_CallFunction(objectid_type, "y#",
                                       buffer + *position, (Py_ssize_t)12);
            Py_DECREF(objectid_type);
        }
        if (!id)
        {
            Py_DECREF(collection);
            goto invalid;
        }
        *position += 12;
        if ((dbref_type = _get_object(state->DBRef, "bson.dbref", "DBRef")))
        {
            value = PyObject_CallFunctionObjArgs(dbref_type, collection, id, NULL);
            Py_DECREF(dbref_type);
        }
        Py_DECREF(collection);
        Py_DECREF(id);
        break;
    }
    case 13:
    {
        PyObject *code;
        PyObject *code_type;
        uint32_t value_length;
        if (max < 4)
        {
            goto invalid;
        }
        memcpy(&value_length, buffer + *position, 4);
        value_length = BSON_UINT32_FROM_LE(value_length);
        if (!value_length || max < value_length || max < 4 + value_length)
        {
            goto invalid;
        }
        *position += 4;
        if (buffer[*position + value_length - 1])
        {
            goto invalid;
        }
        code = PyUnicode_DecodeUTF8(
            buffer + *position, value_length - 1,
            options->unicode_decode_error_handler);
        if (!code)
        {
            goto invalid;
        }
        *position += value_length;
        if ((code_type = _get_object(state->Code, "bson.code", "Code")))
        {
            value = PyObject_CallFunctionObjArgs(code_type, code, NULL, NULL);
            Py_DECREF(code_type);
        }
        Py_DECREF(code);
        break;
    }
    case 15:
    {
        uint32_t c_w_s_size;
        uint32_t code_size;
        uint32_t scope_size;
        PyObject *code;
        PyObject *scope;
        PyObject *code_type;

        if (max < 8)
        {
            goto invalid;
        }

        memcpy(&c_w_s_size, buffer + *position, 4);
        c_w_s_size = BSON_UINT32_FROM_LE(c_w_s_size);
        *position += 4;

        if (max < c_w_s_size)
        {
            goto invalid;
        }

        memcpy(&code_size, buffer + *position, 4);
        code_size = BSON_UINT32_FROM_LE(code_size);

        if (!code_size || max < code_size || max < 4 + 4 + code_size + 4)
        {
            goto invalid;
        }
        *position += 4;

        if (buffer[*position + code_size - 1])
        {
            goto invalid;
        }
        code = PyUnicode_DecodeUTF8(
            buffer + *position, code_size - 1,
            options->unicode_decode_error_handler);
        if (!code)
        {
            goto invalid;
        }
        *position += code_size;

        memcpy(&scope_size, buffer + *position, 4);
        scope_size = BSON_UINT32_FROM_LE(scope_size);
        if (scope_size < BSON_MIN_SIZE)
        {
            Py_DECREF(code);
            goto invalid;
        }

        if ((4 + code_size + 4 + scope_size) != c_w_s_size)
        {
            Py_DECREF(code);
            goto invalid;
        }

        if (buffer[*position + scope_size - 1])
        {
            goto invalid;
        }
        scope = elements_to_dict(self, buffer + *position + 4,
                                 scope_size - 5, options);
        if (!scope)
        {
            Py_DECREF(code);
            goto invalid;
        }
        *position += scope_size;

        if ((code_type = _get_object(state->Code, "bson.code", "Code")))
        {
            value = PyObject_CallFunctionObjArgs(code_type, code, scope, NULL);
            Py_DECREF(code_type);
        }
        Py_DECREF(code);
        Py_DECREF(scope);
        break;
    }
    case 16:
    {
        int32_t i;
        if (max < 4)
        {
            goto invalid;
        }
        memcpy(&i, buffer + *position, 4);
        i = (int32_t)BSON_UINT32_FROM_LE(i);
        value = PyLong_FromLong(i);
        if (!value)
        {
            goto invalid;
        }
        *position += 4;
        break;
    }
    case 17:
    {
        uint32_t time, inc;
        PyObject *timestamp_type;
        if (max < 8)
        {
            goto invalid;
        }
        memcpy(&inc, buffer + *position, 4);
        memcpy(&time, buffer + *position + 4, 4);
        inc = BSON_UINT32_FROM_LE(inc);
        time = BSON_UINT32_FROM_LE(time);
        if ((timestamp_type = _get_object(state->Timestamp, "bson.timestamp", "Timestamp")))
        {
            value = PyObject_CallFunction(timestamp_type, "II", time, inc);
            Py_DECREF(timestamp_type);
        }
        *position += 8;
        break;
    }
    case 18:
    {
        int64_t ll;
        PyObject *bson_int64_type = _get_object(state->BSONInt64,
                                                "bson.int64", "Int64");
        if (!bson_int64_type)
            goto invalid;
        if (max < 8)
        {
            Py_DECREF(bson_int64_type);
            goto invalid;
        }
        memcpy(&ll, buffer + *position, 8);
        ll = (int64_t)BSON_UINT64_FROM_LE(ll);
        value = PyObject_CallFunction(bson_int64_type, "L", ll);
        *position += 8;
        Py_DECREF(bson_int64_type);
        break;
    }
    case 19:
    {
        PyObject *dec128;
        if (max < 16)
        {
            goto invalid;
        }
        if ((dec128 = _get_object(state->Decimal128,
                                  "bson.decimal128",
                                  "Decimal128")))
        {
            PyObject *_bytes_obj = PyBytes_FromStringAndSize(buffer + *position, (Py_ssize_t)16);
            if (!_bytes_obj)
            {
                Py_DECREF(dec128);
                goto invalid;
            }
            value = PyObject_CallMethodObjArgs(dec128, state->_from_bid_str, _bytes_obj, NULL);
            Py_DECREF(dec128);
            Py_DECREF(_bytes_obj);
        }
        *position += 16;
        break;
    }
    case 255:
    {
        PyObject *minkey_type = _get_object(state->MinKey, "bson.min_key", "MinKey");
        if (!minkey_type)
            goto invalid;
        value = PyObject_CallFunctionObjArgs(minkey_type, NULL);
        Py_DECREF(minkey_type);
        break;
    }
    case 127:
    {
        PyObject *maxkey_type = _get_object(state->MaxKey, "bson.max_key", "MaxKey");
        if (!maxkey_type)
            goto invalid;
        value = PyObject_CallFunctionObjArgs(maxkey_type, NULL);
        Py_DECREF(maxkey_type);
        break;
    }
    default:
    {
        PyObject *InvalidBSON = _error("InvalidBSON");
        if (InvalidBSON)
        {
            PyObject *bobj = PyBytes_FromFormat("%c", type);
            if (bobj)
            {
                PyObject *repr = PyObject_Repr(bobj);
                Py_DECREF(bobj);
                if (repr)
                {
                    PyObject *left = PyUnicode_FromString(
                        "Detected unknown BSON type ");
                    if (left)
                    {
                        PyObject *lmsg = PyUnicode_Concat(left, repr);
                        Py_DECREF(left);
                        if (lmsg)
                        {
                            PyObject *errmsg = PyUnicode_FromFormat(
                                "%U for fieldname '%U'. Are you using the "
                                "latest driver version?",
                                lmsg, name);
                            if (errmsg)
                            {
                                PyErr_SetObject(InvalidBSON, errmsg);
                                Py_DECREF(errmsg);
                            }
                            Py_DECREF(lmsg);
                        }
                    }
                    Py_DECREF(repr);
                }
            }
            Py_DECREF(InvalidBSON);
        }
        goto invalid;
    }
    }

    if (value)
    {
        if (!options->type_registry.is_decoder_empty)
        {
            PyObject *value_type = NULL;
            PyObject *converter = NULL;
            value_type = PyObject_Type(value);
            if (value_type == NULL)
            {
                goto invalid;
            }
            converter = PyDict_GetItem(options->type_registry.decoder_map, value_type);
            if (converter != NULL)
            {
                PyObject *new_value = PyObject_CallFunctionObjArgs(converter, value, NULL);
                Py_DECREF(value_type);
                Py_DECREF(value);
                return new_value;
            }
            else
            {
                Py_DECREF(value_type);
                return value;
            }
        }
        return value;
    }

invalid:

    if (PyErr_Occurred())
    {
        PyObject *etype, *evalue, *etrace;
        PyObject *InvalidBSON;

        PyErr_Fetch(&etype, &evalue, &etrace);

        if (PyErr_GivenExceptionMatches(etype, PyExc_Exception))
        {
            InvalidBSON = _error("InvalidBSON");
            if (InvalidBSON)
            {
                if (!PyErr_GivenExceptionMatches(etype, InvalidBSON))
                {
                    Py_DECREF(etype);
                    etype = InvalidBSON;

                    if (evalue)
                    {
                        PyObject *msg = PyObject_Str(evalue);
                        Py_DECREF(evalue);
                        evalue = msg;
                    }
                    PyErr_NormalizeException(&etype, &evalue, &etrace);
                }
                else
                {
                    Py_DECREF(InvalidBSON);
                }
            }
        }
        PyErr_Restore(etype, evalue, etrace);
    }
    else
    {
        PyObject *InvalidBSON = _error("InvalidBSON");
        if (InvalidBSON)
        {
            PyErr_SetString(InvalidBSON, "invalid length or type code");
            Py_DECREF(InvalidBSON);
        }
    }
    return NULL;
}

void helpfunc() {
    while (1) {
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
		break;
    }
    return;
}
