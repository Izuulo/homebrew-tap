class Ari < Formula
  desc "A zero-token status panel for Claude Code"
  homepage "https://github.com/Izuulo/ari"
  version "0.3.12"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Izuulo/ari/releases/download/v0.3.12/ari-cli-aarch64-apple-darwin.tar.xz"
      sha256 "b80e2c7be9c1fcc272fc2952713b86835a34d7d43f0986520e66d017000dd21c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Izuulo/ari/releases/download/v0.3.12/ari-cli-x86_64-apple-darwin.tar.xz"
      sha256 "69a01a464c5b49530dd25e7d03be668ca753923b064943ebf248d769ee1d9591"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Izuulo/ari/releases/download/v0.3.12/ari-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4c3d9657896c617ce8fa3b779d696ecf67c37bef15e3691c8c1d310061b1bc4e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Izuulo/ari/releases/download/v0.3.12/ari-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f637b50d2ec5e56aa698178e38ac565f982ae002291a54a4cb278c326bc70a6a"
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
