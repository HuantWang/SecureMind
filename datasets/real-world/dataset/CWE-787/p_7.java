public interface ListDelimiterHandler {
      ValueTransformer NOOP_TRANSFORMER = value -> value;

        Object escape(Object value, ValueTransformer transformer);

      Object escapeList(List<?> values, ValueTransformer transformer);

       default Collection<?> flatten(final Object value, final int limit) {
        return AbstractListDelimiterHandler.flatten(this, value, limit, Collections.newSetFromMap(new IdentityHashMap<>()));
    }

       Iterable<?> parse(Object value);

       Collection<String> split(String s, boolean trim);

}






public class TestPropertiesConfiguration {
       static class DummyLayout extends PropertiesConfigurationLayout {
               public int loadCalls;
 
         @Override
         public void load(final PropertiesConfiguration config, final Reader in) throws ConfigurationException {
             loadCalls++;
         }
     }
 
        static class MockHttpURLConnection extends HttpURLConnection {
                  private final int returnCode;
 
                 private final File outputFile;
 
         protected MockHttpURLConnection(final URL u, final int respCode, final File outFile) {
             super(u);
             returnCode = respCode;
             outputFile = outFile;
         }
 
         @Override
         public void connect() throws IOException {
         }
 
         @Override
         public void disconnect() {
         }
 
         @Override
         public OutputStream getOutputStream() throws IOException {
             return new FileOutputStream(outputFile);
         }
 
         @Override
         public int getResponseCode() throws IOException {
             return returnCode;
         }
 
         @Override
         public boolean usingProxy() {
             return false;
         }
     }
 
         static class MockHttpURLStreamHandler extends URLStreamHandler {
                  private final int responseCode;
 
                 private final File outputFile;
 
               private MockHttpURLConnection connection;
 
         public MockHttpURLStreamHandler(final int respCode, final File outFile) {
             responseCode = respCode;
             outputFile = outFile;
         }
 
         public MockHttpURLConnection getMockConnection() {
             return connection;
         }
 
         @Override
         protected URLConnection openConnection(final URL u) throws IOException {
             connection = new MockHttpURLConnection(u, responseCode, outputFile);
             return connection;
         }
     }
 
          private static final class PropertiesReaderTestImpl extends PropertiesConfiguration.PropertiesReader {
         /** The number of test properties to be created. */
         private final int maxProperties;
 
                 private int propertyCount;
 
         public PropertiesReaderTestImpl(final Reader reader, final int maxProps) {
             super(reader);
             maxProperties = maxProps;
         }
 
         @Override
         public String getPropertyName() {
             return PROP_NAME + propertyCount;
         }
 
         @Override
         public String getPropertyValue() {
             return PROP_VALUE + propertyCount;
         }
 
         @Override
         public boolean nextProperty() throws IOException {
             propertyCount++;
             return propertyCount <= maxProperties;
         }
     }
 
         private static final class PropertiesWriterTestImpl extends PropertiesConfiguration.PropertiesWriter {
         public PropertiesWriterTestImpl(final ListDelimiterHandler handler) throws IOException {
             super(new FileWriter(testSavePropertiesFile), handler);
         }
     }
 
          private static final String PROP_NAME = "testProperty";
          private static final String PROP_VALUE = "value";
         private static final String CR = System.lineSeparator();
 
        private static final String testProperties = ConfigurationAssert.getTestFile("test.properties").getAbsolutePath();
 
     private static final String testBasePath = ConfigurationAssert.TEST_DIR.getAbsolutePath();
 
     private static final String testBasePath2 = ConfigurationAssert.TEST_DIR.getParentFile().getAbsolutePath();
 
     private static final File testSavePropertiesFile = ConfigurationAssert.getOutFile("testsave.properties");
 
        private static FileHandler load(final PropertiesConfiguration pc, final String fileName) throws ConfigurationException {
         final FileHandler handler = new FileHandler(pc);
         handler.setFileName(fileName);
         handler.load();
         return handler;
     }
 
       private PropertiesConfiguration conf;
 
         @TempDir
     public File tempFolder;
 
       private void checkBackslashList(final String key) {
         final Object prop = conf.getProperty("test." + key);
         final List<?> list = assertInstanceOf(List.class, prop);
         final String prefix = "\\\\" + key;
         assertEquals(Arrays.asList(prefix + "a", prefix + "b"), list);
     }
 
        private void checkCopiedConfig(final Configuration copyConf) throws ConfigurationException {
         saveTestConfig();
         final PropertiesConfiguration checkConf = new PropertiesConfiguration();
         load(checkConf, testSavePropertiesFile.getAbsolutePath());
         for (final Iterator<String> it = copyConf.getKeys(); it.hasNext();) {
             final String key = it.next();
             assertEquals(checkConf.getProperty(key), copyConf.getProperty(key), "Wrong value for property " + key);
         }
     }
 
        private void checkEmpty(final String key) {
         final String empty = conf.getString(key);
         assertNotNull(empty, "Property not found: " + key);
         assertEquals("", empty, "Wrong value for property " + key);
     }
 
        private PropertiesConfiguration checkSavedConfig() throws ConfigurationException {
         final PropertiesConfiguration checkConfig = new PropertiesConfiguration();
         checkConfig.setListDelimiterHandler(new LegacyListDelimiterHandler(','));
         load(checkConfig, testSavePropertiesFile.getAbsolutePath());
         ConfigurationAssert.assertConfigurationEquals(conf, checkConfig);
         return checkConfig;
     }
 
         private void saveTestConfig() throws ConfigurationException {
         final FileHandler handler = new FileHandler(conf);
         handler.save(testSavePropertiesFile);
     }
 
