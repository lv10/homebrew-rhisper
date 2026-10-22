class Rhisper < Formula
  desc "Dictation at cursor for Linux and macOS"
  homepage "https://github.com/lv10/rhisper"
  url "https://github.com/lv10/rhisper/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "aaefef95e812c8be5c97b3d28733fc62f5a16af7da2611fde797559aea0877df"
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
