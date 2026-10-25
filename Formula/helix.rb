class Helix < Formula
  desc "Post-modern modal text editor, with configurable keymap labels"
  homepage "https://github.com/bewa1t/helix"
  url "https://github.com/bewa1t/helix/releases/download/25.07.1-custom-labels-patch/helix-25.07.1-custom-labels-patch-aarch64-macos.tar.gz"
  version "25.07.1-custom-labels-patch"
  sha256 "c84e361ee4344c7429f8163a24e93ce0e0b073c66759be8b30d5b4a577982418"
  license "MPL-2.0"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  conflicts_with "evil-helix", because: "both install `hx` binaries"
  conflicts_with "hex", because: "both install `hx` binaries"

  def install
    bin.install "hx"
    libexec.install "runtime"
    bin.env_script_all_files libexec/"bin", HELIX_RUNTIME: "${HELIX_RUNTIME:-#{libexec}/runtime}"

    bash_completion.install "contrib/completion/hx.bash" => "hx"
    fish_completion.install "contrib/completion/hx.fish"
    zsh_completion.install "contrib/completion/hx.zsh" => "_hx"
  end

  test do
    assert_match "post-modern text editor", shell_output("#{bin}/hx --help")
    assert_match "✓", shell_output("#{bin}/hx --health")
  end
end
