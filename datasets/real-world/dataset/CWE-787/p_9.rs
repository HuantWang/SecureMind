impl<Pk: MiniscriptKey, Ctx: ScriptContext> TerminalStack<Pk, Ctx> {
       fn pop(&mut self) -> Option<Miniscript<Pk, Ctx>> { self.0.pop() }

       fn reduce0(&mut self, ms: Terminal<Pk, Ctx>) -> Result<(), Error> {
        let ms = Miniscript::from_ast(ms)?;
        self.0.push(ms);
        Ok(())
    }

       fn reduce1<F>(&mut self, wrap: F) -> Result<(), Error>
    where
        F: FnOnce(Arc<Miniscript<Pk, Ctx>>) -> Terminal<Pk, Ctx>,
    {
        let top = self.pop().unwrap();
        let wrapped_ms = wrap(Arc::new(top));

        self.reduce0(wrapped_ms)
    }

       fn reduce2<F>(&mut self, wrap: F) -> Result<(), Error>
    where
        F: FnOnce(Arc<Miniscript<Pk, Ctx>>, Arc<Miniscript<Pk, Ctx>>) -> Terminal<Pk, Ctx>,
    {
        let left = self.pop().unwrap();
        let right = self.pop().unwrap();

        let wrapped_ms = wrap(Arc::new(left), Arc::new(right));

        self.reduce0(wrapped_ms)
    }
}





pub fn parse<Ctx: ScriptContext>(
    tokens: &mut TokenIter,
) -> Result<Miniscript<Ctx::Key, Ctx>, Error> {
    let mut non_term = Vec::with_capacity(tokens.len());
    let mut term = TerminalStack(Vec::with_capacity(tokens.len()));

       non_term.push(NonTerm::MaybeAndV);
    non_term.push(NonTerm::Expression);
    loop {
        match non_term.pop() {
            Some(NonTerm::Expression) => {
                match_token!(
                    tokens,
                                       Tk::Bytes33(pk) => {
                        let ret = Ctx::Key::from_slice(pk)
                            .map_err(|e| Error::PubKeyCtxError(e, Ctx::name_str()))?;
                        term.reduce0(Terminal::PkK(ret))?
                    },
                    Tk::Bytes65(pk) => {
                        let ret = Ctx::Key::from_slice(pk)
                            .map_err(|e| Error::PubKeyCtxError(e, Ctx::name_str()))?;
                        term.reduce0(Terminal::PkK(ret))?
                    },
                                       Tk::Bytes32(pk) => {
                        let ret = Ctx::Key::from_slice(pk).map_err(|e| Error::PubKeyCtxError(e, Ctx::name_str()))?;
                        term.reduce0(Terminal::PkK(ret))?
                    },
                                       Tk::CheckSig => {
                        non_term.push(NonTerm::Check);
                        non_term.push(NonTerm::Expression);
                    },
                                        Tk::Verify => match_token!(
                        tokens,
                        Tk::Equal => match_token!(
                            tokens,
                            Tk::Hash20(hash) => match_token!(
                                tokens,
                                Tk::Hash160 => match_token!(
                                    tokens,
                                    Tk::Dup => {
                                        term.reduce0(Terminal::RawPkH(
                                            hash160::Hash::from_slice(hash).expect("valid size")
                                        ))?
                                    },
                                    Tk::Verify, Tk::Equal, Tk::Num(32), Tk::Size => {
                                        non_term.push(NonTerm::Verify);
                                        term.reduce0(Terminal::Hash160(
                                            hash160::Hash::from_slice(hash).expect("valid size")
                                        ))?
                                    },
                                ),
                                Tk::Ripemd160, Tk::Verify, Tk::Equal, Tk::Num(32), Tk::Size => {
                                    non_term.push(NonTerm::Verify);
                                    term.reduce0(Terminal::Ripemd160(
                                        ripemd160::Hash::from_slice(hash).expect("valid size")
                                    ))?
                                },
                            ),
                                                    Tk::Bytes32(hash) => match_token!(
                                tokens,
                                Tk::Sha256, Tk::Verify, Tk::Equal, Tk::Num(32), Tk::Size => {
                                    non_term.push(NonTerm::Verify);
                                    term.reduce0(Terminal::Sha256(
                                        sha256::Hash::from_slice(hash).expect("valid size")
                                    ))?
                                },
                                Tk::Hash256, Tk::Verify, Tk::Equal, Tk::Num(32), Tk::Size => {
                                    non_term.push(NonTerm::Verify);
                                    term.reduce0(Terminal::Hash256(
                                        hash256::Hash::from_slice(hash).expect("valid size")
                                    ))?
                                },
                            ),
                            Tk::Num(k) => {
                                non_term.push(NonTerm::Verify);
                                non_term.push(NonTerm::ThreshW {
                                    k: k as usize,
                                    n: 0
                                });
                            },
                        ),
                        x => {
                            tokens.un_next(x);
                            non_term.push(NonTerm::Verify);
                            non_term.push(NonTerm::Expression);
                        },
                    ),
                    Tk::ZeroNotEqual => {
                        non_term.push(NonTerm::ZeroNotEqual);
                        non_term.push(NonTerm::Expression);
                    },
                                    Tk::CheckSequenceVerify, Tk::Num(n)
                        => term.reduce0(Terminal::Older(RelLockTime::from_consensus(n).map_err(Error::RelativeLockTime)?))?,
                    Tk::CheckLockTimeVerify, Tk::Num(n)
                        => term.reduce0(Terminal::After(AbsLockTime::from_consensus(n).map_err(Error::AbsoluteLockTime)?))?,
                                     Tk::Equal => match_token!(
                        tokens,
                        Tk::Bytes32(hash) => match_token!(
                            tokens,
                            Tk::Sha256,
                            Tk::Verify,
                            Tk::Equal,
                            Tk::Num(32),
                            Tk::Size => term.reduce0(Terminal::Sha256(
                                sha256::Hash::from_slice(hash).expect("valid size")
                            ))?,
                            Tk::Hash256,
                            Tk::Verify,
                            Tk::Equal,
                            Tk::Num(32),
                            Tk::Size => term.reduce0(Terminal::Hash256(
                                hash256::Hash::from_slice(hash).expect("valid size")
                            ))?,
                        ),
                        Tk::Hash20(hash) => match_token!(
                            tokens,
                            Tk::Ripemd160,
                            Tk::Verify,
                            Tk::Equal,
                            Tk::Num(32),
                            Tk::Size => term.reduce0(Terminal::Ripemd160(
                                ripemd160::Hash::from_slice(hash).expect("valid size")
                            ))?,
                            Tk::Hash160,
                            Tk::Verify,
                            Tk::Equal,
                            Tk::Num(32),
                            Tk::Size => term.reduce0(Terminal::Hash160(
                                hash160::Hash::from_slice(hash).expect("valid size")
                            ))?,
                        ),
                                             Tk::Num(k) => {
                            non_term.push(NonTerm::ThreshW {
                                k: k as usize,
                                n: 0
                            });
                                               },
                    ),
                                    Tk::Num(0) => term.reduce0(Terminal::False)?,
                    Tk::Num(1) => term.reduce0(Terminal::True)?,
                    Tk::EndIf => {
                        non_term.push(NonTerm::EndIf);
                        non_term.push(NonTerm::MaybeAndV);
                        non_term.push(NonTerm::Expression);
                    },
                                    Tk::BoolAnd => {
                        non_term.push(NonTerm::AndB);
                        non_term.push(NonTerm::Expression);
                        non_term.push(NonTerm::WExpression);
                    },
                    Tk::BoolOr => {
                        non_term.push(NonTerm::OrB);
                        non_term.push(NonTerm::Expression);
                        non_term.push(NonTerm::WExpression);
                    },
                                  Tk::CheckMultiSig, Tk::Num(n) => {
                                           if n as usize > MAX_PUBKEYS_PER_MULTISIG {
                            return Err(Error::CmsTooManyKeys(n));
                        }
                        let mut keys = Vec::with_capacity(n as usize);
                        for _ in 0..n {
                            match_token!(
                                tokens,
                                Tk::Bytes33(pk) => keys.push(<Ctx::Key>::from_slice(pk)
                                    .map_err(|e| Error::PubKeyCtxError(e, Ctx::name_str()))?),
                                Tk::Bytes65(pk) => keys.push(<Ctx::Key>::from_slice(pk)
                                    .map_err(|e| Error::PubKeyCtxError(e, Ctx::name_str()))?),
                            );
                        }
                        let k = match_token!(
                            tokens,
                            Tk::Num(k) => k,
                        );
                        keys.reverse();
                        let thresh = Threshold::new(k as usize, keys).map_err(Error::Threshold)?;
                        term.reduce0(Terminal::Multi(thresh))?;
                    },
                                       Tk::NumEqual, Tk::Num(k) => {
                                               if k as usize > MAX_PUBKEYS_IN_CHECKSIGADD {
                            return Err(Error::MultiATooManyKeys(MAX_PUBKEYS_IN_CHECKSIGADD as u64))
                        }
                        let mut keys = Vec::with_capacity(k as usize); // atleast k capacity
                        while tokens.peek() == Some(&Tk::CheckSigAdd) {
                            match_token!(
                                tokens,
                                Tk::CheckSigAdd, Tk::Bytes32(pk) => keys.push(<Ctx::Key>::from_slice(pk)
                                    .map_err(|e| Error::PubKeyCtxError(e, Ctx::name_str()))?),
                            );
                        }
                                                match_token!(
                            tokens,
                            Tk::CheckSig, Tk::Bytes32(pk) => keys.push(<Ctx::Key>::from_slice(pk)
                                .map_err(|e| Error::PubKeyCtxError(e, Ctx::name_str()))?),
                        );
                        keys.reverse();
                        let thresh = Threshold::new(k as usize, keys).map_err(Error::Threshold)?;
                        term.reduce0(Terminal::MultiA(thresh))?;
                    },
                );
            }
            Some(NonTerm::MaybeAndV) => {
                             if is_and_v(tokens) {
                    non_term.push(NonTerm::AndV);
                    non_term.push(NonTerm::Expression);
                }
            }
            Some(NonTerm::Swap) => {
                               match_token!(
                    tokens,
                    Tk::Swap => {},
                );
                term.reduce1(Terminal::Swap)?;
                            }
            Some(NonTerm::Alt) => {
                match_token!(
                    tokens,
                    Tk::ToAltStack => {},
                );
                term.reduce1(Terminal::Alt)?;
            }
            Some(NonTerm::Check) => term.reduce1(Terminal::Check)?,
            Some(NonTerm::DupIf) => term.reduce1(Terminal::DupIf)?,
            Some(NonTerm::Verify) => term.reduce1(Terminal::Verify)?,
            Some(NonTerm::NonZero) => term.reduce1(Terminal::NonZero)?,
            Some(NonTerm::ZeroNotEqual) => term.reduce1(Terminal::ZeroNotEqual)?,
            Some(NonTerm::AndV) => {
                if is_and_v(tokens) {
                    non_term.push(NonTerm::AndV);
                    non_term.push(NonTerm::MaybeAndV);
                } else {
                    term.reduce2(Terminal::AndV)?
                }
            }
            Some(NonTerm::AndB) => term.reduce2(Terminal::AndB)?,
            Some(NonTerm::OrB) => term.reduce2(Terminal::OrB)?,
            Some(NonTerm::OrC) => term.reduce2(Terminal::OrC)?,
            Some(NonTerm::OrD) => term.reduce2(Terminal::OrD)?,
            Some(NonTerm::Tern) => {
                let a = term.pop().unwrap();
                let b = term.pop().unwrap();
                let c = term.pop().unwrap();
                let wrapped_ms = Terminal::AndOr(Arc::new(a), Arc::new(c), Arc::new(b));

                term.0.push(Miniscript::from_ast(wrapped_ms)?);
            }
            Some(NonTerm::ThreshW { n, k }) => {
                match_token!(
                    tokens,
                    Tk::Add => {
                        non_term.push(NonTerm::ThreshW { n: n + 1, k });
                        non_term.push(NonTerm::WExpression);
                    },
                    x => {
                        tokens.un_next(x);
                        non_term.push(NonTerm::ThreshE { n: n + 1, k });
                        non_term.push(NonTerm::Expression);
                    },
                );
            }
            Some(NonTerm::ThreshE { n, k }) => {
                let mut subs = Vec::with_capacity(n);
                for _ in 0..n {
                    subs.push(Arc::new(term.pop().unwrap()));
                }
                term.reduce0(Terminal::Thresh(Threshold::new(k, subs).map_err(Error::Threshold)?))?;
            }
            Some(NonTerm::EndIf) => {
                match_token!(
                    tokens,
                    Tk::Else => {
                        non_term.push(NonTerm::EndIfElse);
                        non_term.push(NonTerm::MaybeAndV);
                        non_term.push(NonTerm::Expression);
                    },
                    Tk::If => match_token!(
                        tokens,
                        Tk::Dup => non_term.push(NonTerm::DupIf),
                        Tk::ZeroNotEqual, Tk::Size
                            => non_term.push(NonTerm::NonZero),
                    ),
                    Tk::NotIf => {
                        non_term.push(NonTerm::EndIfNotIf);
                    },
                );
            }
            Some(NonTerm::EndIfNotIf) => {
                match_token!(
                    tokens,
                    Tk::IfDup => non_term.push(NonTerm::OrD),
                    x => {
                        tokens.un_next(x);
                        non_term.push(NonTerm::OrC);
                    },
                );
                non_term.push(NonTerm::Expression);
            }
            Some(NonTerm::EndIfElse) => {
                match_token!(
                    tokens,
                    Tk::If => {
                        term.reduce2(Terminal::OrI)?;
                    },
                    Tk::NotIf => {
                        non_term.push(NonTerm::Tern);
                        non_term.push(NonTerm::Expression);
                    },
                );
            }
            Some(NonTerm::WExpression) => {
                            match_token!(tokens,
                    Tk::FromAltStack => { non_term.push(NonTerm::Alt);},
                    tok => { tokens.un_next(tok); non_term.push(NonTerm::Swap);},);
                non_term.push(NonTerm::MaybeAndV);
                non_term.push(NonTerm::Expression);
            }
            None => {
                // Done :)
                break;
            }
        }
    }

    assert_eq!(non_term.len(), 0);
    assert_eq!(term.0.len(), 1);
    Ok(term.pop().unwrap())
}






