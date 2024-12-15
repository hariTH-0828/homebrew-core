class Commitlint < Formula
  desc "Lint commit messages according to a commit convention"
  homepage "https://commitlint.js.org/#/"
  url "https://registry.npmjs.org/commitlint/-/commitlint-19.6.1.tgz"
  sha256 "b2a8ce62393c1994c64cfd37334af209a14b1e00b6ef85e1d07413b4dc3576b2"
  license "MIT"
  head "https://github.com/conventional-changelog/commitlint.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c570d99279f32d2479e720a9962d2c63ae4dacfcb5cdee049a834c62da234c6e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c570d99279f32d2479e720a9962d2c63ae4dacfcb5cdee049a834c62da234c6e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c570d99279f32d2479e720a9962d2c63ae4dacfcb5cdee049a834c62da234c6e"
    sha256 cellar: :any_skip_relocation, sonoma:        "e90f34ebb3833485e699a5390c8a7e7f0e5fa6b06b6fc292fea5c8e8b4ac561a"
    sha256 cellar: :any_skip_relocation, ventura:       "e90f34ebb3833485e699a5390c8a7e7f0e5fa6b06b6fc292fea5c8e8b4ac561a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c570d99279f32d2479e720a9962d2c63ae4dacfcb5cdee049a834c62da234c6e"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"commitlint.config.js").write <<~JS
      module.exports = {
          rules: {
            'type-enum': [2, 'always', ['foo']],
          },
        };
    JS
    assert_match version.to_s, shell_output("#{bin}/commitlint --version")
    assert_empty pipe_output(bin/"commitlint", "foo: message")
  end
end
