class I686W64Mingw32Binutils < Formula
  desc "Binutils for minimalist GNU for Windows."
  homepage "https://mingw-w64.org"
  url "https://ftp.gnu.org/gnu/binutils/binutils-2.29.tar.gz"
  mirror "https://ftpmirror.gnu.org/binutils/binutils-2.29.tar.gz"
  sha256 "172e8c89472cf52712fd23a9f14e9bca6182727fb45b0f8f482652a83d5a11b4"

  depends_on "gcc" => :build

  conflicts_with "mingw-w64", :because => "homebrew-core has mingw-w64 formula"

  def install
    target_arch = "i686-w64-mingw32"
    args = %W[
      CC=gcc-7
      CXX=g++-7
      CPP=cpp-7
      LD=gcc-7
      --target=#{target_arch}
      --disable-werror
      --disable-multilib
      --prefix=#{libexec}
    ]

    system "./configure", *args
    system "make"
    system "make", "install-strip"

    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  def caveats; <<-EOS.undent
    All in one minge-w64 formula is merged in Homebrew-core.
    That formula uses bottle mechanism.

    Please consider to migrate and use `mingw-w64' formula.
    This formula will continue to maintain for compatibility,
    but users should move to use homebrew-core formula.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/i686-w64-mingw32-ld --version")
  end
end
