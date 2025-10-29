class Polarity < Formula
  desc "CLI tool for managing stacked pull requests with AI-powered features"
  homepage "https://polarity.cc"
  version "0.0.4"
  license "MIT"

  depends_on "git"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Polarityinc/polarity-binaries/releases/download/0.0.5/polarity-darwin-amd64"
      sha256 "b8d8f6e990365780e9e01a57b352fca1f2e1189a1062745f8cab3307580c9da3"
    else
      url "https://github.com/Polarityinc/polarity-binaries/releases/download/0.0.5/polarity-darwin-arm64"
      sha256 "885aa2e7d17f89d8e42276d56012a0226141d9d30e1f2f4ded78a560b074e42c"
    end
  end

  on_linux do
    url "https://github.com/Polarityinc/polarity-binaries/releases/download/0.0.5/polarity-linux-amd64"
    sha256 "84bdd2c8bc8887a59843c6ba32d8b9edb0ca0d4cedb1a977aef1aefacdd517c8"
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
