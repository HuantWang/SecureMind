func TestGH681(t *testing.T) {
	privkey, err := jwxtest.GenerateRsaKey()
	if !assert.NoError(t, err, "failed to create private key") {
		return
	}

	buf, err := jws.Sign(nil, jwa.RS256, privkey, jws.WithDetachedPayload([]byte("Lorem ipsum")))
	if !assert.NoError(t, err, "failed to sign payload") {
		return
	}

	_, err = jws.Verify(buf, jwa.RS256, &privkey.PublicKey, jws.WithDetachedPayload([]byte("Lorem ipsum")))
	if !assert.NoError(t, err, "failed to verify JWS message") {
		return
	}
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

	decoded, err := base64.DecodeString(*sup.Signature)
	if err != nil {
		return errors.Wrap(err, `failed to base decode signature`)
	}
	s.signature = decoded
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
	if mup.Signature == nil { 
		if len(mup.Signatures) == 0 {
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
	} else {
		if len(mup.Signatures) != 0 {
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
