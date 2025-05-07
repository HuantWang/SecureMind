

private static int ImplGetInteger(string envVariable, int defaultValue)
        {
            string property = Platform.GetEnvironmentVariable(envVariable);

            return int.TryParse(property, out int value) ? value : defaultValue;
        }

private static IFiniteField BuildField(int m, int k1, int k2, int k3)
        {
            int[] exponents = (k2 | k3) == 0
                ? new int[]{ 0, k1, m }
                : new int[]{ 0, k1, k2, k3, m };

            return FiniteFields.GetBinaryExtensionField(exponents);
        }

