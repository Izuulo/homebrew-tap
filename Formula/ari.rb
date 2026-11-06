class Ari < Formula
  desc "A zero-token status panel for Claude Code"
  homepage "https://github.com/Izuulo/ari"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Izuulo/ari/releases/download/v0.3.0/ari-cli-aarch64-apple-darwin.tar.xz"
      sha256 "3d51ede6e5df47b6452c3aabed5f3effb00515e95de28fdc520b3f518466cbbf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Izuulo/ari/releases/download/v0.3.0/ari-cli-x86_64-apple-darwin.tar.xz"
      sha256 "86faa69d44ab4c934789896a67f0df06cbb18a0c9565b9ee6abaf748b1813763"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Izuulo/ari/releases/download/v0.3.0/ari-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c7b04231bc59f514977b7b3b745f1aa479c23611d3cfa05f11a9a09017845312"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Izuulo/ari/releases/download/v0.3.0/ari-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "116d7b38acee30eefadfcf44c1c3832cf59f0d7b8534bf9273f04194175c0eb4"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
