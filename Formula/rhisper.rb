class Rhisper < Formula
  desc "Dictation at cursor for Linux and macOS"
  homepage "https://github.com/lv10/rhisper"
  url "https://github.com/lv10/rhisper/archive/refs/tags/v0.2.5.tar.gz"
  sha256 "bb2267d3445c8b2fc232d080c09521d67daed68054c2a104b6cbec6dcbe8c198"
  license "MIT"

  depends_on "rust" => :build
  depends_on "sox"
  depends_on "ffmpeg"

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
    # rhispertool is a Linux-only uinput daemon/client (see
    # src/bin/rhispertool.rs's non-Linux stub) - don't ship the stub binary.
    (bin/"rhispertool").delete if (bin/"rhispertool").exist?
  end

  test do
    system "#{bin}/rhisper", "--config"
  end
end