mod private {
    use core::marker::PhantomData;

    use super::types::{ExtData, Type};
    pub use crate::miniscript::context::ScriptContext;
    use crate::miniscript::types;
    use crate::{Error, MiniscriptKey, Terminal, MAX_RECURSION_DEPTH};

      #[derive(Clone)]
    pub struct Miniscript<Pk: MiniscriptKey, Ctx: ScriptContext> {
                pub node: Terminal<Pk, Ctx>,
               pub ty: types::Type,
               pub ext: types::extra_props::ExtData,
             phantom: PhantomData<Ctx>,
    }
    impl<Pk: MiniscriptKey, Ctx: ScriptContext> Miniscript<Pk, Ctx> {
               pub const TRUE: Self = Miniscript {
            node: Terminal::True,
            ty: types::Type::TRUE,
            ext: types::extra_props::ExtData::TRUE,
            phantom: PhantomData,
        };

               pub const FALSE: Self = Miniscript {
            node: Terminal::False,
            ty: types::Type::FALSE,
            ext: types::extra_props::ExtData::FALSE,
            phantom: PhantomData,
        };

             pub fn from_ast(t: Terminal<Pk, Ctx>) -> Result<Miniscript<Pk, Ctx>, Error> {
            let res = Miniscript {
                ty: Type::type_check(&t)?,
                ext: ExtData::type_check(&t)?,
                node: t,
                phantom: PhantomData,
            };
                        if (res.ext.tree_height as u32) > MAX_RECURSION_DEPTH {
                return Err(Error::MaxRecursiveDepthExceeded);
            }
            Ctx::check_global_consensus_validity(&res)?;
            Ok(res)
        }

                pub fn from_components_unchecked(
            node: Terminal<Pk, Ctx>,
            ty: types::Type,
            ext: types::extra_props::ExtData,
        ) -> Miniscript<Pk, Ctx> {
            Miniscript { node, ty, ext, phantom: PhantomData }
        }
    }
}







mod tests {

    use core::str;
    use core::str::FromStr;

    use bitcoin::hashes::{hash160, sha256, Hash};
    use bitcoin::secp256k1::XOnlyPublicKey;
    use bitcoin::taproot::TapLeafHash;
    use sync::Arc;

    use super::{Miniscript, ScriptContext, Segwitv0, Tap};
    use crate::miniscript::{types, Terminal};
    use crate::policy::Liftable;
    use crate::prelude::*;
    use crate::test_utils::{StrKeyTranslator, StrXOnlyKeyTranslator};
    use crate::{hex_script, Error, ExtParams, RelLockTime, Satisfier, ToPublicKey, TranslatePk};

    type Segwitv0Script = Miniscript<bitcoin::PublicKey, Segwitv0>;
    type Tapscript = Miniscript<bitcoin::secp256k1::XOnlyPublicKey, Tap>;

    fn pubkeys(n: usize) -> Vec<bitcoin::PublicKey> {
        let mut ret = Vec::with_capacity(n);
        let secp = secp256k1::Secp256k1::new();
        let mut sk = [0; 32];
        for i in 1..n + 1 {
            sk[0] = i as u8;
            sk[1] = (i >> 8) as u8;
            sk[2] = (i >> 16) as u8;

            let pk = bitcoin::PublicKey {
                inner: secp256k1::PublicKey::from_secret_key(
                    &secp,
                    &secp256k1::SecretKey::from_slice(&sk[..]).expect("secret key"),
                ),
                compressed: true,
            };
            ret.push(pk);
        }
        ret
    }