     @BeforeEach
     public void setUp() throws Exception {
         conf = new PropertiesConfiguration();
         conf.setListDelimiterHandler(new LegacyListDelimiterHandler(','));
         load(conf, testProperties);
 
                 if (testSavePropertiesFile.exists()) {
             assertTrue(testSavePropertiesFile.delete());
         }
     }
 
         private Configuration setUpCopyConfig() {
         final int count = 25;
         final Configuration result = new BaseConfiguration();
         for (int i = 1; i <= count; i++) {
             result.addProperty("copyKey" + i, "copyValue" + i);
         }
         return result;
     }
 
         @Test
     public void testAppend() throws Exception {
         final File file2 = ConfigurationAssert.getTestFile("threesome.properties");
         final FileHandler handler = new FileHandler(conf);
         handler.load(file2);
         assertEquals("aaa", conf.getString("test.threesome.one"));
         assertEquals("true", conf.getString("configuration.loaded"));
     }
 
          @Test
     public void testAppendAndSave() throws ConfigurationException {
         final Configuration copyConf = setUpCopyConfig();
         conf.append(copyConf);
         checkCopiedConfig(copyConf);
     }
 
         @Test
     public void testBackslashEscapingInLists() throws Exception {
         checkBackslashList("share2");
         checkBackslashList("share1");
     }
 
        @Test
     public void testChangingListDelimiter() throws Exception {
         assertEquals("a^b^c", conf.getString("test.other.delimiter"));
         final PropertiesConfiguration pc2 = new PropertiesConfiguration();
         pc2.setListDelimiterHandler(new DefaultListDelimiterHandler('^'));
         load(pc2, testProperties);
         assertEquals("a", pc2.getString("test.other.delimiter"));
         assertEquals(3, pc2.getList("test.other.delimiter").size());
     }
 
        @Test
     public void testClearFooterComment() {
         conf.clear();
         assertNull(conf.getFooter());
         assertNull(conf.getHeader());
     }
 
       @Test
     public void testClone() throws ConfigurationException {
         final PropertiesConfiguration copy = (PropertiesConfiguration) conf.clone();
         assertNotSame(conf.getLayout(), copy.getLayout());
         assertEquals(1, conf.getEventListeners(ConfigurationEvent.ANY).size());
         assertEquals(1, copy.getEventListeners(ConfigurationEvent.ANY).size());
         assertSame(conf.getLayout(), conf.getEventListeners(ConfigurationEvent.ANY).iterator().next());
         assertSame(copy.getLayout(), copy.getEventListeners(ConfigurationEvent.ANY).iterator().next());
         final StringWriter outConf = new StringWriter();
         new FileHandler(conf).save(outConf);
         final StringWriter outCopy = new StringWriter();
         new FileHandler(copy).save(outCopy);
         assertEquals(outConf.toString(), outCopy.toString());
     }
 
          @Test
     public void testCloneNullLayout() {
         conf = new PropertiesConfiguration();
         final PropertiesConfiguration copy = (PropertiesConfiguration) conf.clone();
         assertNotSame(conf.getLayout(), copy.getLayout());
     }
 
         @Test
     public void testComment() {
         assertFalse(conf.containsKey("#comment"));
         assertFalse(conf.containsKey("!comment"));
     }
 
     private Collection<?> testCompress840(final Iterable<?> object) {
         final PropertiesConfiguration configuration = new PropertiesConfiguration();
         final ListDelimiterHandler listDelimiterHandler = configuration.getListDelimiterHandler();
         listDelimiterHandler.flatten(object, 0);
                 listDelimiterHandler.flatten(object, 1);
         listDelimiterHandler.flatten(object, Integer.MAX_VALUE);
         listDelimiterHandler.parse(object);
         configuration.addProperty("foo", object);
         configuration.toString();
         return listDelimiterHandler.flatten(object, Integer.MAX_VALUE);
     }
 
     @ParameterizedTest
     @ValueSource(ints = { 0, 2, 4, 8, 16 })
     public void testCompress840ArrayList(final int size) {
         final ArrayList<Object> object = new ArrayList<>();
         for (int i = 0; i < size; i++) {
             object.add(i);
         }
         final Collection<?> result = testCompress840(object);
         assertNotNull(result);
         assertEquals(size, result.size());
         assertEquals(object, result);
     }
 
     @ParameterizedTest
     @ValueSource(ints = { 0, 2, 4, 8, 16 })
     public void testCompress840ArrayListCycle(final int size) {
         final ArrayList<Object> object = new ArrayList<>();
         for (int i = 0; i < size; i++) {
             object.add(i);
             object.add(object);
             object.add(new ArrayList<>(object));
         }
         final Collection<?> result = testCompress840(object);
         assertNotNull(result);
         assertEquals(size, result.size());
         object.add(object);
         testCompress840(object);
     }
 
     @Test
     public void testCompress840BeanContextServicesSupport() {
         testCompress840(new BeanContextServicesSupport());
         testCompress840(new BeanContextServicesSupport(new BeanContextServicesSupport()));
         final BeanContextSupport bcs = new BeanContextSupport();
         final BeanContextServicesSupport bcss = new BeanContextServicesSupport();
         bcs.add(FileSystems.getDefault().getPath("bar"));
         bcss.add(bcs);
         testCompress840(bcss);
         bcss.add(FileSystems.getDefault().getPath("bar"));
         testCompress840(bcss);
         bcss.add(bcss);
         testCompress840(bcss);
     }
 
     @Test
     public void testCompress840BeanContextSupport() {
         testCompress840(new BeanContextSupport());
         testCompress840(new BeanContextSupport(new BeanContextSupport()));
         final BeanContextSupport bcs = new BeanContextSupport();
         bcs.add(FileSystems.getDefault().getPath("bar"));
         testCompress840(bcs);
         bcs.add(bcs);
         testCompress840(bcs);
     }
 
