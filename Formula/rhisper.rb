class Rhisper < Formula
  desc "Dictation at cursor for Linux and macOS"
  homepage "https://github.com/lv10/rhisper"
  url "https://github.com/lv10/rhisper/archive/refs/tags/v0.2.6.tar.gz"
  sha256 "1537c88bb5fa83ed4a8a307790ce8f552e1d7055c62c2bc5c1a01fa8f4f7a8c4"
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
