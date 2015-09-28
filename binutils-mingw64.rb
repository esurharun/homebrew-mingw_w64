require "formula"

class BinutilsMingw64 < Formula
  homepage "https://mingw-w64.sourceforge.net/"
  url "http://ftpmirror.gnu.org/binutils/binutils-2.25.1.tar.bz2"
  sha256 "b5b14added7d78a8d1ca70b5cb75fef57ce2197264f4f5835326b0df22ac9f22"

  depends_on "gcc49" => :build

  def install
    install_prefix="#{HOMEBREW_PREFIX}/mingw"
    args = %W[
      CC=gcc-4.9
      CXX=g++-4.9
      CPP=cpp-4.9
      LD=gcc-4.9
      --target=x86_64-w64-mingw32
      --disable-werror
      --disable-multilib
      --enable-64-bit-bfd
      --prefix=#{install_prefix}
      --with-sysroot=#{install_prefix}
    ]

    system "./configure", *args
    system "make"
    system "make install-strip"
  end

end
