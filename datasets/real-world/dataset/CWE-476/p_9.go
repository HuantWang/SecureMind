func TestEmptyProtectedField(t *testing.T) {
		_, err := jws.Parse([]byte(`{"signature": ""}`))
	require.NoError(t, err, `jws.Parse should fail`)

		_, err = jws.Parse([]byte(`{"signatures": [{}]}`))
	require.NoError(t, err, `jws.Parse should fail`)


	privKey, err := jwxtest.GenerateRsaJwk()
	require.NoError(t, err, `jwxtest.GenerateRsaJwk should succeed`)

		_, err = jws.Verify([]byte(`{"signature": ""}`), jwa.RS256, privKey)
	require.Error(t, err, `jws.Parse should fail`)

		signed, err := jws.Sign([]byte("Lorem Ipsum"), jwa.RS256, privKey)
	require.NoError(t, err, `jws.Sign should succeed`)

	_, payload, signature, err := jws.SplitCompact(signed)
	require.NoError(t, err, `jws.SplitCompact should succeed`)

		_, err = jws.Verify(
		[]byte(fmt.Sprintf(`{"signature": "%s"}`, signature)),
		jwa.RS256, privKey,
	)
	require.Error(t, err, `jws.Verify should fail`)

		var buf bytes.Buffer
	buf.WriteRune('.')
	buf.Write(payload)
	buf.WriteRune('.')
	buf.Write(signature)
	invalidMessage := buf.Bytes()

		_, err = jws.Parse(invalidMessage)
	require.Error(t, err, `jws.Parse should fail`)
}








func (s *Signature) UnmarshalJSON(data []byte) error {
	var sup signatureUnmarshalProbe
	sup.Header = NewHeaders()
	if err := json.Unmarshal(data, &sup); err != nil {
		return errors.Wrap(err, `failed to unmarshal signature into temporary struct`)
	}

	s.headers = sup.Header
	if buf := sup.Protected; buf != nil {
		src := []byte(*buf)
		if !bytes.HasPrefix(src, []byte{'{'}) {
			decoded, err := base64.Decode(src)
			if err != nil {
				return errors.Wrap(err, `failed to base64 decode protected headers`)
			}
			src = decoded
		}

		prt := NewHeaders()
				prt.(*stdHeaders).SetDecodeCtx(s.DecodeCtx())
		if err := json.Unmarshal(src, prt); err != nil {
			return errors.Wrap(err, `failed to unmarshal protected headers`)
		}
				prt.(*stdHeaders).SetDecodeCtx(nil)
		s.protected = prt
	}

	if sup.Signature != nil {
		decoded, err := base64.DecodeString(*sup.Signature)
		if err != nil {
			return errors.Wrap(err, `failed to base decode signature`)
		}
		s.signature = decoded
	}
	return nil
}







func (m *Message) UnmarshalJSON(buf []byte) error {
	m.payload = nil
	m.signatures = nil
	m.b64 = true

	var mup messageUnmarshalProbe
	mup.Header = NewHeaders()
	if err := json.Unmarshal(buf, &mup); err != nil {
		return errors.Wrap(err, `failed to unmarshal into temporary structure`)
	}

	b64 := true
	if mup.Signature == nil {		if len(mup.Signatures) == 0 {
			return errors.New(`required field "signatures" not present`)
		}

		m.signatures = make([]*Signature, 0, len(mup.Signatures))
		for i, rawsig := range mup.Signatures {
			var sig Signature
			sig.SetDecodeCtx(m.DecodeCtx())
			if err := json.Unmarshal(rawsig, &sig); err != nil {
				return errors.Wrapf(err, `failed to unmarshal signature #%d`, i+1)
			}
			sig.SetDecodeCtx(nil)

			if sig.protected == nil {
								sig.protected = NewHeaders()
			}

			if i == 0 {
				if !getB64Value(sig.protected) {
					b64 = false
				}
			} else {
				if b64 != getB64Value(sig.protected) {
					return errors.Errorf(`b64 value must be the same for all signatures`)
				}
			}

			m.signatures = append(m.signatures, &sig)
		}
	} else { 		if len(mup.Signatures) != 0 {
			return errors.New(`invalid format ("signatures" and "signature" keys cannot both be present)`)
		}

		var sig Signature
		sig.headers = mup.Header
		if src := mup.Protected; src != nil {
			decoded, err := base64.DecodeString(*src)
			if err != nil {
				return errors.Wrap(err, `failed to base64 decode flattened protected headers`)
			}
			prt := NewHeaders()
			prt.(*stdHeaders).SetDecodeCtx(m.DecodeCtx())
			if err := json.Unmarshal(decoded, prt); err != nil {
				return errors.Wrap(err, `failed to unmarshal flattened protected headers`)
			}
						prt.(*stdHeaders).SetDecodeCtx(nil)
			sig.protected = prt
		}

		if sig.protected == nil {
						sig.protected = NewHeaders()
		}

		decoded, err := base64.DecodeString(*mup.Signature)
		if err != nil {
			return errors.Wrap(err, `failed to base64 decode flattened signature`)
		}
		sig.signature = decoded

		m.signatures = []*Signature{&sig}
		b64 = getB64Value(sig.protected)
	}

	if mup.Payload != nil {
		if !b64 { 
			m.payload = []byte(*mup.Payload)
		} else {
			decoded, err := base64.DecodeString(*mup.Payload)
			if err != nil {
				return errors.Wrap(err, `failed to base64 decode payload`)
			}
			m.payload = decoded
		}
	}
	m.b64 = b64
	return nil
}
