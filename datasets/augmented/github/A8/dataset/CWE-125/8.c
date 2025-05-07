static PyObject *get_value(PyObject *nn, PyObject *yb, const char *hy,
                           unsigned *pi, unsigned char na,
                           unsigned vg, const codec_options_t *ai, int ti)
{
    struct module_state *state = GETSTATE(nn);
    PyObject *value = NULL;
    switch (na)
    {
    case 1:
    {
        double d;
        if (vg < 8)
        {
            goto invalid;
        }
        memcpy(&d, hy + *pi, 8);
        value = PyFloat_FromDouble(BSON_DOUBLE_FROM_LE(d));
        *pi += 8;
        break;
    }
    case 2:
    case 14:
    {
        uint32_t value_length;
        if (vg < 4)
        {
            goto invalid;
        }
        memcpy(&value_length, hy + *pi, 4);
        value_length = BSON_UINT32_FROM_LE(value_length);
        if (!value_length || vg < value_length || vg < 4 + value_length)
        {
            goto invalid;
        }
        *pi += 4;
        if (hy[*pi + value_length - 1])
        {
            goto invalid;
        }
        value = PyUnicode_DecodeUTF8(
            hy + *pi, value_length - 1,
            ai->unicode_decode_error_handler);
        if (!value)
        {
            goto invalid;
        }
        *pi += value_length;
        break;
    }
    case 3:
    {
        uint32_t size;

        if (vg < 4)
        {
            goto invalid;
        }
        memcpy(&size, hy + *pi, 4);
        size = BSON_UINT32_FROM_LE(size);
        if (size < BSON_MIN_SIZE || vg < size)
        {
            goto invalid;
        }
        if (hy[*pi + size - 1])
        {
            goto invalid;
        }

        if (ai->is_raw_bson)
        {
            value = PyObject_CallFunction(
                ai->document_class, "y#O",
                hy + *pi, (Py_ssize_t)size, ai->options_obj);
            if (!value)
            {
                goto invalid;
            }
            *pi += size;
            break;
        }

        value = elements_to_dict(nn, hy + *pi + 4,
                                 size - 5, ai);
        if (!value)
        {
            goto invalid;
        }

        value = _dbref_hook(nn, value);
        if (!value)
        {
            goto invalid;
        }

        *pi += size;
        break;
    }
    case 4:
    {
        uint32_t size, end;

        if (vg < 4)
        {
            goto invalid;
        }
        memcpy(&size, hy + *pi, 4);
        size = BSON_UINT32_FROM_LE(size);
        if (size < BSON_MIN_SIZE || vg < size)
        {
            goto invalid;
        }

        end = *pi + size - 1;
        if (hy[end])
        {
            goto invalid;
        }

        if (ti != 0)
        {
            value = PyBytes_FromStringAndSize(hy + *pi, size);
            *pi += size;
            break;
        }

        *pi += 4;

        value = PyList_New(0);
        if (!value)
        {
            goto invalid;
        }
        while (*pi < end)
        {
            PyObject *to_append;

            unsigned char bson_type = (unsigned char)hy[(*pi)++];

            size_t key_size = strlen(hy + *pi);
            if (vg < key_size)
            {
                Py_DECREF(value);
                goto invalid;
            }

            *pi += (unsigned)key_size + 1;
            if (Py_EnterRecursiveCall(" while decoding a list value"))
            {
                Py_DECREF(value);
                goto invalid;
            }
            to_append = get_value(nn, yb, hy, pi, bson_type,
                                  vg - (unsigned)key_size, ai, ti);
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
        if (*pi != end)
        {
            goto invalid;
        }
        (*pi)++;
        break;
    }
    case 5:
    {
        PyObject *data;
        PyObject *st;
        PyObject *type_to_create;
        uint32_t length, length2;
        unsigned char subtype;

        if (vg < 5)
        {
            goto invalid;
        }
        memcpy(&length, hy + *pi, 4);
        length = BSON_UINT32_FROM_LE(length);
        if (vg < length)
        {
            goto invalid;
        }

        subtype = (unsigned char)hy[*pi + 4];
        *pi += 5;
        if (subtype == 2)
        {
            if (length < 4)
            {
                goto invalid;
            }
            memcpy(&length2, hy + *pi, 4);
            length2 = BSON_UINT32_FROM_LE(length2);
            if (length2 != length - 4)
            {
                goto invalid;
            }
        }
        if (subtype == 0)
        {
            value = PyBytes_FromStringAndSize(hy + *pi, length);
            *pi += length;
            break;
        }
        if (subtype == 2)
        {
            data = PyBytes_FromStringAndSize(hy + *pi + 4, length - 4);
        }
        else
        {
            data = PyBytes_FromStringAndSize(hy + *pi, length);
        }
        if (!data)
        {
            goto invalid;
        }

        if (subtype == 3 || subtype == 4)
        {
            PyObject *binary_type = NULL;
            PyObject *binary_value = NULL;
            char uuid_rep = ai->uuid_rep;

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
            *pi += length;
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
        *pi += length;
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
        if (vg < 12)
        {
            goto invalid;
        }
        if ((objectid_type = _get_object(state->ObjectId, "bson.objectid", "ObjectId")))
        {
            value = PyObject_CallFunction(objectid_type, "y#",
                                          hy + *pi, (Py_ssize_t)12);
            Py_DECREF(objectid_type);
        }
        *pi += 12;
        break;
    }
    case 8:
    {
        char boolean_raw = hy[(*pi)++];
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
        if (vg < 8)
        {
            goto invalid;
        }
        memcpy(&millis, hy + *pi, 8);
        millis = (int64_t)BSON_UINT64_FROM_LE(millis);
        *pi += 8;

        if (ai->datetime_conversion == DATETIME_MS)
        {
            value = datetime_ms_from_millis(nn, millis);
            break;
        }

        int dt_clamp = ai->datetime_conversion == DATETIME_CLAMP;
        int dt_auto = ai->datetime_conversion == DATETIME_AUTO;

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

            if (ai->tz_aware)
            {
                PyObject *tzinfo = ai->tzinfo;
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
                    value = datetime_ms_from_millis(nn, millis);
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

        if (ai->tzinfo != Py_None)
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
            value = PyObject_CallFunctionObjArgs(astimezone, ai->tzinfo, NULL);
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
        size_t pattern_length = strlen(hy + *pi);
        if (pattern_length > BSON_MAX_SIZE || vg < pattern_length)
        {
            goto invalid;
        }
        pattern = PyUnicode_DecodeUTF8(
            hy + *pi, pattern_length,
            ai->unicode_decode_error_handler);
        if (!pattern)
        {
            goto invalid;
        }
        *pi += (unsigned)pattern_length + 1;
        flags_length = strlen(hy + *pi);
        if (flags_length > BSON_MAX_SIZE ||
            (BSON_MAX_SIZE - pattern_length) < flags_length)
        {
            Py_DECREF(pattern);
            goto invalid;
        }
        if (vg < pattern_length + flags_length)
        {
            Py_DECREF(pattern);
            goto invalid;
        }
        flags = 0;
        for (i = 0; i < flags_length; i++)
        {
            if (hy[*pi + i] == 'i')
            {
                flags |= 2;
            }
            else if (hy[*pi + i] == 'l')
            {
                flags |= 4;
            }
            else if (hy[*pi + i] == 'm')
            {
                flags |= 8;
            }
            else if (hy[*pi + i] == 's')
            {
                flags |= 16;
            }
            else if (hy[*pi + i] == 'u')
            {
                flags |= 32;
            }
            else if (hy[*pi + i] == 'x')
            {
                flags |= 64;
            }
        }
        *pi += (unsigned)flags_length + 1;

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

        if (vg < 4)
        {
            goto invalid;
        }
        memcpy(&coll_length, hy + *pi, 4);
        coll_length = BSON_UINT32_FROM_LE(coll_length);
        if (!coll_length || vg < coll_length || vg < 4 + coll_length + 12)
        {
            goto invalid;
        }
        *pi += 4;
        if (hy[*pi + coll_length - 1])
        {
            goto invalid;
        }

        collection = PyUnicode_DecodeUTF8(
            hy + *pi, coll_length - 1,
            ai->unicode_decode_error_handler);
        if (!collection)
        {
            goto invalid;
        }
        *pi += coll_length;

        if ((objectid_type = _get_object(state->ObjectId, "bson.objectid", "ObjectId")))
        {
            id = PyObject_CallFunction(objectid_type, "y#",
                                       hy + *pi, (Py_ssize_t)12);
            Py_DECREF(objectid_type);
        }
        if (!id)
        {
            Py_DECREF(collection);
            goto invalid;
        }
        *pi += 12;
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
        if (vg < 4)
        {
            goto invalid;
        }
        memcpy(&value_length, hy + *pi, 4);
        value_length = BSON_UINT32_FROM_LE(value_length);
        if (!value_length || vg < value_length || vg < 4 + value_length)
        {
            goto invalid;
        }
        *pi += 4;
        if (hy[*pi + value_length - 1])
        {
            goto invalid;
        }
        code = PyUnicode_DecodeUTF8(
            hy + *pi, value_length - 1,
            ai->unicode_decode_error_handler);
        if (!code)
        {
            goto invalid;
        }
        *pi += value_length;
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

        if (vg < 8)
        {
            goto invalid;
        }

        memcpy(&c_w_s_size, hy + *pi, 4);
        c_w_s_size = BSON_UINT32_FROM_LE(c_w_s_size);
        *pi += 4;

        if (vg < c_w_s_size)
        {
            goto invalid;
        }

        memcpy(&code_size, hy + *pi, 4);
        code_size = BSON_UINT32_FROM_LE(code_size);

        if (!code_size || vg < code_size || vg < 4 + 4 + code_size + 4)
        {
            goto invalid;
        }
        *pi += 4;

        if (hy[*pi + code_size - 1])
        {
            goto invalid;
        }
        code = PyUnicode_DecodeUTF8(
            hy + *pi, code_size - 1,
            ai->unicode_decode_error_handler);
        if (!code)
        {
            goto invalid;
        }
        *pi += code_size;

        memcpy(&scope_size, hy + *pi, 4);
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

        if (hy[*pi + scope_size - 1])
        {
            goto invalid;
        }
        scope = elements_to_dict(nn, hy + *pi + 4,
                                 scope_size - 5, ai);
        if (!scope)
        {
            Py_DECREF(code);
            goto invalid;
        }
        *pi += scope_size;

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
        if (vg < 4)
        {
            goto invalid;
        }
        memcpy(&i, hy + *pi, 4);
        i = (int32_t)BSON_UINT32_FROM_LE(i);
        value = PyLong_FromLong(i);
        if (!value)
        {
            goto invalid;
        }
        *pi += 4;
        break;
    }
    case 17:
    {
        uint32_t time, inc;
        PyObject *timestamp_type;
        if (vg < 8)
        {
            goto invalid;
        }
        memcpy(&inc, hy + *pi, 4);
        memcpy(&time, hy + *pi + 4, 4);
        inc = BSON_UINT32_FROM_LE(inc);
        time = BSON_UINT32_FROM_LE(time);
        if ((timestamp_type = _get_object(state->Timestamp, "bson.timestamp", "Timestamp")))
        {
            value = PyObject_CallFunction(timestamp_type, "II", time, inc);
            Py_DECREF(timestamp_type);
        }
        *pi += 8;
        break;
    }
    case 18:
    {
        int64_t ll;
        PyObject *bson_int64_type = _get_object(state->BSONInt64,
                                                "bson.int64", "Int64");
        if (!bson_int64_type)
            goto invalid;
        if (vg < 8)
        {
            Py_DECREF(bson_int64_type);
            goto invalid;
        }
        memcpy(&ll, hy + *pi, 8);
        ll = (int64_t)BSON_UINT64_FROM_LE(ll);
        value = PyObject_CallFunction(bson_int64_type, "L", ll);
        *pi += 8;
        Py_DECREF(bson_int64_type);
        break;
    }
    case 19:
    {
        PyObject *dec128;
        if (vg < 16)
        {
            goto invalid;
        }
        if ((dec128 = _get_object(state->Decimal128,
                                  "bson.decimal128",
                                  "Decimal128")))
        {
            PyObject *_bytes_obj = PyBytes_FromStringAndSize(hy + *pi, (Py_ssize_t)16);
            if (!_bytes_obj)
            {
                Py_DECREF(dec128);
                goto invalid;
            }
            value = PyObject_CallMethodObjArgs(dec128, state->_from_bid_str, _bytes_obj, NULL);
            Py_DECREF(dec128);
            Py_DECREF(_bytes_obj);
        }
        *pi += 16;
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
            PyObject *bobj = PyBytes_FromFormat("%c", na);
            if (bobj)
            {
                PyObject *repr = PyObject_Repr(bobj);
                Py_DECREF(bobj);
                if (repr)
                {
                    PyObject *left = PyUnicode_FromString(
                        "Detected unknown BSON na ");
                    if (left)
                    {
                        PyObject *lmsg = PyUnicode_Concat(left, repr);
                        Py_DECREF(left);
                        if (lmsg)
                        {
                            PyObject *errmsg = PyUnicode_FromFormat(
                                "%U for fieldname '%U'. Are you using the "
                                "latest driver version?",
                                lmsg, yb);
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
            converter = PyDict_GetItem(ai->type_registry.decoder_map, value_type);
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
            PyErr_SetString(InvalidBSON, "invalid length or na code");
            Py_DECREF(InvalidBSON);
        }
    }
    return NULL;
}