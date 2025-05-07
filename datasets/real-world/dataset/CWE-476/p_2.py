class Backend:
        name = "openssl"

        _fips_ciphers = (AES,)
        _fips_hashes = (
        hashes.SHA224,
        hashes.SHA256,
        hashes.SHA384,
        hashes.SHA512,
        hashes.SHA512_224,
        hashes.SHA512_256,
        hashes.SHA3_224,
        hashes.SHA3_256,
        hashes.SHA3_384,
        hashes.SHA3_512,
        hashes.SHAKE128,
        hashes.SHAKE256,
    )
    _fips_ecdh_curves = (
        ec.SECP224R1,
        ec.SECP256R1,
        ec.SECP384R1,
        ec.SECP521R1,
    )
    _fips_rsa_min_key_size = 2048
    _fips_rsa_min_public_exponent = 65537
    _fips_dsa_min_modulus = 1 << 2048
    _fips_dh_min_key_size = 2048
    _fips_dh_min_modulus = 1 << _fips_dh_min_key_size

    def __init__(self) -> None:
        self._binding = binding.Binding()
        self._ffi = self._binding.ffi
        self._lib = self._binding.lib
        self._fips_enabled = rust_openssl.is_fips_enabled()

    def __repr__(self) -> str:
        return "<OpenSSLBackend(version: {}, FIPS: {}, Legacy: {})>".format(
            self.openssl_version_text(),
            self._fips_enabled,
            rust_openssl._legacy_provider_loaded,
        )

    def openssl_assert(self, ok: bool) -> None:
        return binding._openssl_assert(ok)

    def _enable_fips(self) -> None:
               self._binding._enable_fips()
        assert rust_openssl.is_fips_enabled()
        self._fips_enabled = rust_openssl.is_fips_enabled()

    def openssl_version_text(self) -> str:
               return rust_openssl.openssl_version_text()

    def openssl_version_number(self) -> int:
        return rust_openssl.openssl_version()

    def _evp_md_from_algorithm(self, algorithm: hashes.HashAlgorithm):
        if algorithm.name in ("blake2b", "blake2s"):
            alg = f"{algorithm.name}{algorithm.digest_size * 8}".encode(
                "ascii"
            )
        else:
            alg = algorithm.name.encode("ascii")

        evp_md = self._lib.EVP_get_digestbyname(alg)
        return evp_md

    def _evp_md_non_null_from_algorithm(self, algorithm: hashes.HashAlgorithm):
        evp_md = self._evp_md_from_algorithm(algorithm)
        self.openssl_assert(evp_md != self._ffi.NULL)
        return evp_md

    def hash_supported(self, algorithm: hashes.HashAlgorithm) -> bool:
        if self._fips_enabled and not isinstance(algorithm, self._fips_hashes):
            return False

        evp_md = self._evp_md_from_algorithm(algorithm)
        return evp_md != self._ffi.NULL

    def signature_hash_supported(
        self, algorithm: hashes.HashAlgorithm
    ) -> bool:
                if self._fips_enabled and isinstance(algorithm, hashes.SHA1):
            return False
        return self.hash_supported(algorithm)

    def scrypt_supported(self) -> bool:
        if self._fips_enabled:
            return False
        else:
            return hasattr(rust_openssl.kdf, "derive_scrypt")

    def hmac_supported(self, algorithm: hashes.HashAlgorithm) -> bool:
             if self._fips_enabled and isinstance(algorithm, hashes.SHA1):
            return True

        return self.hash_supported(algorithm)

    def cipher_supported(self, cipher: CipherAlgorithm, mode: Mode) -> bool:
        if self._fips_enabled:
                       if not isinstance(cipher, self._fips_ciphers):
                return False

        return rust_openssl.ciphers.cipher_supported(cipher, mode)

    def pbkdf2_hmac_supported(self, algorithm: hashes.HashAlgorithm) -> bool:
        return self.hmac_supported(algorithm)

    def _consume_errors(self) -> list[rust_openssl.OpenSSLError]:
        return rust_openssl.capture_error_stack()

    def _bytes_to_bio(self, data: bytes) -> _MemoryBIO:
              data_ptr = self._ffi.from_buffer(data)
        bio = self._lib.BIO_new_mem_buf(data_ptr, len(data))
        self.openssl_assert(bio != self._ffi.NULL)

        return _MemoryBIO(self._ffi.gc(bio, self._lib.BIO_free), data_ptr)

    def _create_mem_bio_gc(self):
             bio_method = self._lib.BIO_s_mem()
        self.openssl_assert(bio_method != self._ffi.NULL)
        bio = self._lib.BIO_new(bio_method)
        self.openssl_assert(bio != self._ffi.NULL)
        bio = self._ffi.gc(bio, self._lib.BIO_free)
        return bio

    def _read_mem_bio(self, bio) -> bytes:
             buf = self._ffi.new("char **")
        buf_len = self._lib.BIO_get_mem_data(bio, buf)
        self.openssl_assert(buf_len > 0)
        self.openssl_assert(buf[0] != self._ffi.NULL)
        bio_data = self._ffi.buffer(buf[0], buf_len)[:]
        return bio_data

    def _oaep_hash_supported(self, algorithm: hashes.HashAlgorithm) -> bool:
        if self._fips_enabled and isinstance(algorithm, hashes.SHA1):
            return False

        return isinstance(
            algorithm,
            (
                hashes.SHA1,
                hashes.SHA224,
                hashes.SHA256,
                hashes.SHA384,
                hashes.SHA512,
            ),
        )

    def rsa_padding_supported(self, padding: AsymmetricPadding) -> bool:
        if isinstance(padding, PKCS1v15):
            return True
        elif isinstance(padding, PSS) and isinstance(padding._mgf, MGF1):
                       if self._fips_enabled and isinstance(
                padding._mgf._algorithm, hashes.SHA1
            ):
                return True
            else:
                return self.hash_supported(padding._mgf._algorithm)
        elif isinstance(padding, OAEP) and isinstance(padding._mgf, MGF1):
            return self._oaep_hash_supported(
                padding._mgf._algorithm
            ) and self._oaep_hash_supported(padding._algorithm)
        else:
            return False

    def rsa_encryption_supported(self, padding: AsymmetricPadding) -> bool:
        if self._fips_enabled and isinstance(padding, PKCS1v15):
            return False
        else:
            return self.rsa_padding_supported(padding)

    def dsa_supported(self) -> bool:
        return (
            not rust_openssl.CRYPTOGRAPHY_IS_BORINGSSL
            and not self._fips_enabled
        )

    def dsa_hash_supported(self, algorithm: hashes.HashAlgorithm) -> bool:
        if not self.dsa_supported():
            return False
        return self.signature_hash_supported(algorithm)

    def cmac_algorithm_supported(self, algorithm) -> bool:
        return self.cipher_supported(
            algorithm, CBC(b"\x00" * algorithm.block_size)
        )

    def _cert2ossl(self, cert: x509.Certificate) -> typing.Any:
        data = cert.public_bytes(serialization.Encoding.DER)
        mem_bio = self._bytes_to_bio(data)
        x509 = self._lib.d2i_X509_bio(mem_bio.bio, self._ffi.NULL)
        self.openssl_assert(x509 != self._ffi.NULL)
        x509 = self._ffi.gc(x509, self._lib.X509_free)
        return x509

    def _ossl2cert(self, x509_ptr: typing.Any) -> x509.Certificate:
        bio = self._create_mem_bio_gc()
        res = self._lib.i2d_X509_bio(bio, x509_ptr)
        self.openssl_assert(res == 1)
        return x509.load_der_x509_certificate(self._read_mem_bio(bio))

    def _key2ossl(self, key: PKCS12PrivateKeyTypes) -> typing.Any:
        data = key.private_bytes(
            serialization.Encoding.DER,
            serialization.PrivateFormat.PKCS8,
            serialization.NoEncryption(),
        )
        mem_bio = self._bytes_to_bio(data)

        evp_pkey = self._lib.d2i_PrivateKey_bio(
            mem_bio.bio,
            self._ffi.NULL,
        )
        self.openssl_assert(evp_pkey != self._ffi.NULL)
        return self._ffi.gc(evp_pkey, self._lib.EVP_PKEY_free)

    def elliptic_curve_supported(self, curve: ec.EllipticCurve) -> bool:
        if self._fips_enabled and not isinstance(
            curve, self._fips_ecdh_curves
        ):
            return False

        return rust_openssl.ec.curve_supported(curve)

    def elliptic_curve_signature_algorithm_supported(
        self,
        signature_algorithm: ec.EllipticCurveSignatureAlgorithm,
        curve: ec.EllipticCurve,
    ) -> bool:
                if not isinstance(signature_algorithm, ec.ECDSA):
            return False

        return self.elliptic_curve_supported(curve) and (
            isinstance(signature_algorithm.algorithm, asym_utils.Prehashed)
            or self.hash_supported(signature_algorithm.algorithm)
        )

    def elliptic_curve_exchange_algorithm_supported(
        self, algorithm: ec.ECDH, curve: ec.EllipticCurve
    ) -> bool:
        return self.elliptic_curve_supported(curve) and isinstance(
            algorithm, ec.ECDH
        )

    def dh_supported(self) -> bool:
        return not rust_openssl.CRYPTOGRAPHY_IS_BORINGSSL

    def dh_x942_serialization_supported(self) -> bool:
        return self._lib.Cryptography_HAS_EVP_PKEY_DHX == 1

    def x25519_supported(self) -> bool:
                if (
            self._fips_enabled
            and not rust_openssl.CRYPTOGRAPHY_OPENSSL_320_OR_GREATER
        ):
            return False
        return True

    def x448_supported(self) -> bool:
        # Beginning with OpenSSL 3.2.0, X448 is considered FIPS.
        if (
            self._fips_enabled
            and not rust_openssl.CRYPTOGRAPHY_OPENSSL_320_OR_GREATER
        ):
            return False
        return (
            not rust_openssl.CRYPTOGRAPHY_IS_LIBRESSL
            and not rust_openssl.CRYPTOGRAPHY_IS_BORINGSSL
        )

    def ed25519_supported(self) -> bool:
        if self._fips_enabled:
            return False
        return True

    def ed448_supported(self) -> bool:
        if self._fips_enabled:
            return False
        return (
            not rust_openssl.CRYPTOGRAPHY_IS_LIBRESSL
            and not rust_openssl.CRYPTOGRAPHY_IS_BORINGSSL
        )

    def _zero_data(self, data, length: int) -> None:
                for i in range(length):
            data[i] = 0

    @contextlib.contextmanager
    def _zeroed_null_terminated_buf(self, data):
               if data is None:
            yield self._ffi.NULL
        else:
            data_len = len(data)
            buf = self._ffi.new("char[]", data_len + 1)
            self._ffi.memmove(buf, data, data_len)
            try:
                yield buf
            finally:
                # Cast to a uint8_t * so we can assign by integer
                self._zero_data(self._ffi.cast("uint8_t *", buf), data_len)

    def load_key_and_certificates_from_pkcs12(
        self, data: bytes, password: bytes | None
    ) -> tuple[
        PrivateKeyTypes | None,
        x509.Certificate | None,
        list[x509.Certificate],
    ]:
        pkcs12 = self.load_pkcs12(data, password)
        return (
            pkcs12.key,
            pkcs12.cert.certificate if pkcs12.cert else None,
            [cert.certificate for cert in pkcs12.additional_certs],
        )

    def load_pkcs12(
        self, data: bytes, password: bytes | None
    ) -> PKCS12KeyAndCertificates:
        if password is not None:
            utils._check_byteslike("password", password)

        bio = self._bytes_to_bio(data)
        p12 = self._lib.d2i_PKCS12_bio(bio.bio, self._ffi.NULL)
        if p12 == self._ffi.NULL:
            self._consume_errors()
            raise ValueError("Could not deserialize PKCS12 data")

        p12 = self._ffi.gc(p12, self._lib.PKCS12_free)
        evp_pkey_ptr = self._ffi.new("EVP_PKEY **")
        x509_ptr = self._ffi.new("X509 **")
        sk_x509_ptr = self._ffi.new("Cryptography_STACK_OF_X509 **")
        with self._zeroed_null_terminated_buf(password) as password_buf:
            res = self._lib.PKCS12_parse(
                p12, password_buf, evp_pkey_ptr, x509_ptr, sk_x509_ptr
            )
        if res == 0:
            self._consume_errors()
            raise ValueError("Invalid password or PKCS12 data")

        cert = None
        key = None
        additional_certificates = []

        if evp_pkey_ptr[0] != self._ffi.NULL:
            evp_pkey = self._ffi.gc(evp_pkey_ptr[0], self._lib.EVP_PKEY_free)
                        key = rust_openssl.keys.private_key_from_ptr(
                int(self._ffi.cast("uintptr_t", evp_pkey)),
                unsafe_skip_rsa_key_validation=False,
            )

        if x509_ptr[0] != self._ffi.NULL:
            x509 = self._ffi.gc(x509_ptr[0], self._lib.X509_free)
            cert_obj = self._ossl2cert(x509)
            name = None
            maybe_name = self._lib.X509_alias_get0(x509, self._ffi.NULL)
            if maybe_name != self._ffi.NULL:
                name = self._ffi.string(maybe_name)
            cert = PKCS12Certificate(cert_obj, name)

        if sk_x509_ptr[0] != self._ffi.NULL:
            sk_x509 = self._ffi.gc(sk_x509_ptr[0], self._lib.sk_X509_free)
            num = self._lib.sk_X509_num(sk_x509_ptr[0])

                       indices: typing.Iterable[int]
            if (
                rust_openssl.CRYPTOGRAPHY_OPENSSL_300_OR_GREATER
                or rust_openssl.CRYPTOGRAPHY_IS_BORINGSSL
            ):
                indices = range(num)
            else:
                indices = reversed(range(num))

            for i in indices:
                x509 = self._lib.sk_X509_value(sk_x509, i)
                self.openssl_assert(x509 != self._ffi.NULL)
                x509 = self._ffi.gc(x509, self._lib.X509_free)
                addl_cert = self._ossl2cert(x509)
                addl_name = None
                maybe_name = self._lib.X509_alias_get0(x509, self._ffi.NULL)
                if maybe_name != self._ffi.NULL:
                    addl_name = self._ffi.string(maybe_name)
                additional_certificates.append(
                    PKCS12Certificate(addl_cert, addl_name)
                )

        return PKCS12KeyAndCertificates(key, cert, additional_certificates)

    def serialize_key_and_certificates_to_pkcs12(
        self,
        name: bytes | None,
        key: PKCS12PrivateKeyTypes | None,
        cert: x509.Certificate | None,
        cas: list[_PKCS12CATypes] | None,
        encryption_algorithm: serialization.KeySerializationEncryption,
    ) -> bytes:
        password = None
        if name is not None:
            utils._check_bytes("name", name)

        if isinstance(encryption_algorithm, serialization.NoEncryption):
            nid_cert = -1
            nid_key = -1
            pkcs12_iter = 0
            mac_iter = 0
            mac_alg = self._ffi.NULL
        elif isinstance(
            encryption_algorithm, serialization.BestAvailableEncryption
        ):
                      if rust_openssl.CRYPTOGRAPHY_OPENSSL_300_OR_GREATER:
                nid_cert = self._lib.NID_aes_256_cbc
                nid_key = self._lib.NID_aes_256_cbc
            else:
                nid_cert = self._lib.NID_pbe_WithSHA1And3_Key_TripleDES_CBC
                nid_key = self._lib.NID_pbe_WithSHA1And3_Key_TripleDES_CBC
                      pkcs12_iter = 20000
                        mac_iter = 1
                     mac_alg = self._ffi.NULL
            password = encryption_algorithm.password
        elif (
            isinstance(
                encryption_algorithm, serialization._KeySerializationEncryption
            )
            and encryption_algorithm._format
            is serialization.PrivateFormat.PKCS12
        ):
                      nid_cert = 0
            nid_key = 0
                        pkcs12_iter = 20000
                        mac_iter = 1
            password = encryption_algorithm.password
            keycertalg = encryption_algorithm._key_cert_algorithm
            if keycertalg is PBES.PBESv1SHA1And3KeyTripleDESCBC:
                nid_cert = self._lib.NID_pbe_WithSHA1And3_Key_TripleDES_CBC
                nid_key = self._lib.NID_pbe_WithSHA1And3_Key_TripleDES_CBC
            elif keycertalg is PBES.PBESv2SHA256AndAES256CBC:
                if not rust_openssl.CRYPTOGRAPHY_OPENSSL_300_OR_GREATER:
                    raise UnsupportedAlgorithm(
                        "PBESv2 is not supported by this version of OpenSSL"
                    )
                nid_cert = self._lib.NID_aes_256_cbc
                nid_key = self._lib.NID_aes_256_cbc
            else:
                assert keycertalg is None
                # We use OpenSSL's defaults

            if encryption_algorithm._hmac_hash is not None:
                if not self._lib.Cryptography_HAS_PKCS12_SET_MAC:
                    raise UnsupportedAlgorithm(
                        "Setting MAC algorithm is not supported by this "
                        "version of OpenSSL."
                    )
                mac_alg = self._evp_md_non_null_from_algorithm(
                    encryption_algorithm._hmac_hash
                )
                self.openssl_assert(mac_alg != self._ffi.NULL)
            else:
                mac_alg = self._ffi.NULL

            if encryption_algorithm._kdf_rounds is not None:
                pkcs12_iter = encryption_algorithm._kdf_rounds

        else:
            raise ValueError("Unsupported key encryption type")

        if cas is None or len(cas) == 0:
            sk_x509 = self._ffi.NULL
        else:
            sk_x509 = self._lib.sk_X509_new_null()
            sk_x509 = self._ffi.gc(sk_x509, self._lib.sk_X509_free)

            # This list is to keep the x509 values alive until end of function
            ossl_cas = []
            for ca in cas:
                if isinstance(ca, PKCS12Certificate):
                    ca_alias = ca.friendly_name
                    ossl_ca = self._cert2ossl(ca.certificate)
                    if ca_alias is None:
                        res = self._lib.X509_alias_set1(
                            ossl_ca, self._ffi.NULL, -1
                        )
                    else:
                        res = self._lib.X509_alias_set1(
                            ossl_ca, ca_alias, len(ca_alias)
                        )
                    self.openssl_assert(res == 1)
                else:
                    ossl_ca = self._cert2ossl(ca)
                ossl_cas.append(ossl_ca)
                res = self._lib.sk_X509_push(sk_x509, ossl_ca)
                backend.openssl_assert(res >= 1)

        with self._zeroed_null_terminated_buf(password) as password_buf:
            with self._zeroed_null_terminated_buf(name) as name_buf:
                ossl_cert = self._cert2ossl(cert) if cert else self._ffi.NULL
                ossl_pkey = (
                    self._key2ossl(key) if key is not None else self._ffi.NULL
                )

                p12 = self._lib.PKCS12_create(
                    password_buf,
                    name_buf,
                    ossl_pkey,
                    ossl_cert,
                    sk_x509,
                    nid_key,
                    nid_cert,
                    pkcs12_iter,
                    mac_iter,
                    0,
                )
                if p12 == self._ffi.NULL:
                    errors = self._consume_errors()
                    raise ValueError(
                        (
                            "Failed to create PKCS12 (does the key match the "
                            "certificate?)"
                        ),
                        errors,
                    )

            if (
                self._lib.Cryptography_HAS_PKCS12_SET_MAC
                and mac_alg != self._ffi.NULL
            ):
                self._lib.PKCS12_set_mac(
                    p12,
                    password_buf,
                    -1,
                    self._ffi.NULL,
                    0,
                    mac_iter,
                    mac_alg,
                )

        self.openssl_assert(p12 != self._ffi.NULL)
        p12 = self._ffi.gc(p12, self._lib.PKCS12_free)

        bio = self._create_mem_bio_gc()
        res = self._lib.i2d_PKCS12_bio(bio, p12)
        self.openssl_assert(res > 0)
        return self._read_mem_bio(bio)

    def poly1305_supported(self) -> bool:
        if self._fips_enabled:
            return False
        return True

    def pkcs7_supported(self) -> bool:
        return not rust_openssl.CRYPTOGRAPHY_IS_BORINGSSL