     @ParameterizedTest
     @ValueSource(ints = { 0, 2, 4, 8, 16 })
     public void testCompress840Exception(final int size) {
         final ArrayList<Object> object = new ArrayList<>();
         final Exception bottom = new Exception();
         object.add(bottom);
         Exception top = bottom;
         for (int i = 0; i < size; i++) {
             object.add(i);
             top = new Exception(top);
             object.add(top);
         }
         if (bottom != top) {
                      bottom.initCause(top);
         }
         final Collection<?> result = testCompress840(object);
         assertNotNull(result);
         assertEquals(size * 2 + 1, result.size());
         assertEquals(object, result);
     }
 
     @ParameterizedTest
     @ValueSource(ints = { 0, 2, 4, 8, 16 })
     public void testCompress840Path(final int size) {
         final PriorityQueue<Object> object = new PriorityQueue<>();
         for (int i = 0; i < size; i++) {
             object.add(FileSystems.getDefault().getPath("foo"));
             object.add(FileSystems.getDefault().getPath("foo", "bar"));
         }
         testCompress840(object);
     }
 
     @ParameterizedTest
     @ValueSource(ints = { 0, 2, 4, 8, 16 })
     public void testCompress840PriorityQueue(final int size) {
         final PriorityQueue<Object> object = new PriorityQueue<>();
         for (int i = 0; i < size; i++) {
             object.add(FileSystems.getDefault().getPath("foo"));
         }
         testCompress840(object);
     }
 
          @Test
     public void testCopyAndSave() throws ConfigurationException {
         final Configuration copyConf = setUpCopyConfig();
         conf.copy(copyConf);
         checkCopiedConfig(copyConf);
     }
 
       @Test
     public void testDisableIncludes() throws ConfigurationException, IOException {
         final String content = PropertiesConfiguration.getInclude() + " = nonExistingIncludeFile" + CR + PROP_NAME + " = " + PROP_VALUE + CR;
         final StringReader in = new StringReader(content);
         conf = new PropertiesConfiguration();
         conf.setIncludesAllowed(false);
         conf.read(in);
         assertEquals(PROP_VALUE, conf.getString(PROP_NAME));
     }
 
     @Test
     public void testDisableListDelimiter() throws Exception {
         assertEquals(4, conf.getList("test.mixed.array").size());
 
         final PropertiesConfiguration pc2 = new PropertiesConfiguration();
         load(pc2, testProperties);
         assertEquals(2, pc2.getList("test.mixed.array").size());
     }
 
       @Test
     public void testEmpty() {
         checkEmpty("test.empty");
     }
 
          @Test
     public void testEmptyNoSeparator() {
         checkEmpty("test.empty2");
     }
 
     @Test
     public void testEscapedKey() throws Exception {
         conf.clear();
         final FileHandler handler = new FileHandler(conf);
         handler.load(new StringReader("\\u0066\\u006f\\u006f=bar"));
 
         assertEquals("bar", conf.getString("foo"));
     }
 
        @Test
     public void testEscapedKeyValueSeparator() {
         assertEquals("foo", conf.getProperty("test.separator=in.key"));
         assertEquals("bar", conf.getProperty("test.separator:in.key"));
         assertEquals("foo", conf.getProperty("test.separator\tin.key"));
         assertEquals("bar", conf.getProperty("test.separator\fin.key"));
         assertEquals("foo", conf.getProperty("test.separator in.key"));
     }
 
        @Test
     public void testEscapeQuote() throws ConfigurationException {
         conf.clear();
         final String text = "\"Hello World!\"";
         conf.setProperty(PROP_NAME, text);
         final StringWriter out = new StringWriter();
         new FileHandler(conf).save(out);
         assertTrue(out.toString().contains(text));
         saveTestConfig();
         final PropertiesConfiguration c2 = new PropertiesConfiguration();
         load(c2, testSavePropertiesFile.getAbsolutePath());
         assertEquals(text, c2.getString(PROP_NAME));
     }
      @Test
     public void testFileWithSharpSymbol() throws Exception {
         final File file = newFile("sharp#1.properties", tempFolder);
 
         final PropertiesConfiguration conf = new PropertiesConfiguration();
         final FileHandler handler = new FileHandler(conf);
         handler.setFile(file);
         handler.load();
         handler.save();
 
         assertTrue(file.exists());
     }
 
      @Test
     public void testGetFooterSynchronized() {
         final SynchronizerTestImpl sync = new SynchronizerTestImpl();
         conf.setSynchronizer(sync);
         assertNotNull(conf.getFooter());
         sync.verify(Methods.BEGIN_READ, Methods.END_READ);
     }
 
       @Test
     public void testGetHeaderSynchronized() {
         final SynchronizerTestImpl sync = new SynchronizerTestImpl();
         conf.setSynchronizer(sync);
         assertNull(conf.getHeader());
         sync.verify(Methods.BEGIN_READ, Methods.END_READ);
     }
 
       @Test
     public void testGetIOFactoryDefault() {
         assertNotNull(conf.getIOFactory());
     }
 
      @Test
     public void testGetLayout() {
         final PropertiesConfigurationLayout layout = conf.getLayout();
         assertNotNull(layout);
         assertSame(layout, conf.getLayout());
         conf.setLayout(null);
         final PropertiesConfigurationLayout layout2 = conf.getLayout();
         assertNotNull(layout2);
         assertNotSame(layout, layout2);
     }
 
     @Test
     public void testGetStringWithEscapedChars() {
         final String property = conf.getString("test.unescape");
         assertEquals("This \n string \t contains \" escaped \\ characters", property);
     }
 
