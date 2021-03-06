class Yaep < Formula
  desc "Yet Another Earley Parser"
  homepage "https://github.com/vnmakarov/yaep"
  url "https://github.com/sanssecours/yaep/archive/1.0.tar.gz"
  sha256 "c383b33ca5ab636b44cd2c6e231fb2ce11809a6e5408602575df18999c8b9af8"

  bottle do
    root_url("https://github.com/sanssecours/homebrew-yaep/releases/" \
             "download/1.0")
    sha256 "06537e17dc17b607235a2f88f4b60b12139097ede034010ca96361cdf7742c9c" \
           => :mojave
  end

  depends_on "cmake" => :build

  def install
    ENV.deparallelize
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <yaep/yaep.h>
      int main() {
        yaep parser;
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++11", "-L#{lib}", "-lyaep++", "-o", "test"
    system "./test"
  end
end
