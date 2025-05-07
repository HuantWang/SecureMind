public function setUrl(string $url): static
    {
        $url = trim($url);

        $unsupportedProtocols = ['file://', 'file:/', 'file:\\', 'file:\\\\'];

        foreach ($unsupportedProtocols as $unsupportedProtocol) {
            if (str_starts_with(strtolower($url), $unsupportedProtocol)) {
                throw FileUrlNotAllowed::make();
            }
        }

        $this->url = $url;
        $this->html = '';

        return $this;
    }

    it('will not allow a file url', function (string $url) {
    Browsershot::url($url);
})->throws(FileUrlNotAllowed::class)->with([
    'file://test',
    'file:/test',
    'file:\test',
    'file:\\test',
]);