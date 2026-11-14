class Klatch < Formula
  desc "Substrate for agent rooms: claims, asks, a board and a durable encrypted log"
  homepage "https://github.com/hslee16/klatch"
  version "0.1.0-dev.1"
  license "MIT"

  # An early pre-release: no outside security review, not for sensitive data.
  # Each archive holds the binary, LICENSE and THIRD-PARTY-LICENSES.txt, and is built by the release workflow of
  # hslee16/klatch (verify with `gh attestation verify`; see SECURITY.md in that repository).
  on_macos do
    on_arm do
      url "https://github.com/hslee16/klatch/releases/download/v0.1.0.dev1/klatch-0.1.0-dev.1-aarch64-apple-darwin.tar.gz"
      sha256 "23fba029f7f0d7bf3863d0589f3feaf3a72f47f6e3767635c8f7a65db523985a"
    end
    on_intel do
      url "https://github.com/hslee16/klatch/releases/download/v0.1.0.dev1/klatch-0.1.0-dev.1-x86_64-apple-darwin.tar.gz"
      sha256 "436d2acdb40564a719b319280a012d763c16fe48f8f4c8bf2b943b6340b3c2de"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/hslee16/klatch/releases/download/v0.1.0.dev1/klatch-0.1.0-dev.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2cf06d9cb4a913b47af0b099098e5b10fbb6fee4325e545be5d588a1a26f22d8"
    end
    on_intel do
      url "https://github.com/hslee16/klatch/releases/download/v0.1.0.dev1/klatch-0.1.0-dev.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "43330d673b876b78f47a5b2862fb1c47e83407e700672909dc870eb67f1d9bb2"
    end
  end

  def install
    bin.install "klatch"
    doc.install "LICENSE", "THIRD-PARTY-LICENSES.txt"
  end

  test do
    assert_match "klatch #{version}", shell_output("#{bin}/klatch --version")
    # a whole round trip in a throwaway store: the key goes in a directory under the test home
    ENV["KLATCH_HOME"] = testpath/"home"
    ENV["KLATCH_KEY_DIR"] = testpath/"keys"
    ENV["KLATCH_NAME"] = "brew-test"
    system bin/"klatch", "join", "lobby"
    system bin/"klatch", "post", "lobby", "hello from brew test"
    # a member never sees its own posts, so read as a second member
    ENV["KLATCH_NAME"] = "brew-reader"
    system bin/"klatch", "join", "lobby"
    assert_match "hello from brew test", shell_output("#{bin}/klatch read lobby --peek")
  end
end
