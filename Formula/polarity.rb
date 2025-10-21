class Polarity < Formula
  desc "CLI tool for managing stacked pull requests with AI-powered features"
  homepage "https://polarity.cc"
  version "nightly-5-gc2fb684b"
  license "MIT"

  depends_on "git"

  on_macos do
    if Hardware::CPU.intel?
      url "https://raw.githubusercontent.com/Polarityinc/polarity-binaries/main/paragon-darwin-amd64"
      sha256 "72cf5d596be4c7d00aa5442c5ff8df14b2065625269356b6411f26627d47448f"
    else
      url "https://raw.githubusercontent.com/Polarityinc/polarity-binaries/main/paragon-darwin-arm64"
      sha256 "2fdd9e8df63dad91cf63ede8a93a06b0cd5adb6dbf5f96349ac0871e44a6dd2f"
    end
  end

  on_linux do
    url "https://raw.githubusercontent.com/Polarityinc/polarity-binaries/main/paragon-linux-amd64"
    sha256 "9909989e07112b83546e43010acbcdad25f0c205ed7fe8f14dfc7c80e6a1636d"
  end

  def install
    # Install the binary as 'paragon' and create 'pt' symlink
    bin.install Dir["paragon-*"].first => "paragon"
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
