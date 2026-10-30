class ShorelineRecon < Formula
  desc "Water-aware photogrammetry and Gaussian splatting for shoreline structures"
  homepage "https://github.com/laurigates/shore-recon"
  version "0.5.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/laurigates/shore-recon/releases/download/v0.5.0/shoreline-recon-aarch64-apple-darwin.tar.xz"
    sha256 "0f51328eb64496d8f140ef70107d0c84182b1ad84815da3595c5bc246649aba8"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/laurigates/shore-recon/releases/download/v0.5.0/shoreline-recon-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "8079d027a065f45246b481899dcb6cc8833f733a40290d2cafc03895a6f65255"
  end
  license "MIT"
  depends_on "colmap"
  depends_on "ffmpeg"
  depends_on "laurigates/tap/shoreline-brush"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-unknown-linux-gnu": {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "shoreline-recon"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "shoreline-recon"
    end

    install_binary_aliases!

    generate_completions_from_executable(bin/"shoreline-recon", "completions")

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
