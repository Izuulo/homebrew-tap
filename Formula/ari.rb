class Ari < Formula
  desc "A zero-token status panel for Claude Code"
  homepage "https://github.com/Izuulo/ari"
  version "0.3.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Izuulo/ari/releases/download/v0.3.9/ari-cli-aarch64-apple-darwin.tar.xz"
      sha256 "28c91636b25106e97bd01873bd2c473f632f630832224777fdff3ad3dffe1d0b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Izuulo/ari/releases/download/v0.3.9/ari-cli-x86_64-apple-darwin.tar.xz"
      sha256 "beaa0781a97da6f6caf0bf0b0a7b200b34b460f76388f658883b2c6b6cb6a4ae"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Izuulo/ari/releases/download/v0.3.9/ari-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a42dac54996e01a1e16d412fa1bf8975fad7ce12b2b6608230b0e7d58b6a6475"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Izuulo/ari/releases/download/v0.3.9/ari-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8a238ce3e7c49d3b71bd77b3e7ee20d5760206034103f5a300dfef6e30422b39"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
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
      bin.install "ari"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ari"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ari"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ari"
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