     @Test
     public void testGetStringWithEscapedComma() {
         final String property = conf.getString("test.unescape.list-separator");
         assertEquals("This string contains , an escaped list separator", property);
     }
 
     @Test
     public void testIncludeIncludeLoadAllOnNotFound() throws Exception {
         final PropertiesConfiguration pc = new PropertiesConfiguration();
         pc.setIncludeListener(PropertiesConfiguration.NOOP_INCLUDE_LISTENER);
         final FileHandler handler = new FileHandler(pc);
         handler.setBasePath(testBasePath);
         handler.setFileName("include-include-not-found.properties");
         handler.load();
         assertEquals("valueA", pc.getString("keyA"));
         assertEquals("valueB", pc.getString("keyB"));
     }
 
     @Test
     public void testIncludeIncludeLoadCyclicalReferenceFail() throws Exception {
         final PropertiesConfiguration pc = new PropertiesConfiguration();
         final FileHandler handler = new FileHandler(pc);
         handler.setBasePath(testBasePath);
         handler.setFileName("include-include-cyclical-reference.properties");
         assertThrows(ConfigurationException.class, handler::load);
         assertNull(pc.getString("keyA"));
     }
 
     @Test
     public void testIncludeIncludeLoadCyclicalReferenceIgnore() throws Exception {
         final PropertiesConfiguration pc = new PropertiesConfiguration();
         pc.setIncludeListener(PropertiesConfiguration.NOOP_INCLUDE_LISTENER);
         final FileHandler handler = new FileHandler(pc);
         handler.setBasePath(testBasePath);
         handler.setFileName("include-include-cyclical-reference.properties");
         handler.load();
         assertEquals("valueA", pc.getString("keyA"));
     }
 
         @Test
     public void testIncludeInSubDir() throws ConfigurationException {
         final CombinedConfigurationBuilder builder = new CombinedConfigurationBuilder();
         builder.configure(new FileBasedBuilderParametersImpl().setFileName("testFactoryPropertiesInclude.xml"));
         final Configuration config = builder.getConfiguration();
         assertTrue(config.getBoolean("deeptest"));
         assertTrue(config.getBoolean("deepinclude"));
         assertFalse(config.containsKey("deeptestinvalid"));
     }
 
     @Test
     public void testIncludeLoadAllOnLoadException() throws Exception {
         final PropertiesConfiguration pc = new PropertiesConfiguration();
         pc.setIncludeListener(PropertiesConfiguration.NOOP_INCLUDE_LISTENER);
         final FileHandler handler = new FileHandler(pc);
         handler.setBasePath(testBasePath);
         handler.setFileName("include-load-exception.properties");
         handler.load();
         assertEquals("valueA", pc.getString("keyA"));
     }
 
     @Test
     public void testIncludeLoadAllOnNotFound() throws Exception {
         final PropertiesConfiguration pc = new PropertiesConfiguration();
         pc.setIncludeListener(PropertiesConfiguration.NOOP_INCLUDE_LISTENER);
         final FileHandler handler = new FileHandler(pc);
         handler.setBasePath(testBasePath);
         handler.setFileName("include-not-found.properties");
         handler.load();
         assertEquals("valueA", pc.getString("keyA"));
     }
 
     @Test
     public void testIncludeLoadCyclicalMultiStepReferenceFail() throws Exception {
         final PropertiesConfiguration pc = new PropertiesConfiguration();
         final FileHandler handler = new FileHandler(pc);
         handler.setBasePath(testBasePath);
         handler.setFileName("include-cyclical-root.properties");
         assertThrows(ConfigurationException.class, handler::load);
         assertNull(pc.getString("keyA"));
     }
 
     @Test
     public void testIncludeLoadCyclicalMultiStepReferenceIgnore() throws Exception {
         final PropertiesConfiguration pc = new PropertiesConfiguration();
         pc.setIncludeListener(PropertiesConfiguration.NOOP_INCLUDE_LISTENER);
         final FileHandler handler = new FileHandler(pc);
         handler.setBasePath(testBasePath);
         handler.setFileName("include-cyclical-root.properties");
         handler.load();
         assertEquals("valueA", pc.getString("keyA"));
     }
 
     @Test
     public void testIncludeLoadCyclicalReferenceFail() throws Exception {
         final PropertiesConfiguration pc = new PropertiesConfiguration();
         final FileHandler handler = new FileHandler(pc);
         handler.setBasePath(testBasePath);
         handler.setFileName("include-cyclical-reference.properties");
         assertThrows(ConfigurationException.class, handler::load);
         assertNull(pc.getString("keyA"));
     }
 
     @Test
     public void testIncludeLoadCyclicalReferenceIgnore() throws Exception {
         final PropertiesConfiguration pc = new PropertiesConfiguration();
         pc.setIncludeListener(PropertiesConfiguration.NOOP_INCLUDE_LISTENER);
         final FileHandler handler = new FileHandler(pc);
         handler.setBasePath(testBasePath);
         handler.setFileName("include-cyclical-reference.properties");
         handler.load();
         assertEquals("valueA", pc.getString("keyA"));
     }
 
         @Test
     public void testInitFromNonExistingFile() throws ConfigurationException {
         final String testProperty = "test.successfull";
         conf = new PropertiesConfiguration();
         final FileHandler handler = new FileHandler(conf);
         handler.setFile(testSavePropertiesFile);
         conf.addProperty(testProperty, "true");
         handler.save();
         checkSavedConfig();
     }
 
     @Test
     public void testInMemoryCreatedSave() throws Exception {
         conf = new PropertiesConfiguration();
                 conf.addProperty("string", "value1");
         final List<Object> list = new ArrayList<>();
         for (int i = 1; i < 5; i++) {
             list.add("value" + i);
         }
         conf.addProperty("array", list);
 
                saveTestConfig();
         assertTrue(testSavePropertiesFile.exists());
 
                  checkSavedConfig();
     }
 