    fn string_rtt<Ctx: ScriptContext>(
        script: Miniscript<bitcoin::PublicKey, Ctx>,
        expected_debug: &str,
        expected_display: &str,
    ) {
        assert_eq!(script.ty.corr.base, types::Base::B);
        let debug = format!("{:?}", script);
        let display = format!("{}", script);
        if let Some(expected) = expected_debug.into() {
            assert_eq!(debug, expected);
        }
        if let Some(expected) = expected_display.into() {
            assert_eq!(display, expected);
        }
        let roundtrip = Miniscript::from_str(&display).expect("parse string serialization");
        assert_eq!(roundtrip, script);
    }

    fn string_display_debug_test<Ctx: ScriptContext>(
        script: Miniscript<bitcoin::PublicKey, Ctx>,
        expected_debug: &str,
        expected_display: &str,
    ) {
        assert_eq!(script.ty.corr.base, types::Base::B);
        let debug = format!("{:?}", script);
        let display = format!("{}", script);
        if let Some(expected) = expected_debug.into() {
            assert_eq!(debug, expected);
        }
        if let Some(expected) = expected_display.into() {
            assert_eq!(display, expected);
        }
    }

    fn dummy_string_rtt<Ctx: ScriptContext>(
        script: Miniscript<String, Ctx>,
        expected_debug: &str,
        expected_display: &str,
    ) {
        assert_eq!(script.ty.corr.base, types::Base::B);
        let debug = format!("{:?}", script);
        let display = format!("{}", script);
        if let Some(expected) = expected_debug.into() {
            assert_eq!(debug, expected);
        }
        if let Some(expected) = expected_display.into() {
            assert_eq!(display, expected);
        }
        let roundtrip = Miniscript::from_str(&display).expect("parse string serialization");
        assert_eq!(roundtrip, script);
    }

