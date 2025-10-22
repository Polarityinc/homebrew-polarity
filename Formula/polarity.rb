class Polarity < Formula
  desc "CLI tool for managing stacked pull requests with AI-powered features"
  homepage "https://polarity.cc"
  version "0.0.3"
  license "MIT"

  depends_on "git"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Polarityinc/polarity-binaries/releases/download/v0.0.3/polarity-darwin-amd64"
      sha256 "36471dd2e240d8a037a95a4d4448190f053c3f3184ff51975fdb7094c4136c25"
    else
      url "https://github.com/Polarityinc/polarity-binaries/releases/download/v0.0.3/polarity-darwin-arm64"
      sha256 "7d65bb3860f2bb7616c66c53800dd30ac1453a31ebc0740b92b7008f18df7c57"
    end
  end

  on_linux do
    url "https://github.com/Polarityinc/polarity-binaries/releases/download/v0.0.3/polarity-linux-amd64"
    sha256 "6b1ebbfcdca1b49a22a378b95dd30de770d6303c00a5453e181feeef88be653e"
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