         @Test
     public void testIsCommentLine() {
         assertTrue(PropertiesConfiguration.isCommentLine("# a comment"));
         assertTrue(PropertiesConfiguration.isCommentLine("! a comment"));
         assertTrue(PropertiesConfiguration.isCommentLine("#a comment"));
         assertTrue(PropertiesConfiguration.isCommentLine("    ! a comment"));
         assertFalse(PropertiesConfiguration.isCommentLine("   a#comment"));
     }
 
          @Test
     public void testJupRead() throws IOException, ConfigurationException {
         conf.clear();
         conf.setIOFactory(new PropertiesConfiguration.JupIOFactory());
 
         final String testFilePath = ConfigurationAssert.getTestFile("jup-test.properties").getAbsolutePath();
 
         load(conf, testFilePath);
 
         final Properties jup = new Properties();
         try (InputStream in = Files.newInputStream(Paths.get(testFilePath))) {
             jup.load(in);
         }
 
         @SuppressWarnings("unchecked")
         final Set<Object> pcKeys = new HashSet<>(IteratorUtils.toList(conf.getKeys()));
         assertEquals(jup.keySet(), pcKeys);
 
         for (final Object key : jup.keySet()) {
             final String keyString = key.toString();
             assertEquals(jup.getProperty(keyString), conf.getProperty(keyString), "Wrong property value for '" + keyString + "'");
         }
     }
 
          @Test
     public void testJupWrite() throws IOException, ConfigurationException {
         conf.clear();
         conf.setIOFactory(new PropertiesConfiguration.JupIOFactory());
 
         final String testFilePath = ConfigurationAssert.getTestFile("jup-test.properties").getAbsolutePath();
 
                  final Properties origProps = new Properties();
         try (InputStream in = Files.newInputStream(Paths.get(testFilePath))) {
             origProps.load(in);
         }
         for (final Object key : origProps.keySet()) {
             final String keyString = key.toString();
             conf.setProperty(keyString, origProps.getProperty(keyString));
         }
 
                  saveTestConfig();
         assertTrue(testSavePropertiesFile.exists());
 
                  final Properties testProps = new Properties();
         try (InputStream in = Files.newInputStream(testSavePropertiesFile.toPath())) {
             testProps.load(in);
         }
 
          @SuppressWarnings("unchecked")
         final Set<Object> pcKeys = new HashSet<>(IteratorUtils.toList(conf.getKeys()));
         assertEquals(testProps.keySet(), pcKeys);
 
         for (final Object key : testProps.keySet()) {
             final String keyString = key.toString();
             assertEquals(testProps.getProperty(keyString), conf.getProperty(keyString), "Wrong property value for '" + keyString + "'");
         }
     }
 
          @Test
     public void testJupWriteUtf8WithoutUnicodeEscapes() throws IOException, ConfigurationException {
         conf.clear();
         conf.setIOFactory(new PropertiesConfiguration.JupIOFactory(false));
 
         final String testFilePath = ConfigurationAssert.getTestFile("jup-test.properties").getAbsolutePath();
 
                  final Properties origProps = new Properties();
         try (InputStream in = Files.newInputStream(Paths.get(testFilePath))) {
             origProps.load(in);
         }
         for (final Object key : origProps.keySet()) {
             final String keyString = key.toString();
             conf.setProperty(keyString, origProps.getProperty(keyString));
         }
 
                final FileHandler handler = new FileHandler(conf);
         handler.setEncoding(StandardCharsets.UTF_8.name());
         handler.save(testSavePropertiesFile);
         assertTrue(testSavePropertiesFile.exists());
 
                final Properties testProps = new Properties();
         try (BufferedReader in = Files.newBufferedReader(testSavePropertiesFile.toPath(), StandardCharsets.UTF_8)) {
             testProps.load(in);
         }
 
                 @SuppressWarnings("unchecked")
         final Set<Object> pcKeys = new HashSet<>(IteratorUtils.toList(conf.getKeys()));
         assertEquals(testProps.keySet(), pcKeys);
 
         for (final Object key : testProps.keySet()) {
             final String keyString = key.toString();
             assertEquals(testProps.getProperty(keyString), conf.getProperty(keyString), "Wrong property value for '" + keyString + "'");
         }
 
                for (final String line : Files.readAllLines(testSavePropertiesFile.toPath())) {
             assertThat(line, not(containsString("\\u")));
         }
     }
 
         @Test
     public void testKeepSeparators() throws ConfigurationException, IOException {
         saveTestConfig();
         final String[] separatorTests = {"test.separator.equal = foo", "test.separator.colon : foo", "test.separator.tab\tfoo", "test.separator.whitespace foo",
             "test.separator.no.space=foo"};
         final Set<String> foundLines = new HashSet<>();
         try (BufferedReader in = new BufferedReader(new FileReader(testSavePropertiesFile))) {
             String s;
             while ((s = in.readLine()) != null) {
                 for (final String separatorTest : separatorTests) {
                     if (separatorTest.equals(s)) {
                         foundLines.add(s);
                     }
                 }
             }
         }
         assertThat(foundLines, containsInAnyOrder(separatorTests));
     }
 
         @Test
     public void testKeyValueSeparators() {
         assertEquals("foo", conf.getProperty("test.separator.equal"));
         assertEquals("foo", conf.getProperty("test.separator.colon"));
         assertEquals("foo", conf.getProperty("test.separator.tab"));
         assertEquals("foo", conf.getProperty("test.separator.formfeed"));
         assertEquals("foo", conf.getProperty("test.separator.whitespace"));
     }
 