    fn script_rtt<Str1: Into<Option<&'static str>>>(script: Segwitv0Script, expected_hex: Str1) {
        assert_eq!(script.ty.corr.base, types::Base::B);
        let bitcoin_script = script.encode();
        assert_eq!(bitcoin_script.len(), script.script_size());
        if let Some(expected) = expected_hex.into() {
            assert_eq!(format!("{:x}", bitcoin_script), expected);
        }
                let roundtrip = Segwitv0Script::parse_with_ext(&bitcoin_script, &ExtParams::allow_all())
            .expect("parse string serialization");
        assert_eq!(roundtrip, script);
    }

    fn roundtrip(tree: &Segwitv0Script, s: &str) {
        assert_eq!(tree.ty.corr.base, types::Base::B);
        let ser = tree.encode();
        assert_eq!(ser.len(), tree.script_size());
        assert_eq!(ser.to_string(), s);
        let deser = Segwitv0Script::parse_insane(&ser).expect("deserialize result of serialize");
        assert_eq!(*tree, deser);
    }

    fn ms_attributes_test(
        ms: &str,
        expected_hex: &str,
        valid: bool,
        non_mal: bool,
        need_sig: bool,
        ops: usize,
        _stack: usize,
    ) {
        let ms: Result<Segwitv0Script, _> = Miniscript::from_str_insane(ms);
        match (ms, valid) {
            (Ok(ms), true) => {
                assert_eq!(format!("{:x}", ms.encode()), expected_hex);
                assert_eq!(ms.ty.mall.non_malleable, non_mal);
                assert_eq!(ms.ty.mall.safe, need_sig);
                assert_eq!(ms.ext.ops.op_count().unwrap(), ops);
            }
            (Err(_), false) => {}
            _ => unreachable!(),
        }
    }

    #[test]
    fn all_attribute_tests() {
        ms_attributes_test(
            "lltvln:after(1231488000)",
            "6300676300676300670400046749b1926869516868",
            true,
            true,
            false,
            12,
            3,
        );
        ms_attributes_test("uuj:and_v(v:multi(2,03d01115d548e7561b15c38f004d734633687cf4419620095bc5b0f47070afe85a,025601570cb47f238d2b0286db4a990fa0f3ba28d1a319f5e7cf55c2a2444da7cc),after(1231488000))", "6363829263522103d01115d548e7561b15c38f004d734633687cf4419620095bc5b0f47070afe85a21025601570cb47f238d2b0286db4a990fa0f3ba28d1a319f5e7cf55c2a2444da7cc52af0400046749b168670068670068", true, true, true, 14, 5);
        ms_attributes_test("or_b(un:multi(2,03daed4f2be3a8bf278e70132fb0beb7522f570e144bf615c07e996d443dee8729,024ce119c96e2fa357200b559b2f7dd5a5f02d5290aff74b03f3e471b273211c97),al:older(16))", "63522103daed4f2be3a8bf278e70132fb0beb7522f570e144bf615c07e996d443dee872921024ce119c96e2fa357200b559b2f7dd5a5f02d5290aff74b03f3e471b273211c9752ae926700686b63006760b2686c9b", true, false, false, 14, 5);
        ms_attributes_test(
            "j:and_v(vdv:after(1567547623),older(2016))",
            "829263766304e7e06e5db169686902e007b268",
            true,
            true,
            false,
            11,
            1,
        );
        ms_attributes_test("t:and_v(vu:hash256(131772552c01444cd81360818376a040b7c3b2b7b0a53550ee3edde216cec61b),v:sha256(ec4916dd28fc4c10d78e287ca5d9cc51ee1ae73cbfde08c6b37324cbfaac8bc5))", "6382012088aa20131772552c01444cd81360818376a040b7c3b2b7b0a53550ee3edde216cec61b876700686982012088a820ec4916dd28fc4c10d78e287ca5d9cc51ee1ae73cbfde08c6b37324cbfaac8bc58851", true, true, false, 12, 3);
        ms_attributes_test("t:andor(multi(3,02d7924d4f7d43ea965a465ae3095ff41131e5946f3c85f79e44adbcf8e27e080e,03fff97bd5755eeea420453a14355235d382f6472f8568a18b2f057a1460297556,02e493dbf1c10d80f3581e4904930b1404cc6c13900ee0758474fa94abe8c4cd13),v:older(4194305),v:sha256(9267d3dbed802941483f1afa2a6bc68de5f653128aca9bf1461c5d0a3ad36ed2))", "532102d7924d4f7d43ea965a465ae3095ff41131e5946f3c85f79e44adbcf8e27e080e2103fff97bd5755eeea420453a14355235d382f6472f8568a18b2f057a14602975562102e493dbf1c10d80f3581e4904930b1404cc6c13900ee0758474fa94abe8c4cd1353ae6482012088a8209267d3dbed802941483f1afa2a6bc68de5f653128aca9bf1461c5d0a3ad36ed2886703010040b2696851", true, true, false, 13, 5);
        ms_attributes_test("or_d(multi(1,02f9308a019258c31049344f85f89d5229b531c845836f99b08601f113bce036f9),or_b(multi(3,022f01e5e15cca351daff3843fb70f3c2f0a1bdd05e5af888a67784ef3e10a2a01,032fa2104d6b38d11b0230010559879124e42ab8dfeff5ff29dc9cdadd4ecacc3f,03d01115d548e7561b15c38f004d734633687cf4419620095bc5b0f47070afe85a),su:after(500000)))", "512102f9308a019258c31049344f85f89d5229b531c845836f99b08601f113bce036f951ae73645321022f01e5e15cca351daff3843fb70f3c2f0a1bdd05e5af888a67784ef3e10a2a0121032fa2104d6b38d11b0230010559879124e42ab8dfeff5ff29dc9cdadd4ecacc3f2103d01115d548e7561b15c38f004d734633687cf4419620095bc5b0f47070afe85a53ae7c630320a107b16700689b68", true, true, false, 15, 7);
        ms_attributes_test("or_d(sha256(38df1c1f64a24a77b23393bca50dff872e31edc4f3b5aa3b90ad0b82f4f089b6),and_n(un:after(499999999),older(4194305)))", "82012088a82038df1c1f64a24a77b23393bca50dff872e31edc4f3b5aa3b90ad0b82f4f089b68773646304ff64cd1db19267006864006703010040b26868", true, false, false, 16, 1);
        ms_attributes_test("and_v(or_i(v:multi(2,02c6047f9441ed7d6d3045406e95c07cd85c778e4b8cef3ca7abac09b95c709ee5,03774ae7f858a9411e5ef4246b70c65aac5649980be5c17891bbec17895da008cb),v:multi(2,03e60fce93b59e9ec53011aabc21c23e97b2a31369b87a5ae9c44ee89e2a6dec0a,025cbdf0646e5db4eaa398f365f2ea7a0e3d419b7e0330e39ce92bddedcac4f9bc)),sha256(d1ec675902ef1633427ca360b290b0b3045a0d9058ddb5e648b4c3c3224c5c68))", "63522102c6047f9441ed7d6d3045406e95c07cd85c778e4b8cef3ca7abac09b95c709ee52103774ae7f858a9411e5ef4246b70c65aac5649980be5c17891bbec17895da008cb52af67522103e60fce93b59e9ec53011aabc21c23e97b2a31369b87a5ae9c44ee89e2a6dec0a21025cbdf0646e5db4eaa398f365f2ea7a0e3d419b7e0330e39ce92bddedcac4f9bc52af6882012088a820d1ec675902ef1633427ca360b290b0b3045a0d9058ddb5e648b4c3c3224c5c6887", true, true, true, 11, 5);
        ms_attributes_test("j:and_b(multi(2,0279be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798,024ce119c96e2fa357200b559b2f7dd5a5f02d5290aff74b03f3e471b273211c97),s:or_i(older(1),older(4252898)))", "82926352210279be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f8179821024ce119c96e2fa357200b559b2f7dd5a5f02d5290aff74b03f3e471b273211c9752ae7c6351b26703e2e440b2689a68", true, false, true, 14, 4);
        ms_attributes_test("and_b(older(16),s:or_d(sha256(e38990d0c7fc009880a9c07c23842e886c6bbdc964ce6bdd5817ad357335ee6f),n:after(1567547623)))", "60b27c82012088a820e38990d0c7fc009880a9c07c23842e886c6bbdc964ce6bdd5817ad357335ee6f87736404e7e06e5db192689a", true, false, false, 12, 1);
        ms_attributes_test("j:and_v(v:hash160(20195b5a3d650c17f0f29f91c33f8f6335193d07),or_d(sha256(96de8fc8c256fa1e1556d41af431cace7dca68707c78dd88c3acab8b17164c47),older(16)))", "82926382012088a91420195b5a3d650c17f0f29f91c33f8f6335193d078882012088a82096de8fc8c256fa1e1556d41af431cace7dca68707c78dd88c3acab8b17164c4787736460b26868", true, false, false, 16, 2);
        ms_attributes_test("and_b(hash256(32ba476771d01e37807990ead8719f08af494723de1d228f2c2c07cc0aa40bac),a:and_b(hash256(131772552c01444cd81360818376a040b7c3b2b7b0a53550ee3edde216cec61b),a:older(1)))", "82012088aa2032ba476771d01e37807990ead8719f08af494723de1d228f2c2c07cc0aa40bac876b82012088aa20131772552c01444cd81360818376a040b7c3b2b7b0a53550ee3edde216cec61b876b51b26c9a6c9a", true, true, false, 15, 2);
        ms_attributes_test("thresh(2,multi(2,03a0434d9e47f3c86235477c7b1ae6ae5d3442d49b1943c2b752a68e2a47e247c7,036d2b085e9e382ed10b69fc311a03f8641ccfff21574de0927513a49d9a688a00),a:multi(1,036d2b085e9e382ed10b69fc311a03f8641ccfff21574de0927513a49d9a688a00),ac:pk_k(022f01e5e15cca351daff3843fb70f3c2f0a1bdd05e5af888a67784ef3e10a2a01))", "522103a0434d9e47f3c86235477c7b1ae6ae5d3442d49b1943c2b752a68e2a47e247c721036d2b085e9e382ed10b69fc311a03f8641ccfff21574de0927513a49d9a688a0052ae6b5121036d2b085e9e382ed10b69fc311a03f8641ccfff21574de0927513a49d9a688a0051ae6c936b21022f01e5e15cca351daff3843fb70f3c2f0a1bdd05e5af888a67784ef3e10a2a01ac6c935287", true, true, true, 13, 6);
        ms_attributes_test("and_n(sha256(d1ec675902ef1633427ca360b290b0b3045a0d9058ddb5e648b4c3c3224c5c68),t:or_i(v:older(4252898),v:older(144)))", "82012088a820d1ec675902ef1633427ca360b290b0b3045a0d9058ddb5e648b4c3c3224c5c68876400676303e2e440b26967029000b269685168", true, false, false, 14, 2);
        ms_attributes_test("or_d(nd:and_v(v:older(4252898),v:older(4252898)),sha256(38df1c1f64a24a77b23393bca50dff872e31edc4f3b5aa3b90ad0b82f4f089b6))", "766303e2e440b26903e2e440b2696892736482012088a82038df1c1f64a24a77b23393bca50dff872e31edc4f3b5aa3b90ad0b82f4f089b68768", true, false, false, 15, 2);
        ms_attributes_test("c:and_v(or_c(sha256(9267d3dbed802941483f1afa2a6bc68de5f653128aca9bf1461c5d0a3ad36ed2),v:multi(1,02c44d12c7065d812e8acf28d7cbb19f9011ecd9e9fdf281b0e6a3b5e87d22e7db)),pk_k(03acd484e2f0c7f65309ad178a9f559abde09796974c57e714c35f110dfc27ccbe))", "82012088a8209267d3dbed802941483f1afa2a6bc68de5f653128aca9bf1461c5d0a3ad36ed28764512102c44d12c7065d812e8acf28d7cbb19f9011ecd9e9fdf281b0e6a3b5e87d22e7db51af682103acd484e2f0c7f65309ad178a9f559abde09796974c57e714c35f110dfc27ccbeac", true, false, true, 9, 2);
        ms_attributes_test("c:and_v(or_c(multi(2,036d2b085e9e382ed10b69fc311a03f8641ccfff21574de0927513a49d9a688a00,02352bbf4a4cdd12564f93fa332ce333301d9ad40271f8107181340aef25be59d5),v:ripemd160(1b0f3c404d12075c68c938f9f60ebea4f74941a0)),pk_k(03fff97bd5755eeea420453a14355235d382f6472f8568a18b2f057a1460297556))", "5221036d2b085e9e382ed10b69fc311a03f8641ccfff21574de0927513a49d9a688a002102352bbf4a4cdd12564f93fa332ce333301d9ad40271f8107181340aef25be59d552ae6482012088a6141b0f3c404d12075c68c938f9f60ebea4f74941a088682103fff97bd5755eeea420453a14355235d382f6472f8568a18b2f057a1460297556ac", true, true, true, 10, 5);
        ms_attributes_test("and_v(andor(hash256(8a35d9ca92a48eaade6f53a64985e9e2afeb74dcf8acb4c3721e0dc7e4294b25),v:hash256(939894f70e6c3a25da75da0cc2071b4076d9b006563cf635986ada2e93c0d735),v:older(50000)),after(499999999))", "82012088aa208a35d9ca92a48eaade6f53a64985e9e2afeb74dcf8acb4c3721e0dc7e4294b2587640350c300b2696782012088aa20939894f70e6c3a25da75da0cc2071b4076d9b006563cf635986ada2e93c0d735886804ff64cd1db1", true, false, false, 14, 2);
        ms_attributes_test("andor(hash256(5f8d30e655a7ba0d7596bb3ddfb1d2d20390d23b1845000e1e118b3be1b3f040),j:and_v(v:hash160(3a2bff0da9d96868e66abc4427bea4691cf61ccd),older(4194305)),ripemd160(44d90e2d3714c8663b632fcf0f9d5f22192cc4c8))", "82012088aa205f8d30e655a7ba0d7596bb3ddfb1d2d20390d23b1845000e1e118b3be1b3f040876482012088a61444d90e2d3714c8663b632fcf0f9d5f22192cc4c8876782926382012088a9143a2bff0da9d96868e66abc4427bea4691cf61ccd8803010040b26868", true, false, false, 20, 2);
        ms_attributes_test("or_i(c:and_v(v:after(500000),pk_k(02c6047f9441ed7d6d3045406e95c07cd85c778e4b8cef3ca7abac09b95c709ee5)),sha256(d9147961436944f43cd99d28b2bbddbf452ef872b30c8279e255e7daafc7f946))", "630320a107b1692102c6047f9441ed7d6d3045406e95c07cd85c778e4b8cef3ca7abac09b95c709ee5ac6782012088a820d9147961436944f43cd99d28b2bbddbf452ef872b30c8279e255e7daafc7f9468768", true, true, false, 10, 2);
        ms_attributes_test("thresh(2,c:pk_h(03daed4f2be3a8bf278e70132fb0beb7522f570e144bf615c07e996d443dee8729),s:sha256(e38990d0c7fc009880a9c07c23842e886c6bbdc964ce6bdd5817ad357335ee6f),a:hash160(dd69735817e0e3f6f826a9238dc2e291184f0131))", "76a91420d637c1a6404d2227f3561fdbaff5a680dba64888ac7c82012088a820e38990d0c7fc009880a9c07c23842e886c6bbdc964ce6bdd5817ad357335ee6f87936b82012088a914dd69735817e0e3f6f826a9238dc2e291184f0131876c935287", true, false, false, 18, 4);
        ms_attributes_test("and_n(sha256(9267d3dbed802941483f1afa2a6bc68de5f653128aca9bf1461c5d0a3ad36ed2),uc:and_v(v:older(144),pk_k(03fe72c435413d33d48ac09c9161ba8b09683215439d62b7940502bda8b202e6ce)))", "82012088a8209267d3dbed802941483f1afa2a6bc68de5f653128aca9bf1461c5d0a3ad36ed28764006763029000b2692103fe72c435413d33d48ac09c9161ba8b09683215439d62b7940502bda8b202e6ceac67006868", true, false, true, 13, 3);
        ms_attributes_test("and_n(c:pk_k(03daed4f2be3a8bf278e70132fb0beb7522f570e144bf615c07e996d443dee8729),and_b(l:older(4252898),a:older(16)))", "2103daed4f2be3a8bf278e70132fb0beb7522f570e144bf615c07e996d443dee8729ac64006763006703e2e440b2686b60b26c9a68", true, true, true, 12, 2);
        ms_attributes_test("c:or_i(and_v(v:older(16),pk_h(03daed4f2be3a8bf278e70132fb0beb7522f570e144bf615c07e996d443dee8729)),pk_h(02352bbf4a4cdd12564f93fa332ce333301d9ad40271f8107181340aef25be59d5))", "6360b26976a91420d637c1a6404d2227f3561fdbaff5a680dba648886776a9148f9dff39a81ee4abcbad2ad8bafff090415a2be88868ac", true, true, true, 12, 3);
        ms_attributes_test("or_d(c:pk_h(02352bbf4a4cdd12564f93fa332ce333301d9ad40271f8107181340aef25be59d5),andor(c:pk_k(024ce119c96e2fa357200b559b2f7dd5a5f02d5290aff74b03f3e471b273211c97),older(2016),after(1567547623)))", "76a9148f9dff39a81ee4abcbad2ad8bafff090415a2be888ac736421024ce119c96e2fa357200b559b2f7dd5a5f02d5290aff74b03f3e471b273211c97ac6404e7e06e5db16702e007b26868", true, true, false, 13, 3);
        ms_attributes_test("c:andor(ripemd160(6ad07d21fd5dfc646f0b30577045ce201616b9ba),pk_h(03daed4f2be3a8bf278e70132fb0beb7522f570e144bf615c07e996d443dee8729),and_v(v:hash256(8a35d9ca92a48eaade6f53a64985e9e2afeb74dcf8acb4c3721e0dc7e4294b25),pk_h(02352bbf4a4cdd12564f93fa332ce333301d9ad40271f8107181340aef25be59d5)))", "82012088a6146ad07d21fd5dfc646f0b30577045ce201616b9ba876482012088aa208a35d9ca92a48eaade6f53a64985e9e2afeb74dcf8acb4c3721e0dc7e4294b258876a9148f9dff39a81ee4abcbad2ad8bafff090415a2be8886776a91420d637c1a6404d2227f3561fdbaff5a680dba6488868ac", true, false, true, 18, 3);
        ms_attributes_test("c:andor(u:ripemd160(6ad07d21fd5dfc646f0b30577045ce201616b9ba),pk_h(03daed4f2be3a8bf278e70132fb0beb7522f570e144bf615c07e996d443dee8729),or_i(pk_h(024ce119c96e2fa357200b559b2f7dd5a5f02d5290aff74b03f3e471b273211c97),pk_h(02352bbf4a4cdd12564f93fa332ce333301d9ad40271f8107181340aef25be59d5)))", "6382012088a6146ad07d21fd5dfc646f0b30577045ce201616b9ba87670068646376a914385defb0ed10fe95817943ed37b4984f8f4255d6886776a9148f9dff39a81ee4abcbad2ad8bafff090415a2be888686776a91420d637c1a6404d2227f3561fdbaff5a680dba6488868ac", true, false, true, 23, 4);
        ms_attributes_test("c:or_i(andor(c:pk_h(02352bbf4a4cdd12564f93fa332ce333301d9ad40271f8107181340aef25be59d5),pk_h(024ce119c96e2fa357200b559b2f7dd5a5f02d5290aff74b03f3e471b273211c97),pk_h(03daed4f2be3a8bf278e70132fb0beb7522f570e144bf615c07e996d443dee8729)),pk_k(03fff97bd5755eeea420453a14355235d382f6472f8568a18b2f057a1460297556))", "6376a9148f9dff39a81ee4abcbad2ad8bafff090415a2be888ac6476a91420d637c1a6404d2227f3561fdbaff5a680dba648886776a914385defb0ed10fe95817943ed37b4984f8f4255d68868672103fff97bd5755eeea420453a14355235d382f6472f8568a18b2f057a146029755668ac", true, true, true, 17, 5);
    }

    #[test]
    fn basic() {
        let pk = bitcoin::PublicKey::from_str(
            "\
             020202020202020202020202020202020202020202020202020202020202020202\
             ",
        )
        .unwrap();
        let hash = hash160::Hash::from_byte_array([17; 20]);

        let pk_node = Terminal::Check(Arc::new(
            Miniscript::from_ast(Terminal::PkK(String::from(""))).unwrap(),
        ));
        let pkk_ms: Miniscript<String, Segwitv0> = Miniscript::from_ast(pk_node).unwrap();
        dummy_string_rtt(pkk_ms, "[B/onduesm]pk(\"\")", "pk()");

        let pkh_node = Terminal::Check(Arc::new(
            Miniscript::from_ast(Terminal::PkH(String::from(""))).unwrap(),
        ));
        let pkh_ms: Miniscript<String, Segwitv0> = Miniscript::from_ast(pkh_node).unwrap();

        let expected_debug = "[B/nduesm]pkh(\"\")";
        let expected_display = "pkh()";

        assert_eq!(pkh_ms.ty.corr.base, types::Base::B);
        let debug = format!("{:?}", pkh_ms);
        let display = format!("{}", pkh_ms);
        if let Some(expected) = expected_debug.into() {
            assert_eq!(debug, expected);
        }
        if let Some(expected) = expected_display.into() {
            assert_eq!(display, expected);
        }

        let pkk_node = Terminal::Check(Arc::new(Miniscript::from_ast(Terminal::PkK(pk)).unwrap()));
        let pkk_ms: Segwitv0Script = Miniscript::from_ast(pkk_node).unwrap();

        script_rtt(
            pkk_ms,
            "21020202020202020202020202020202020202020202020202020202020\
             202020202ac",
        );

        let pkh_ms: Segwitv0Script = Miniscript::from_ast(Terminal::Check(Arc::new(
            Miniscript::from_ast(Terminal::RawPkH(hash)).unwrap(),
        )))
        .unwrap();

        script_rtt(pkh_ms, "76a914111111111111111111111111111111111111111188ac");
    }

    #[test]
    fn true_false() {
        roundtrip(&ms_str!("1"), "OP_PUSHNUM_1");
        roundtrip(&ms_str!("tv:1"), "OP_PUSHNUM_1 OP_VERIFY OP_PUSHNUM_1");
        roundtrip(&ms_str!("0"), "OP_0");
        roundtrip(&ms_str!("andor(0,1,0)"), "OP_0 OP_NOTIF OP_0 OP_ELSE OP_PUSHNUM_1 OP_ENDIF");

        assert!(Segwitv0Script::from_str("1()").is_err());
        assert!(Segwitv0Script::from_str("tv:1()").is_err());
    }

    #[test]
    fn verify_parse() {
        let ms = "and_v(v:hash160(20195b5a3d650c17f0f29f91c33f8f6335193d07),or_d(sha256(96de8fc8c256fa1e1556d41af431cace7dca68707c78dd88c3acab8b17164c47),older(16)))";
        let ms: Segwitv0Script = Miniscript::from_str_insane(ms).unwrap();
        assert_eq!(ms, Segwitv0Script::parse_insane(&ms.encode()).unwrap());

        let ms = "and_v(v:sha256(96de8fc8c256fa1e1556d41af431cace7dca68707c78dd88c3acab8b17164c47),or_d(sha256(96de8fc8c256fa1e1556d41af431cace7dca68707c78dd88c3acab8b17164c47),older(16)))";
        let ms: Segwitv0Script = Miniscript::from_str_insane(ms).unwrap();
        assert_eq!(ms, Segwitv0Script::parse_insane(&ms.encode()).unwrap());

        let ms = "and_v(v:ripemd160(20195b5a3d650c17f0f29f91c33f8f6335193d07),or_d(sha256(96de8fc8c256fa1e1556d41af431cace7dca68707c78dd88c3acab8b17164c47),older(16)))";
        let ms: Segwitv0Script = Miniscript::from_str_insane(ms).unwrap();
        assert_eq!(ms, Segwitv0Script::parse_insane(&ms.encode()).unwrap());

        let ms = "and_v(v:hash256(96de8fc8c256fa1e1556d41af431cace7dca68707c78dd88c3acab8b17164c47),or_d(sha256(96de8fc8c256fa1e1556d41af431cace7dca68707c78dd88c3acab8b17164c47),older(16)))";
        let ms: Segwitv0Script = Miniscript::from_str_insane(ms).unwrap();
        assert_eq!(ms, Segwitv0Script::parse_insane(&ms.encode()).unwrap());
    }

    #[test]
    fn pk_alias() {
        let pubkey = pubkeys(1)[0];

        let script: Segwitv0Script = ms_str!("c:pk_k({})", pubkey.to_string());

        string_rtt(
            script,
            "[B/onduesm]pk(PublicKey { compressed: true, inner: PublicKey(aa4c32e50fb34a95a372940ae3654b692ea35294748c3dd2c08b29f87ba9288c8294efcb73dc719e45b91c45f084e77aebc07c1ff3ed8f37935130a36304a340) })",
            "pk(028c28a97bf8298bc0d23d8c749452a32e694b65e30a9472a3954ab30fe5324caa)"
        );

        let script: Segwitv0Script = ms_str!("pk({})", pubkey.to_string());

        string_rtt(
            script,
            "[B/onduesm]pk(PublicKey { compressed: true, inner: PublicKey(aa4c32e50fb34a95a372940ae3654b692ea35294748c3dd2c08b29f87ba9288c8294efcb73dc719e45b91c45f084e77aebc07c1ff3ed8f37935130a36304a340) })",
            "pk(028c28a97bf8298bc0d23d8c749452a32e694b65e30a9472a3954ab30fe5324caa)"
        );

        let script: Segwitv0Script = ms_str!("tv:pk({})", pubkey.to_string());

        string_rtt(
            script,
            "[B/onufsm]t[V/onfsm]v:[B/onduesm]pk(PublicKey { compressed: true, inner: PublicKey(aa4c32e50fb34a95a372940ae3654b692ea35294748c3dd2c08b29f87ba9288c8294efcb73dc719e45b91c45f084e77aebc07c1ff3ed8f37935130a36304a340) })",
            "tv:pk(028c28a97bf8298bc0d23d8c749452a32e694b65e30a9472a3954ab30fe5324caa)"
        );

        let script: Segwitv0Script = ms_str!("c:pk_h({})", pubkey.to_string());

        string_display_debug_test(
            script,
            "[B/nduesm]pkh(PublicKey { compressed: true, inner: PublicKey(aa4c32e50fb34a95a372940ae3654b692ea35294748c3dd2c08b29f87ba9288c8294efcb73dc719e45b91c45f084e77aebc07c1ff3ed8f37935130a36304a340) })",
            "pkh(028c28a97bf8298bc0d23d8c749452a32e694b65e30a9472a3954ab30fe5324caa)",
        );

        let script: Segwitv0Script = ms_str!("pkh({})", pubkey.to_string());

        string_display_debug_test(
            script,
            "[B/nduesm]pkh(PublicKey { compressed: true, inner: PublicKey(aa4c32e50fb34a95a372940ae3654b692ea35294748c3dd2c08b29f87ba9288c8294efcb73dc719e45b91c45f084e77aebc07c1ff3ed8f37935130a36304a340) })",
            "pkh(028c28a97bf8298bc0d23d8c749452a32e694b65e30a9472a3954ab30fe5324caa)",
        );

        let script: Segwitv0Script = ms_str!("tv:pkh({})", pubkey.to_string());

        string_display_debug_test(
            script,
            "[B/nufsm]t[V/nfsm]v:[B/nduesm]pkh(PublicKey { compressed: true, inner: PublicKey(aa4c32e50fb34a95a372940ae3654b692ea35294748c3dd2c08b29f87ba9288c8294efcb73dc719e45b91c45f084e77aebc07c1ff3ed8f37935130a36304a340) })",
            "tv:pkh(028c28a97bf8298bc0d23d8c749452a32e694b65e30a9472a3954ab30fe5324caa)",
        );
    }

    #[test]
    fn serialize() {
        let keys = pubkeys(6);

        let tree: &Segwitv0Script = &ms_str!("c:pk_h({})", keys[5]);
        assert_eq!(tree.ty.corr.base, types::Base::B);
        let ser = tree.encode();
        let s = "\
             OP_DUP OP_HASH160 OP_PUSHBYTES_20 \
             7e5a2a6a7610ca4ea78bd65a087bd75b1870e319 \
             OP_EQUALVERIFY OP_CHECKSIG\
             ";
        assert_eq!(ser.len(), tree.script_size());
        assert_eq!(ser.to_string(), s);

        roundtrip(
            &ms_str!("pk({})", keys[0]),
            "OP_PUSHBYTES_33 028c28a97bf8298bc0d23d8c749452a32e694b65e30a9472a3954ab30fe5324caa OP_CHECKSIG"
        );
        roundtrip(
            &ms_str!("multi(3,{},{},{},{},{})", keys[0], keys[1], keys[2], keys[3], keys[4]),
            "OP_PUSHNUM_3 OP_PUSHBYTES_33 028c28a97bf8298bc0d23d8c749452a32e694b65e30a9472a3954ab30fe5324caa OP_PUSHBYTES_33 03ab1ac1872a38a2f196bed5a6047f0da2c8130fe8de49fc4d5dfb201f7611d8e2 OP_PUSHBYTES_33 039729247032c0dfcf45b4841fcd72f6e9a2422631fc3466cf863e87154754dd40 OP_PUSHBYTES_33 032564fe9b5beef82d3703a607253f31ef8ea1b365772df434226aee642651b3fa OP_PUSHBYTES_33 0289637f97580a796e050791ad5a2f27af1803645d95df021a3c2d82eb8c2ca7ff OP_PUSHNUM_5 OP_CHECKMULTISIG"
        );

                roundtrip(
            &ms_str!("or_d(multi(2,{},{}),and_v(v:multi(2,{},{}),older(10000)))",
                      keys[0].to_string(),
                      keys[1].to_string(),
                      keys[3].to_string(),
                      keys[4].to_string()),
            "OP_PUSHNUM_2 OP_PUSHBYTES_33 028c28a97bf8298bc0d23d8c749452a32e694b65e30a9472a3954ab30fe5324caa \
                                  OP_PUSHBYTES_33 03ab1ac1872a38a2f196bed5a6047f0da2c8130fe8de49fc4d5dfb201f7611d8e2 \
                                  OP_PUSHNUM_2 OP_CHECKMULTISIG \
                     OP_IFDUP OP_NOTIF \
                         OP_PUSHNUM_2 OP_PUSHBYTES_33 032564fe9b5beef82d3703a607253f31ef8ea1b365772df434226aee642651b3fa \
                                      OP_PUSHBYTES_33 0289637f97580a796e050791ad5a2f27af1803645d95df021a3c2d82eb8c2ca7ff \
                                      OP_PUSHNUM_2 OP_CHECKMULTISIGVERIFY \
                         OP_PUSHBYTES_2 1027 OP_CSV \
                     OP_ENDIF"
        );

        let miniscript: Segwitv0Script = ms_str!(
            "or_d(multi(3,{},{},{}),and_v(v:multi(2,{},{}),older(10000)))",
            keys[0].to_string(),
            keys[1].to_string(),
            keys[2].to_string(),
            keys[3].to_string(),
            keys[4].to_string(),
        );

        let mut abs = miniscript.lift().unwrap();
        assert_eq!(abs.n_keys(), 5);
        assert_eq!(abs.minimum_n_keys(), Some(2));
        abs = abs.at_age(RelLockTime::from_height(10000).into());
        assert_eq!(abs.n_keys(), 5);
        assert_eq!(abs.minimum_n_keys(), Some(2));
        abs = abs.at_age(RelLockTime::from_height(9999).into());
        assert_eq!(abs.n_keys(), 3);
        assert_eq!(abs.minimum_n_keys(), Some(3));
        abs = abs.at_age(RelLockTime::ZERO.into());
        assert_eq!(abs.n_keys(), 3);
        assert_eq!(abs.minimum_n_keys(), Some(3));

        roundtrip(&ms_str!("older(921)"), "OP_PUSHBYTES_2 9903 OP_CSV");

        roundtrip(
            &ms_str!("sha256({})",sha256::Hash::hash(&[])),
            "OP_SIZE OP_PUSHBYTES_1 20 OP_EQUALVERIFY OP_SHA256 OP_PUSHBYTES_32 e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 OP_EQUAL"
        );

        roundtrip(
            &ms_str!("multi(3,{},{},{},{},{})", keys[0], keys[1], keys[2], keys[3], keys[4]),
            "OP_PUSHNUM_3 \
             OP_PUSHBYTES_33 028c28a97bf8298bc0d23d8c749452a32e694b65e30a9472a3954ab30fe5324caa \
             OP_PUSHBYTES_33 03ab1ac1872a38a2f196bed5a6047f0da2c8130fe8de49fc4d5dfb201f7611d8e2 \
             OP_PUSHBYTES_33 039729247032c0dfcf45b4841fcd72f6e9a2422631fc3466cf863e87154754dd40 \
             OP_PUSHBYTES_33 032564fe9b5beef82d3703a607253f31ef8ea1b365772df434226aee642651b3fa \
             OP_PUSHBYTES_33 0289637f97580a796e050791ad5a2f27af1803645d95df021a3c2d82eb8c2ca7ff \
             OP_PUSHNUM_5 OP_CHECKMULTISIG",
        );

        roundtrip(
            &ms_str!(
                "t:and_v(\
                     vu:hash256(131772552c01444cd81360818376a040b7c3b2b7b0a53550ee3edde216cec61b),\
                     v:sha256(ec4916dd28fc4c10d78e287ca5d9cc51ee1ae73cbfde08c6b37324cbfaac8bc5)\
                 )"),
            "OP_IF OP_SIZE OP_PUSHBYTES_1 20 OP_EQUALVERIFY OP_HASH256 OP_PUSHBYTES_32 131772552c01444cd81360818376a040b7c3b2b7b0a53550ee3edde216cec61b OP_EQUAL OP_ELSE OP_0 OP_ENDIF OP_VERIFY OP_SIZE OP_PUSHBYTES_1 20 OP_EQUALVERIFY OP_SHA256 OP_PUSHBYTES_32 ec4916dd28fc4c10d78e287ca5d9cc51ee1ae73cbfde08c6b37324cbfaac8bc5 OP_EQUALVERIFY OP_PUSHNUM_1"
        );
        roundtrip(
            &ms_str!("and_n(pk(03daed4f2be3a8bf278e70132fb0beb7522f570e144bf615c07e996d443dee8729),and_b(l:older(4252898),a:older(16)))"),
            "OP_PUSHBYTES_33 03daed4f2be3a8bf278e70132fb0beb7522f570e144bf615c07e996d443dee8729 OP_CHECKSIG OP_NOTIF OP_0 OP_ELSE OP_IF OP_0 OP_ELSE OP_PUSHBYTES_3 e2e440 OP_CSV OP_ENDIF OP_TOALTSTACK OP_PUSHNUM_16 OP_CSV OP_FROMALTSTACK OP_BOOLAND OP_ENDIF"
        );
        roundtrip(
            &ms_str!(
                "t:andor(multi(\
                    3,\
                    02d7924d4f7d43ea965a465ae3095ff41131e5946f3c85f79e44adbcf8e27e080e,\
                    03fff97bd5755eeea420453a14355235d382f6472f8568a18b2f057a1460297556,\
                    02e493dbf1c10d80f3581e4904930b1404cc6c13900ee0758474fa94abe8c4cd13\
                 ),\
                 v:older(4194305),\
                 v:sha256(9267d3dbed802941483f1afa2a6bc68de5f653128aca9bf1461c5d0a3ad36ed2)\
                 )"),
            "OP_PUSHNUM_3 OP_PUSHBYTES_33 02d7924d4f7d43ea965a465ae3095ff41131e5946f3c85f79e44adbcf8e27e080e \
             OP_PUSHBYTES_33 03fff97bd5755eeea420453a14355235d382f6472f8568a18b2f057a1460297556 \
             OP_PUSHBYTES_33 02e493dbf1c10d80f3581e4904930b1404cc6c13900ee0758474fa94abe8c4cd13 \
             OP_PUSHNUM_3 OP_CHECKMULTISIG OP_NOTIF OP_SIZE OP_PUSHBYTES_1 20 OP_EQUALVERIFY OP_SHA256 \
             OP_PUSHBYTES_32 9267d3dbed802941483f1afa2a6bc68de5f653128aca9bf1461c5d0a3ad36ed2 OP_EQUALVERIFY \
             OP_ELSE OP_PUSHBYTES_3 010040 OP_CSV OP_VERIFY OP_ENDIF OP_PUSHNUM_1"
        );
        roundtrip(
            &ms_str!(
                "t:and_v(\
                    vu:hash256(131772552c01444cd81360818376a040b7c3b2b7b0a53550ee3edde216cec61b),\
                    v:sha256(ec4916dd28fc4c10d78e287ca5d9cc51ee1ae73cbfde08c6b37324cbfaac8bc5)\
                 )"),
            "\
             OP_IF OP_SIZE OP_PUSHBYTES_1 20 OP_EQUALVERIFY OP_HASH256 OP_PUSHBYTES_32 131772552c01444cd81360818376a040b7c3b2b7b0a53550ee3edde216cec61b OP_EQUAL \
             OP_ELSE OP_0 OP_ENDIF OP_VERIFY OP_SIZE OP_PUSHBYTES_1 20 OP_EQUALVERIFY OP_SHA256 OP_PUSHBYTES_32 ec4916dd28fc4c10d78e287ca5d9cc51ee1ae73cbfde08c6b37324cbfaac8bc5 OP_EQUALVERIFY \
             OP_PUSHNUM_1\
             "
        );

               roundtrip(
            &ms_str!("tv:thresh(1,pk(02d7924d4f7d43ea965a465ae3095ff41131e5946f3c85f79e44adbcf8e27e080e))", ),
            "OP_PUSHBYTES_33 02d7924d4f7d43ea965a465ae3095ff41131e5946f3c85f79e44adbcf8e27e080e OP_CHECKSIG OP_PUSHNUM_1 OP_EQUALVERIFY OP_PUSHNUM_1",
        );
    }

    #[test]
    fn deserialize() {
               assert!(Segwitv0Script::parse_insane(&hex_script("")).is_err()); // empty
        assert!(Segwitv0Script::parse_insane(&hex_script("00")).is_ok()); // FALSE
        assert!(Segwitv0Script::parse_insane(&hex_script("51")).is_ok()); // TRUE
        assert!(Segwitv0Script::parse_insane(&hex_script("69")).is_err()); // VERIFY
        assert!(Segwitv0Script::parse_insane(&hex_script("0000")).is_err()); //and_v(FALSE,FALSE)
        assert!(Segwitv0Script::parse_insane(&hex_script("1001")).is_err()); // incomplete push
        assert!(Segwitv0Script::parse_insane(&hex_script("03990300b2")).is_err()); // non-minimal #
        assert!(Segwitv0Script::parse_insane(&hex_script("8559b2")).is_err()); // leading bytes
        assert!(Segwitv0Script::parse_insane(&hex_script("4c0169b2")).is_err()); // non-minimal push
        assert!(Segwitv0Script::parse_insane(&hex_script("0000af0000ae85")).is_err()); // OR not BOOLOR

                assert!(Segwitv0Script::parse_insane(&hex_script("0000000000af")).is_err());
        assert!(Segwitv0Script::parse_insane(&hex_script("04009a2970af00")).is_err()); // giant CMS key num
        assert!(Segwitv0Script::parse_insane(&hex_script(
            "2102ffffffffffffffefefefefefefefefefefef394c0fe5b711179e124008584753ac6900"
        ))
        .is_err());
    }

    #[test]
    fn non_ascii() {
        assert!(Segwitv0Script::from_str_insane("🌏")
            .unwrap_err()
            .to_string()
            .contains("unprintable character"));
    }

    #[test]
    fn test_tapscript_rtt() {
                Segwitv0Script::from_str_insane(
            "pk(2788ee41e76f4f3af603da5bc8fa22997bc0344bb0f95666ba6aaff0242baa99)",
        )
        .unwrap_err();
        Tapscript::from_str_insane(
            "pk(2788ee41e76f4f3af603da5bc8fa22997bc0344bb0f95666ba6aaff0242baa99)",
        )
        .unwrap();

                Miniscript::<bitcoin::PublicKey, Tap>::from_str_insane(
            "pk(022788ee41e76f4f3af603da5bc8fa22997bc0344bb0f95666ba6aaff0242baa99)",
        )
        .unwrap();

               Miniscript::<bitcoin::PublicKey, Tap>::from_str_insane(
            "pk(04eed24a081bf1b1e49e3300df4bebe04208ac7e516b6f3ea8eb6e094584267c13483f89dcf194132e12238cc5a34b6b286fc7990d68ed1db86b69ebd826c63b29)"
        )
        .unwrap_err();

               Segwitv0Script::parse_insane(&hex_script(
            "202788ee41e76f4f3af603da5bc8fa22997bc0344bb0f95666ba6aaff0242baa99ac",
        ))
        .unwrap_err();
                Tapscript::parse_insane(&hex_script(
            "202788ee41e76f4f3af603da5bc8fa22997bc0344bb0f95666ba6aaff0242baa99ac",
        ))
        .unwrap();
                Tapscript::parse_insane(&hex_script(
            "21022788ee41e76f4f3af603da5bc8fa22997bc0344bb0f95666ba6aaff0242baa99ac",
        ))
        .unwrap_err();
              Segwitv0Script::parse_insane(&hex_script(
            "21022788ee41e76f4f3af603da5bc8fa22997bc0344bb0f95666ba6aaff0242baa99ac",
        ))
        .unwrap();

                Tapscript::from_str_insane(
            "multi(1,2788ee41e76f4f3af603da5bc8fa22997bc0344bb0f95666ba6aaff0242baa99)",
        )
        .unwrap_err();
                Segwitv0Script::from_str_insane(
            "multi(1,022788ee41e76f4f3af603da5bc8fa22997bc0344bb0f95666ba6aaff0242baa99)",
        )
        .unwrap();
    }

    #[test]
    fn multi_a_tests() {
            type Segwitv0Ms = Miniscript<String, Segwitv0>;
        type TapMs = Miniscript<String, Tap>;
        let segwit_multi_a_ms = Segwitv0Ms::from_str_insane("multi_a(1,A,B,C)");
        assert_eq!(
            segwit_multi_a_ms.unwrap_err().to_string(),
            "Multi a(CHECKSIGADD) only allowed post tapscript"
        );
        let tap_multi_a_ms = TapMs::from_str_insane("multi_a(1,A,B,C)").unwrap();
        assert_eq!(tap_multi_a_ms.to_string(), "multi_a(1,A,B,C)");

               let tap_ms = tap_multi_a_ms
            .translate_pk(&mut StrXOnlyKeyTranslator::new())
            .unwrap();
             assert_eq!(
            Miniscript::<XOnlyPublicKey, Tap>::parse_insane(&tap_ms.encode()).unwrap(),
            tap_ms
        );
        assert_eq!(tap_ms.script_size(), 104);
        assert_eq!(tap_ms.encode().len(), tap_ms.script_size());

               struct SimpleSatisfier(secp256k1::schnorr::Signature);

              impl<Pk: ToPublicKey> Satisfier<Pk> for SimpleSatisfier {
            fn lookup_tap_leaf_script_sig(
                &self,
                _pk: &Pk,
                _h: &TapLeafHash,
            ) -> Option<bitcoin::taproot::Signature> {
                Some(bitcoin::taproot::Signature {
                    signature: self.0,
                    sighash_type: bitcoin::sighash::TapSighashType::Default,
                })
            }
        }

        let schnorr_sig = secp256k1::schnorr::Signature::from_str("84526253c27c7aef56c7b71a5cd25bebb66dddda437826defc5b2568bde81f0784526253c27c7aef56c7b71a5cd25bebb66dddda437826defc5b2568bde81f07").unwrap();
        let s = SimpleSatisfier(schnorr_sig);
        let template = tap_ms.build_template(&s);
        assert_eq!(template.absolute_timelock, None);
        assert_eq!(template.relative_timelock, None);

        let wit = tap_ms.satisfy(&s).unwrap();
        assert_eq!(wit, vec![schnorr_sig.as_ref().to_vec(), vec![], vec![]]);
    }

    #[test]
    fn decode_bug_cpp_review() {
        let ms = Miniscript::<String, Segwitv0>::from_str_insane(
            "and_b(1,s:and_v(v:older(9),c:pk_k(A)))",
        )
        .unwrap();
        let ms_trans = ms.translate_pk(&mut StrKeyTranslator::new()).unwrap();
        let enc = ms_trans.encode();
        let ms = Miniscript::<bitcoin::PublicKey, Segwitv0>::parse_insane(&enc).unwrap();
        assert_eq!(ms_trans.encode(), ms.encode());
    }

    #[test]
    fn expr_features() {
                let hash160_str = "e9f171df53e04b270fa6271b42f66b0f4a99c5a2";
        let ms_str = &format!("c:expr_raw_pkh({})", hash160_str);
        type SegwitMs = Miniscript<bitcoin::PublicKey, Segwitv0>;

                SegwitMs::from_str(ms_str).unwrap_err();
        SegwitMs::from_str_insane(ms_str).unwrap_err();
        let ms = SegwitMs::from_str_ext(ms_str, &ExtParams::allow_all()).unwrap();

        let script = ms.encode();
                SegwitMs::parse(&script).unwrap_err();
        SegwitMs::parse_insane(&script).unwrap_err();
        SegwitMs::parse_with_ext(&script, &ExtParams::allow_all()).unwrap();
    }

    #[test]
    fn tr_multi_a_j_wrapper() {
               type TapMs = Miniscript<String, Tap>;
        let ms_str = TapMs::from_str_insane("j:multi_a(1,A,B,C)");
        assert!(ms_str.is_err());
    }

    #[test]
    fn translate_tests() {
        let ms = Miniscript::<String, Segwitv0>::from_str("pk(A)").unwrap();
        let mut t = StrKeyTranslator::new();
        let uncompressed = bitcoin::PublicKey::from_str("0400232a2acfc9b43fa89f1b4f608fde335d330d7114f70ea42bfb4a41db368a3e3be6934a4097dd25728438ef73debb1f2ffdb07fec0f18049df13bdc5285dc5b").unwrap();
        t.pk_map.insert(String::from("A"), uncompressed);
        ms.translate_pk(&mut t).unwrap_err();
    }

    #[test]
    fn template_timelocks() {
        use crate::{AbsLockTime, RelLockTime};
        let key_present = bitcoin::PublicKey::from_str(
            "0327a6ed0e71b451c79327aa9e4a6bb26ffb1c0056abc02c25e783f6096b79bb4f",
        )
        .unwrap();
        let key_missing = bitcoin::PublicKey::from_str(
            "03e4d788718644a59030b1d234d8bb8fff28314720b9a1a237874b74b089c638da",
        )
        .unwrap();

              let test_cases = vec![
            (format!("t:or_c(pk({}),v:pkh({}))", key_present, key_missing), None, None),
            (
                format!("thresh(2,pk({}),s:pk({}),snl:after(1))", key_present, key_missing),
                Some(AbsLockTime::from_consensus(1).unwrap()),
                None,
            ),
            (
                format!("or_d(pk({}),and_v(v:pk({}),older(12960)))", key_present, key_missing),
                None,
                None,
            ),
            (
                format!("or_d(pk({}),and_v(v:pk({}),older(12960)))", key_missing, key_present),
                None,
                Some(RelLockTime::from_height(12960)),
            ),
            (
                format!(
                    "thresh(3,pk({}),s:pk({}),snl:older(10),snl:after(11))",
                    key_present, key_missing
                ),
                Some(AbsLockTime::from_consensus(11).unwrap()),
                Some(RelLockTime::from_height(10)),
            ),
            (
                format!("and_v(v:and_v(v:pk({}),older(10)),older(20))", key_present),
                None,
                Some(RelLockTime::from_height(20)),
            ),
            (
                format!(
                    "andor(pk({}),older(10),and_v(v:pk({}),older(20)))",
                    key_present, key_missing
                ),
                None,
                Some(RelLockTime::from_height(10)),
            ),
        ];

               struct SimpleSatisfier(secp256k1::schnorr::Signature, bitcoin::PublicKey);

             impl Satisfier<bitcoin::PublicKey> for SimpleSatisfier {
            fn lookup_tap_leaf_script_sig(
                &self,
                pk: &bitcoin::PublicKey,
                _h: &TapLeafHash,
            ) -> Option<bitcoin::taproot::Signature> {
                if pk == &self.1 {
                    Some(bitcoin::taproot::Signature {
                        signature: self.0,
                        sighash_type: bitcoin::sighash::TapSighashType::Default,
                    })
                } else {
                    None
                }
            }

            fn check_older(&self, _: bitcoin::relative::LockTime) -> bool { true }

            fn check_after(&self, _: bitcoin::absolute::LockTime) -> bool { true }
        }

        let schnorr_sig = secp256k1::schnorr::Signature::from_str("84526253c27c7aef56c7b71a5cd25bebb66dddda437826defc5b2568bde81f0784526253c27c7aef56c7b71a5cd25bebb66dddda437826defc5b2568bde81f07").unwrap();
        let s = SimpleSatisfier(schnorr_sig, key_present);

        for (ms_str, absolute_timelock, relative_timelock) in test_cases {
            let ms = Miniscript::<bitcoin::PublicKey, Tap>::from_str(&ms_str).unwrap();
            let template = ms.build_template(&s);
            match template.stack {
                crate::miniscript::satisfy::Witness::Stack(_) => {}
                _ => panic!("All testcases should be possible"),
            }
            assert_eq!(template.absolute_timelock, absolute_timelock, "{}", ms_str);
            assert_eq!(template.relative_timelock, relative_timelock, "{}", ms_str);
        }
    }

    #[test]
    fn test_dos() {
        let ms = "slnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn:0";
        matches!(
            Miniscript::<String, Tap>::from_str_insane(ms),
            Err(Error::MaxRecursiveDepthExceeded)
        );
    }

    #[test]
    fn test_script_parse_dos() {
        let mut script = bitcoin::script::Builder::new().push_opcode(bitcoin::opcodes::OP_TRUE);
        for _ in 0..10000 {
            script = script.push_opcode(bitcoin::opcodes::all::OP_0NOTEQUAL);
        }
        Tapscript::parse_insane(&script.into_script()).unwrap_err();
    }
}
