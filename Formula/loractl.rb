class Loractl < Formula
  desc "loractl — a terminal-native LoRA trainer CLI (CLI-first; a GUI can be layered on the same core later)."
  homepage "https://github.com/laurigates/loractl"
  version "0.24.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/laurigates/loractl/releases/download/v0.24.0/loractl-cli-aarch64-apple-darwin.tar.xz"
    sha256 "53a5cd615f37e3c90a86b9efb5d4e70dfc892a1cb173cc2ad15d6c6957b3c73f"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/laurigates/loractl/releases/download/v0.24.0/loractl-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "26e1117ace036e31686e6043292e08cb008c5a96fe76a53b8326fb929dc365e1"
  end
  license "MIT"

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
      bin.install "loractl"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "loractl"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