     @Test
     public void testLargeKey() throws Exception {
         conf.clear();
         final String key = String.join("", Collections.nCopies(10000, "x"));
         final FileHandler handler = new FileHandler(conf);
         handler.load(new StringReader(key));
 
         assertEquals("", conf.getString(key));
     }
 
         @Test
     public void testLineSeparator() throws ConfigurationException {
         final String EOL = System.lineSeparator();
         conf = new PropertiesConfiguration();
         conf.setHeader("My header");
         conf.setProperty("prop", "value");
 
         final StringWriter out = new StringWriter();
         new FileHandler(conf).save(out);
         final String content = out.toString();
         assertEquals(0, content.indexOf("# My header" + EOL + EOL));
         assertThat(content, containsString("prop = value" + EOL));
     }
 
         @Test
     public void testList() throws Exception {
         final List<Object> packages = conf.getList("packages");
                assertEquals(3, packages.size());
     }
 
     @Test
     public void testLoad() throws Exception {
         final String loaded = conf.getString("configuration.loaded");
         assertEquals("true", loaded);
     }
 
     @Test
     public void testLoadFromFile() throws Exception {
         final File file = ConfigurationAssert.getTestFile("test.properties");
         conf.clear();
         final FileHandler handler = new FileHandler(conf);
         handler.setFile(file);
         handler.load();
 
         assertEquals("true", conf.getString("configuration.loaded"));
     }
 
        @Test
     public void testLoadInclude() throws Exception {
         final String loaded = conf.getString("include.loaded");
         assertEquals("true", loaded);
     }
 
       @Test
     public void testLoadIncludeFileViaFileSystem() throws ConfigurationException {
         conf.clear();
         conf.addProperty("include", "include.properties");
         saveTestConfig();
 
         final FileSystem fs = new DefaultFileSystem() {
             @Override
             public InputStream getInputStream(final URL url) throws ConfigurationException {
                 if (url.toString().endsWith("include.properties")) {
                     return new ByteArrayInputStream("test.outcome = success".getBytes(StandardCharsets.UTF_8));
                 }
                 return super.getInputStream(url);
             }
         };
         final Parameters params = new Parameters();
         final FileBasedConfigurationBuilder<PropertiesConfiguration> builder = new FileBasedConfigurationBuilder<>(PropertiesConfiguration.class);
         builder.configure(params.fileBased().setFile(testSavePropertiesFile).setBasePath(ConfigurationAssert.OUT_DIR.toURI().toString()).setFileSystem(fs));
         final PropertiesConfiguration configuration = builder.getConfiguration();
         assertEquals("success", configuration.getString("test.outcome"));
     }
      @Test
     public void testLoadIncludeFromClassPath() {
         assertEquals("true", conf.getString("include.loaded"));
     }
 
         @Test
     public void testLoadIncludeFromReader() throws ConfigurationException {
         final StringReader in = new StringReader(PropertiesConfiguration.getInclude() + " = " + ConfigurationAssert.getTestURL("include.properties"));
         conf = new PropertiesConfiguration();
         final FileHandler handler = new FileHandler(conf);
         handler.load(in);
         assertEquals("true", conf.getString("include.loaded"));
     }
 
         @Test
     public void testLoadIncludeInterpol() throws Exception {
         final String loaded = conf.getString("include.interpol.loaded");
         assertEquals("true", loaded);
     }
 
     @Test
     public void testLoadIncludeOptional() throws Exception {
         final PropertiesConfiguration pc = new PropertiesConfiguration();
         final FileHandler handler = new FileHandler(pc);
         handler.setBasePath(testBasePath);
         handler.setFileName("includeoptional.properties");
         handler.load();
 
         assertTrue(pc.getBoolean("includeoptional.loaded"));
     }
 
     @Test
     public void testLoadUnexistingFile() {
         assertThrows(ConfigurationException.class, () -> load(conf, "unexisting file"));
     }
 
     @Test
     public void testLoadViaPropertyWithBasePath() throws Exception {
         final PropertiesConfiguration pc = new PropertiesConfiguration();
         final FileHandler handler = new FileHandler(pc);
         handler.setBasePath(testBasePath);
         handler.setFileName("test.properties");
         handler.load();
 
         assertTrue(pc.getBoolean("test.boolean"));
     }
 
     @Test
     public void testLoadViaPropertyWithBasePath2() throws Exception {
         final PropertiesConfiguration pc = new PropertiesConfiguration();
         final FileHandler handler = new FileHandler(pc);
         handler.setBasePath(testBasePath2);
         handler.setFileName("test.properties");
         handler.load();
 
         assertTrue(pc.getBoolean("test.boolean"));
     }
 
     @Test
     public void testMixedArray() {
         final String[] array = conf.getStringArray("test.mixed.array");
 
         assertArrayEquals(new String[] {"a", "b", "c", "d"}, array);
     }
 
     @Test
     public void testMultilines() {
         final String property = "This is a value spread out across several adjacent " + "natural lines by escaping the line terminator with "
             + "a backslash character.";
 
         assertEquals(property, conf.getString("test.multilines"));
     }
 
       @Test
     public void testMultipleIncludeFiles() throws ConfigurationException {
         conf = new PropertiesConfiguration();
         final FileHandler handler = new FileHandler(conf);
         handler.load(ConfigurationAssert.getTestFile("config/testMultiInclude.properties"));
         assertEquals("topValue", conf.getString("top"));
         assertEquals(100, conf.getInt("property.c"));
         assertTrue(conf.getBoolean("include.loaded"));
     }
 
        @Test
     public void testNewLineEscaping() {
         final List<Object> list = conf.getList("test.path");
         assertEquals(Arrays.asList("C:\\path1\\", "C:\\path2\\", "C:\\path3\\complex\\test\\"), list);
     }
 
