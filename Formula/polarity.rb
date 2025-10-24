class Polarity < Formula
  desc "CLI tool for managing stacked pull requests with AI-powered features"
  homepage "https://polarity.cc"
  version "0.0.4"
  license "MIT"

  depends_on "git"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Polarityinc/polarity-binaries/releases/download/0.0.4/polarity-darwin-amd64"
      sha256 "3818c47032409faa9569845d6dbc49d725ebcaa542ae2830b3e3ab6b64530c7b"
    else
      url "https://github.com/Polarityinc/polarity-binaries/releases/download/0.0.4/polarity-darwin-arm64"
      sha256 "957eeb86510b48ba77acd4e08a096802dbe93621feacbf53709e05e761488c0b"
    end
  end

  on_linux do
    url "https://github.com/Polarityinc/polarity-binaries/releases/download/0.0.4/polarity-linux-amd64"
    sha256 "ed8b3e446242c85dc8735cf846686e41c1a1e2c86fd6f151659d53090c62fdba"
  end

  def install
    # Install the binary as 'paragon' and create 'pt' symlink
    bin.install Dir["polarity-*"].first => "paragon"
    bin.install_symlink "paragon" => "pt"
    
    # Make sure binary is executable
    chmod 0755, bin/"paragon"
  end

  def post_install
    # Create config directory
    (var/"polarity").mkpath
  end

  def caveats
    <<~EOS
      Paragon has been installed as 'paragon' with 'pt' symlink
      
      To get started:
        1. Authenticate with Polarity:
           paragon auth login
           
        2. Start a Paragon Deep Review:
           Open the TUI and press ctrl+p → Paragon Deep Review
      
      For more information, visit: https://docs.polarity.cc
    EOS
  end

  test do
    system "#{bin}/paragon", "--version"
    assert_match "paragon", shell_output("#{bin}/paragon --help")
  end
end
