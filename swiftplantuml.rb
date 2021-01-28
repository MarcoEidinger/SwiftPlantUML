class Swiftplantuml < Formula
  desc "Generate UML class diagrams from Swift sources"
  homepage "https://github.com/MarcoEidinger/SwiftPlantUML"
  url "https://github.com/MarcoEidinger/SwiftPlantUML/archive/0.1.0.tar.gz"
  sha256 "ea52dc2a700dd45bca3ed9ce8112e9d9babc21200ab562b23307d1480c901e94"
  license "MIT"

  depends_on xcode: ["12.2", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    system "#{bin}/swiftplantuml", "--help"
  end
end
