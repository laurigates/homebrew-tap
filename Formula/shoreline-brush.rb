# Hand-written, unlike the dist-generated formulae here: Brush, the Gaussian splat
# trainer that shoreline-recon's splat stage runs. Homebrew core's `brush` is an
# unrelated shell. Bump both URLs and checksums together with the brush pin in
# laurigates/shore-recon (containers/brush/Containerfile).
class ShorelineBrush < Formula
  desc "Brush Gaussian splat trainer (brush_app), as used by shoreline-recon"
  homepage "https://github.com/ArthurBrussee/brush"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/ArthurBrussee/brush/releases/download/v0.3.0/brush-app-aarch64-apple-darwin.tar.xz"
    sha256 "65b2631398c839be3c1d4d7160fe2326389dec87830aac0710985e6690a1048c"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/ArthurBrussee/brush/releases/download/v0.3.0/brush-app-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "4f0f9a8785d1951c62df26aae247c02c5bba32b00f40b06df4e1c9b867399e20"
  end
  license "Apache-2.0"

  def install
    bin.install "brush_app"
  end

  test do
    assert_match "brush-cli #{version}", shell_output("#{bin}/brush_app --version")
  end
end