       @Test
     public void testPropertyLoaded() throws ConfigurationException {
         final DummyLayout layout = new DummyLayout();
         conf.setLayout(layout);
         conf.propertyLoaded("layoutLoadedProperty", "yes", null);
         assertEquals(0, layout.loadCalls);
         assertEquals("yes", conf.getString("layoutLoadedProperty"));
     }
 
         @Test
     public void testPropertyLoadedInclude() throws ConfigurationException {
         final DummyLayout layout = new DummyLayout();
         conf.setLayout(layout);
         conf.propertyLoaded(PropertiesConfiguration.getInclude(), "testClasspath.properties,testEqual.properties", new ArrayDeque<>());
         assertEquals(2, layout.loadCalls);
         assertFalse(conf.containsKey(PropertiesConfiguration.getInclude()));
     }
 
        @Test
     public void testPropertyLoadedIncludeNotAllowed() throws ConfigurationException {
         final DummyLayout layout = new DummyLayout();
         conf.setLayout(layout);
         conf.setIncludesAllowed(false);
         conf.propertyLoaded(PropertiesConfiguration.getInclude(), "testClassPath.properties,testEqual.properties", null);
         assertEquals(0, layout.loadCalls);
         assertFalse(conf.containsKey(PropertiesConfiguration.getInclude()));
     }
 
       @Test
     public void testReadCalledDirectly() throws IOException {
         conf = new PropertiesConfiguration();
         try (Reader in = new FileReader(ConfigurationAssert.getTestFile("test.properties"))) {
             final ConfigurationException e = assertThrows(ConfigurationException.class, () -> conf.read(in));
             assertThat(e.getMessage(), containsString("FileHandler"));
         }
     }
 
      @Test
     public void testReadFooterComment() {
         assertEquals("\n# This is a foot comment\n", conf.getFooter());
         assertEquals("\nThis is a foot comment\n", conf.getLayout().getCanonicalFooterCooment(false));
     }
 
         @Test
     public void testReference() throws Exception {
         assertEquals("baseextra", conf.getString("base.reference"));
     }
 
     @Test
     public void testSave() throws Exception {
                  conf.addProperty("string", "value1");
         final List<Object> list = new ArrayList<>();
         for (int i = 1; i < 5; i++) {
             list.add("value" + i);
         }
         conf.addProperty("array", list);
 
                  saveTestConfig();
         assertTrue(testSavePropertiesFile.exists());
 
             checkSavedConfig();
     }
 
        @Test
     public void testSaveEscapedEscapingCharacter() throws ConfigurationException {
         conf.addProperty("test.dirs", "C:\\Temp\\\\,D:\\Data\\\\,E:\\Test\\");
         final List<Object> dirs = conf.getList("test.dirs");
         assertEquals(3, dirs.size());
         saveTestConfig();
         checkSavedConfig();
     }
 
     @Test
     public void testSaveMissingFileName() {
         final FileHandler handler = new FileHandler(conf);
         assertThrows(ConfigurationException.class, handler::save);
     }
 
     @Test
     public void testSaveToCustomURL() throws Exception {
                 final URL url = new URL("foo", "", 0, newFile("testsave-custom-url.properties", tempFolder).getAbsolutePath(), new FileURLStreamHandler());
         final FileHandler handlerSave = new FileHandler(conf);
         handlerSave.save(url);
 
              final PropertiesConfiguration config2 = new PropertiesConfiguration();
         final FileHandler handlerLoad = new FileHandler(config2);
         handlerLoad.load(url);
         assertEquals("true", config2.getString("configuration.loaded"));
     }
 
         @Test
     public void testSaveToHTTPServerFail() throws Exception {
         final MockHttpURLStreamHandler handler = new MockHttpURLStreamHandler(HttpURLConnection.HTTP_BAD_REQUEST, testSavePropertiesFile);
         final URL url = new URL(null, "http://jakarta.apache.org", handler);
         final FileHandler fileHandler = new FileHandler(conf);
         final ConfigurationException cex = assertThrows(ConfigurationException.class, () -> fileHandler.save(url));
         assertInstanceOf(IOException.class, cex.getCause());
     }
 
      @Test
     public void testSaveToHTTPServerSuccess() throws Exception {
         final MockHttpURLStreamHandler handler = new MockHttpURLStreamHandler(HttpURLConnection.HTTP_OK, testSavePropertiesFile);
         final URL url = new URL(null, "http://jakarta.apache.org", handler);
         new FileHandler(conf).save(url);
         final MockHttpURLConnection con = handler.getMockConnection();
         assertTrue(con.getDoOutput());
         assertEquals("PUT", con.getRequestMethod());
         checkSavedConfig();
     }
 
        @Test
     public void testSaveWithBasePath() throws Exception {
         conf.setProperty("test", "true");
         final FileHandler handler = new FileHandler(conf);
         handler.setBasePath(testSavePropertiesFile.getParentFile().toURI().toURL().toString());
         handler.setFileName(testSavePropertiesFile.getName());
         handler.save();
         assertTrue(testSavePropertiesFile.exists());
     }
 
        @Test
     public void testSaveWithDataConfig() throws ConfigurationException {
         conf = new PropertiesConfiguration();
         final FileHandler handler = new FileHandler(conf);
         handler.setFile(testSavePropertiesFile);
         final DataConfiguration dataConfig = new DataConfiguration(conf);
         dataConfig.setProperty("foo", "bar");
         assertEquals("bar", conf.getString("foo"));
 
         handler.save();
         final PropertiesConfiguration config2 = new PropertiesConfiguration();
         load(config2, testSavePropertiesFile.getAbsolutePath());
         assertEquals("bar", config2.getString("foo"));
     }
 
