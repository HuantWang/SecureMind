internal static int ImplGetInteger(string envVariable, int defaultValue)
        {
            string property = Platform.GetEnvironmentVariable(envVariable);

            return int.TryParse(property, out int value) ? value : defaultValue;
        }



private static IFiniteField BuildField(int m, int k1, int k2, int k3)
        {
            int maxM = ImplGetInteger("Org.BouncyCastle.EC.F2m_MaxSize", 1142); 
            if (m > maxM)
                throw new ArgumentException("F2m m value out of range");

            int[] exponents = (k2 | k3) == 0
                ? new int[]{ 0, k1, m }
                : new int[]{ 0, k1, k2, k3, m };

            return FiniteFields.GetBinaryExtensionField(exponents);
        }

[Test]
        public void TestLargeMInF2m()
        {
            int m = 2048;
            int k1 = 1;
            BigInteger aTpb = new BigInteger("1000", 2);
            BigInteger bTpb = new BigInteger("1001", 2);
            BigInteger n = new BigInteger("23");
            BigInteger h = new BigInteger("1");

            try
            {
                F2mCurve curve = new F2mCurve(m, k1, aTpb, bTpb, n, h);
            }
            catch (ArgumentException e)
            {
                Assert.AreEqual("F2m m value out of range", e.Message);
            }
        }