class TestPKCS12Creation:
    @pytest.mark.parametrize(
        (
            "kgenerator",
            "ktype",
            "kparam",
        ),
        [
            pytest.param(
                ed448.Ed448PrivateKey.generate,
                ed448.Ed448PrivateKey,
                [],
                marks=pytest.mark.supported(
                    only_if=lambda backend: backend.ed448_supported(),
                    skip_message="Requires OpenSSL with Ed448 support",
                ),
            ),
            pytest.param(
                ed25519.Ed25519PrivateKey.generate,
                ed25519.Ed25519PrivateKey,
                [],
                marks=pytest.mark.supported(
                    only_if=lambda backend: backend.ed25519_supported(),
                    skip_message="Requires OpenSSL with Ed25519 support",
                ),
            ),
            (rsa.generate_private_key, rsa.RSAPrivateKey, [65537, 1024]),
            (dsa.generate_private_key, dsa.DSAPrivateKey, [1024]),
        ]
        + [
            pytest.param(
                ec.generate_private_key, ec.EllipticCurvePrivateKey, [curve]
            )
            for curve in ec._CURVE_TYPES.values()
        ],
    )
    @pytest.mark.parametrize("name", [None, b"name"])
    @pytest.mark.parametrize(
        ("algorithm", "password"),
        [
            (serialization.BestAvailableEncryption(b"password"), b"password"),
            (serialization.NoEncryption(), None),
        ],
    )
    def test_generate_each_supported_keytype(
        self, backend, kgenerator, ktype, kparam, name, algorithm, password
    ):
        if ktype == ec.EllipticCurvePrivateKey:
            _skip_curve_unsupported(backend, *kparam)

        key = kgenerator(*kparam)

        assert isinstance(key, ktype)
        cacert, cakey = _load_ca(backend)
        now = datetime.now(timezone.utc).replace(tzinfo=None)
        cert = (
            x509.CertificateBuilder()
            .subject_name(cacert.subject)
            .issuer_name(cacert.subject)
            .public_key(key.public_key())
            .serial_number(x509.random_serial_number())
            .not_valid_before(now)
            .not_valid_after(now)
            .sign(cakey, hashes.SHA256())
        )
        assert isinstance(cert, x509.Certificate)
        p12 = serialize_key_and_certificates(
            name, key, cert, [cacert], algorithm
        )
        parsed_key, parsed_cert, parsed_more_certs = load_key_and_certificates(
            p12, password, backend
        )
        assert parsed_cert == cert
        assert isinstance(parsed_key, ktype)
        assert parsed_key.public_key().public_bytes(
            Encoding.PEM, PublicFormat.SubjectPublicKeyInfo
        ) == key.public_key().public_bytes(
            Encoding.PEM, PublicFormat.SubjectPublicKeyInfo
        )
        assert parsed_more_certs == [cacert]

    def test_generate_with_cert_key_ca(self, backend):
        cert, key = _load_ca(backend)
        cert2 = _load_cert(
            backend, os.path.join("x509", "custom", "dsa_selfsigned_ca.pem")
        )
        cert3 = _load_cert(backend, os.path.join("x509", "letsencryptx3.pem"))
        encryption = serialization.NoEncryption()
        p12 = serialize_key_and_certificates(
            None, key, cert, [cert2, cert3], encryption
        )

        parsed_key, parsed_cert, parsed_more_certs = load_key_and_certificates(
            p12, None, backend
        )
        assert parsed_cert == cert
        assert isinstance(parsed_key, ec.EllipticCurvePrivateKey)
        assert parsed_key.private_numbers() == key.private_numbers()
        assert parsed_more_certs == [cert2, cert3]

    def test_generate_cas_friendly_names(self, backend):
        cert, key = _load_ca(backend)
        cert2 = _load_cert(
            backend, os.path.join("x509", "custom", "dsa_selfsigned_ca.pem")
        )
        cert3 = _load_cert(backend, os.path.join("x509", "letsencryptx3.pem"))
        encryption = serialization.NoEncryption()
        p12 = serialize_key_and_certificates(
            b"test",
            key,
            cert,
            [
                PKCS12Certificate(cert2, b"cert2"),
                PKCS12Certificate(cert3, None),
            ],
            encryption,
        )

        p12_cert = load_pkcs12(p12, None, backend)
        cas = p12_cert.additional_certs
        assert cas[0].friendly_name == b"cert2"
        assert cas[1].friendly_name is None

    def test_generate_wrong_types(self, backend):
        cert, key = _load_ca(backend)
        cert2 = _load_cert(backend, os.path.join("x509", "letsencryptx3.pem"))
        encryption = serialization.NoEncryption()
        with pytest.raises(TypeError) as exc:
            serialize_key_and_certificates(
                b"name", cert, cert, None, encryption
            )
        assert str(exc.value) == (
            "Key must be RSA, DSA, EllipticCurve, ED25519, or ED448"
            " private key, or None."
        )
        with pytest.raises(TypeError) as exc:
            serialize_key_and_certificates(b"name", key, key, None, encryption)
        assert str(exc.value) == "cert must be a certificate or None"

        with pytest.raises(TypeError) as exc:
            serialize_key_and_certificates(b"name", key, cert, None, key)
        assert str(exc.value) == (
            "Key encryption algorithm must be a "
            "KeySerializationEncryption instance"
        )

        with pytest.raises(TypeError) as exc:
            serialize_key_and_certificates(None, key, cert, cert2, encryption)

        with pytest.raises(TypeError) as exc:
            serialize_key_and_certificates(None, key, cert, [key], encryption)
        assert str(exc.value) == "all values in cas must be certificates"

    def test_generate_no_cert(self, backend):
        _, key = _load_ca(backend)
        p12 = serialize_key_and_certificates(
            None, key, None, None, serialization.NoEncryption()
        )
        parsed_key, parsed_cert, parsed_more_certs = load_key_and_certificates(
            p12, None, backend
        )
        assert parsed_cert is None
        assert isinstance(parsed_key, ec.EllipticCurvePrivateKey)
        assert parsed_key.private_numbers() == key.private_numbers()
        assert parsed_more_certs == []

    @pytest.mark.parametrize(
        ("encryption_algorithm", "password"),
        [
            (serialization.BestAvailableEncryption(b"password"), b"password"),
            (serialization.NoEncryption(), None),
        ],
    )
    def test_generate_cas_only(self, encryption_algorithm, password, backend):
        cert, _ = _load_ca(backend)
        p12 = serialize_key_and_certificates(
            None, None, None, [cert], encryption_algorithm
        )
        parsed_key, parsed_cert, parsed_more_certs = load_key_and_certificates(
            p12, password, backend
        )
        assert parsed_cert is None
        assert parsed_key is None
        assert parsed_more_certs == [cert]

    @pytest.mark.parametrize(
        ("encryption_algorithm", "password"),
        [
            (serialization.BestAvailableEncryption(b"password"), b"password"),
            (serialization.NoEncryption(), None),
        ],
    )
    def test_generate_cert_only(self, encryption_algorithm, password, backend):
               cert, _ = _load_ca(backend)
        p12 = serialize_key_and_certificates(
            None, None, cert, [], encryption_algorithm
        )
        parsed_key, parsed_cert, parsed_more_certs = load_key_and_certificates(
            p12, password, backend
        )
        assert parsed_cert is None
        assert parsed_key is None
        assert parsed_more_certs == [cert]

    def test_must_supply_something(self):
        with pytest.raises(ValueError) as exc:
            serialize_key_and_certificates(
                None, None, None, None, serialization.NoEncryption()
            )
        assert str(exc.value) == (
            "You must supply at least one of key, cert, or cas"
        )

    def test_generate_unsupported_encryption_type(self, backend):
        cert, key = _load_ca(backend)
        with pytest.raises(ValueError) as exc:
            serialize_key_and_certificates(
                None,
                key,
                cert,
                None,
                DummyKeySerializationEncryption(),
            )
        assert str(exc.value) == "Unsupported key encryption type"

    @pytest.mark.parametrize(
        ("enc_alg", "enc_alg_der"),
        [
            (
                PBES.PBESv2SHA256AndAES256CBC,
                [
                    b"\x06\x09\x2a\x86\x48\x86\xf7\x0d\x01\x05\x0d",  # PBESv2
                    b"\x06\x09\x60\x86\x48\x01\x65\x03\x04\x01\x2a",  # AES
                ],
            ),
            (
                PBES.PBESv1SHA1And3KeyTripleDESCBC,
                [b"\x06\x0a\x2a\x86\x48\x86\xf7\x0d\x01\x0c\x01\x03"],
            ),
            (
                None,
                [],
            ),
        ],
    )
    @pytest.mark.parametrize(
        ("mac_alg", "mac_alg_der"),
        [
            (hashes.SHA1(), b"\x06\x05\x2b\x0e\x03\x02\x1a"),
            (hashes.SHA256(), b"\x06\t`\x86H\x01e\x03\x04\x02\x01"),
            (None, None),
        ],
    )
    @pytest.mark.parametrize(
        ("iters", "iter_der"),
        [
            (420, b"\x02\x02\x01\xa4"),
            (22222, b"\x02\x02\x56\xce"),
            (None, None),
        ],
    )
    def test_key_serialization_encryption(
        self,
        backend,
        enc_alg,
        enc_alg_der,
        mac_alg,
        mac_alg_der,
        iters,
        iter_der,
    ):
        if (
            enc_alg is PBES.PBESv2SHA256AndAES256CBC
        ) and not backend._lib.CRYPTOGRAPHY_OPENSSL_300_OR_GREATER:
            pytest.skip("PBESv2 is not supported on OpenSSL < 3.0")

        if (
            mac_alg is not None
            and not backend._lib.Cryptography_HAS_PKCS12_SET_MAC
        ):
            pytest.skip("PKCS12_set_mac is not supported (boring)")

        builder = serialization.PrivateFormat.PKCS12.encryption_builder()
        if enc_alg is not None:
            builder = builder.key_cert_algorithm(enc_alg)
        if mac_alg is not None:
            builder = builder.hmac_hash(mac_alg)
        if iters is not None:
            builder = builder.kdf_rounds(iters)

        encryption = builder.build(b"password")
        key = ec.generate_private_key(ec.SECP256R1())
        cacert, cakey = _load_ca(backend)
        now = datetime.now(timezone.utc).replace(tzinfo=None)
        cert = (
            x509.CertificateBuilder()
            .subject_name(cacert.subject)
            .issuer_name(cacert.subject)
            .public_key(key.public_key())
            .serial_number(x509.random_serial_number())
            .not_valid_before(now)
            .not_valid_after(now)
            .sign(cakey, hashes.SHA256())
        )
        assert isinstance(cert, x509.Certificate)
        p12 = serialize_key_and_certificates(
            b"name", key, cert, [cacert], encryption
        )
                for der in enc_alg_der:
            assert der in p12
        if mac_alg_der is not None:
            assert mac_alg_der in p12
        if iter_der is not None:
            assert iter_der in p12
        parsed_key, parsed_cert, parsed_more_certs = load_key_and_certificates(
            p12, b"password", backend
        )
        assert parsed_cert == cert
        assert isinstance(parsed_key, ec.EllipticCurvePrivateKey)
        assert parsed_key.public_key().public_bytes(
            Encoding.PEM, PublicFormat.SubjectPublicKeyInfo
        ) == key.public_key().public_bytes(
            Encoding.PEM, PublicFormat.SubjectPublicKeyInfo
        )
        assert parsed_more_certs == [cacert]

    @pytest.mark.supported(
        only_if=lambda backend: (
            not backend._lib.CRYPTOGRAPHY_OPENSSL_300_OR_GREATER
        ),
        skip_message="Requires OpenSSL < 3.0.0 (or Libre/Boring)",
    )
    @pytest.mark.parametrize(
        ("algorithm"),
        [
            serialization.PrivateFormat.PKCS12.encryption_builder()
            .key_cert_algorithm(PBES.PBESv2SHA256AndAES256CBC)
            .build(b"password"),
        ],
    )
    def test_key_serialization_encryption_unsupported(
        self, algorithm, backend
    ):
        cacert, cakey = _load_ca(backend)
        with pytest.raises(UnsupportedAlgorithm):
            serialize_key_and_certificates(
                b"name", cakey, cacert, [], algorithm
            )

    @pytest.mark.supported(
        only_if=lambda backend: (
            not backend._lib.Cryptography_HAS_PKCS12_SET_MAC
        ),
        skip_message="Requires OpenSSL without PKCS12_set_mac (boring only)",
    )
    @pytest.mark.parametrize(
        "algorithm",
        [
            serialization.PrivateFormat.PKCS12.encryption_builder()
            .key_cert_algorithm(PBES.PBESv1SHA1And3KeyTripleDESCBC)
            .hmac_hash(hashes.SHA256())
            .build(b"password"),
        ],
    )
    def test_key_serialization_encryption_set_mac_unsupported(
        self, algorithm, backend
    ):
        cacert, cakey = _load_ca(backend)
        with pytest.raises(UnsupportedAlgorithm):
            serialize_key_and_certificates(
                b"name", cakey, cacert, [], algorithm
            )

    @pytest.mark.supported(
        only_if=lambda backend: backend._lib.Cryptography_HAS_PKCS12_SET_MAC,
        skip_message="Requires OpenSSL with PKCS12_set_mac",
    )
    def test_set_mac_key_certificate_mismatch(self, backend):
        cacert, _ = _load_ca(backend)
        key = ec.generate_private_key(ec.SECP256R1())
        encryption = (
            serialization.PrivateFormat.PKCS12.encryption_builder()
            .hmac_hash(hashes.SHA256())
            .build(b"password")
        )

        with pytest.raises(ValueError):
            serialize_key_and_certificates(
                b"name", key, cacert, [], encryption
            )