        @Test
     public void testSaveWithDefaultListDelimiterHandler() throws ConfigurationException {
         conf.setListDelimiterHandler(new DefaultListDelimiterHandler(','));
         saveTestConfig();
 
         final PropertiesConfiguration checkConfig = new PropertiesConfiguration();
         checkConfig.setListDelimiterHandler(conf.getListDelimiterHandler());
         new FileHandler(checkConfig).load(testSavePropertiesFile);
         ConfigurationAssert.assertConfigurationEquals(conf, checkConfig);
     }
 
        @Test
     public void testSaveWithDelimiterParsingDisabled() throws ConfigurationException {
         conf.clear();
         conf.setListDelimiterHandler(new DisabledListDelimiterHandler());
         conf.addProperty("test.list", "a,b,c");
         conf.addProperty("test.dirs", "C:\\Temp\\,D:\\Data\\");
         saveTestConfig();
 
         final PropertiesConfiguration checkConfig = new PropertiesConfiguration();
         checkConfig.setListDelimiterHandler(new DisabledListDelimiterHandler());
         new FileHandler(checkConfig).load(testSavePropertiesFile);
         ConfigurationAssert.assertConfigurationEquals(conf, checkConfig);
     }
 
       @Test
     public void testSetFooterSynchronized() {
         final SynchronizerTestImpl sync = new SynchronizerTestImpl();
         conf.setSynchronizer(sync);
         conf.setFooter("new comment");
         sync.verify(Methods.BEGIN_WRITE, Methods.END_WRITE);
     }
 
         @Test
     public void testSetHeaderSynchronized() {
         final SynchronizerTestImpl sync = new SynchronizerTestImpl();
         conf.setSynchronizer(sync);
         conf.setHeader("new comment");
         sync.verify(Methods.BEGIN_WRITE, Methods.END_WRITE);
     }
 
     @Test
     public void testSetInclude() throws Exception {
         conf.clear();
            PropertiesConfiguration.setInclude("import");
 
                 load(conf, testProperties);
 
                 PropertiesConfiguration.setInclude("include");
 
         assertNull(conf.getString("include.loaded"));
     }
      @Test
     public void testSetIOFactoryNull() {
         assertThrows(IllegalArgumentException.class, () -> conf.setIOFactory(null));
     }
      @Test
     public void testSetIOFactoryReader() throws ConfigurationException {
         final int propertyCount = 10;
         conf.clear();
         conf.setIOFactory(new PropertiesConfiguration.IOFactory() {
             @Override
             public PropertiesConfiguration.PropertiesReader createPropertiesReader(final Reader in) {
                 return new PropertiesReaderTestImpl(in, propertyCount);
             }
 
             @Override
             public PropertiesConfiguration.PropertiesWriter createPropertiesWriter(final Writer out, final ListDelimiterHandler handler) {
                 throw new UnsupportedOperationException("Unexpected call!");
             }
         });
         load(conf, testProperties);
         for (int i = 1; i <= propertyCount; i++) {
             assertEquals(PROP_VALUE + i, conf.getString(PROP_NAME + i), "Wrong property value at " + i);
         }
     }
 
        @Test
     public void testSetIOFactoryWriter() throws ConfigurationException, IOException {
         final MutableObject<Writer> propertiesWriter = new MutableObject<>();
         conf.setIOFactory(new PropertiesConfiguration.IOFactory() {
             @Override
             public PropertiesConfiguration.PropertiesReader createPropertiesReader(final Reader in) {
                 throw new UnsupportedOperationException("Unexpected call!");
             }
 
             @Override
             public PropertiesConfiguration.PropertiesWriter createPropertiesWriter(final Writer out, final ListDelimiterHandler handler) {
                 try {
                     final PropertiesWriterTestImpl propWriter = new PropertiesWriterTestImpl(handler);
                     propertiesWriter.setValue(propWriter);
                     return propWriter;
                 } catch (final IOException e) {
                     return null;
                 }
             }
         });
         new FileHandler(conf).save(new StringWriter());
         propertiesWriter.getValue().close();
         checkSavedConfig();
     }
      @Test
     public void testSetPropertyListWithDelimiterParsingDisabled() throws ConfigurationException {
         final String prop = "delimiterListProp";
         conf.setListDelimiterHandler(DisabledListDelimiterHandler.INSTANCE);
         final List<String> list = Arrays.asList("val", "val2", "val3");
         conf.setProperty(prop, list);
         saveTestConfig();
         conf.clear();
         load(conf, testSavePropertiesFile.getAbsolutePath());
         assertEquals(list, conf.getProperty(prop));
     }
 
         @Test
     public void testSlashEscaping() throws ConfigurationException {
         conf.setProperty(PROP_NAME, "http://www.apache.org");
         final StringWriter writer = new StringWriter();
         new FileHandler(conf).save(writer);
         final String s = writer.toString();
         assertTrue(s.contains(PROP_NAME + " = http://www.apache.org"));
     }
 
         @Test
     public void testUnEscapeCharacters() {
         assertEquals("#1 =: me!", conf.getString("test.unescape.characters"));
     }
 
     @Test
     public void testUnescapeJava() {
         assertEquals("test\\,test", PropertiesConfiguration.unescapeJava("test\\,test"));
     }
 
         @Test
     public void testWriteFooterComment() throws ConfigurationException, IOException {
         final String footer = "my footer";
         conf.clear();
         conf.setProperty(PROP_NAME, PROP_VALUE);
         conf.setFooter(footer);
         final StringWriter out = new StringWriter();
         conf.write(out);
         assertEquals(PROP_NAME + " = " + PROP_VALUE + CR + "# " + footer + CR, out.toString());
     }
 }