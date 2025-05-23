class Texi2html < Formula
  desc "Convert TeXinfo files to HTML"
  homepage "https://www.nongnu.org/texi2html/"
  url "https://download.savannah.gnu.org/releases/texi2html/texi2html-5.0.tar.gz"
  sha256 "e60edd2a9b8399ca615c6e81e06fa61946ba2f2406c76cd63eb829c91d3a3d7d"
  license "GPL-2.0-or-later"

  livecheck do
    skip "No longer developed or maintained"
  end

  bottle do
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "f1edd0597b8dbd1dd4150ebf2cdfd1e85f0b686e68216684cc38b10e19295a03"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "d97147d3fb05920663a4113bcd9a82420c1cdb15593a46d36d5f0bf2e0f023bc"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "7114d60ab173de6a576098ba484cb226ad2a65c3f6ef2f668f8c5c2d0676fc2f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7114d60ab173de6a576098ba484cb226ad2a65c3f6ef2f668f8c5c2d0676fc2f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "03feaacb6b615ca2dda676bf5fe4f9551c488a851ccd1e89b12d257a5c7d932b"
    sha256 cellar: :any_skip_relocation, sonoma:         "620ae7ace83d9220659e8b81cc9706e812e67f737952dec8a81895d4a289dfaa"
    sha256 cellar: :any_skip_relocation, ventura:        "f1d5a70912d5b39d5da118a19474ec509a34a903cefb2c00ff403569325fe0ae"
    sha256 cellar: :any_skip_relocation, monterey:       "f1d5a70912d5b39d5da118a19474ec509a34a903cefb2c00ff403569325fe0ae"
    sha256 cellar: :any_skip_relocation, big_sur:        "4ad9c71802c3258a3c0c7ff8800ddd70cc230ddfecc095080d0144ba153bc2dc"
    sha256 cellar: :any_skip_relocation, catalina:       "10f6d76de400799fb21dc900a2344ef444d43658dd502f0c040ad7c0a4bf0fbb"
    sha256 cellar: :any_skip_relocation, mojave:         "10f6d76de400799fb21dc900a2344ef444d43658dd502f0c040ad7c0a4bf0fbb"
    sha256 cellar: :any_skip_relocation, high_sierra:    "10f6d76de400799fb21dc900a2344ef444d43658dd502f0c040ad7c0a4bf0fbb"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "fc03b703a8cb858fbaf0fcba903ce5b59399cc83fad97e953eb15e4392ac11df"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "13d9124964d4e6a9c99ca57e763e34e40397871bf94b4064cddb5262bf501f47"
  end

  depends_on "gettext"

  def install
    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?

    system "./configure", "--mandir=#{man}", "--infodir=#{info}", *args, *std_configure_args
    chmod 0755, "./install-sh"
    system "make", "install"
  end

  test do
    (testpath/"test.texinfo").write <<~EOS
      @ifnottex
      @node Top
      @top Hello World!
      @end ifnottex
      @bye
    EOS
    system bin/"texi2html", "test.texinfo"
    assert_match "Hello World!", File.read("test.html")
  end
end
