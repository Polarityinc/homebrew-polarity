class Polarity < Formula
  desc "CLI tool for managing stacked pull requests with AI-powered features"
  homepage "https://polarity.cc"
  version "0.0.7"
  license "MIT"

  depends_on "git"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Polarityinc/polarity-binaries/releases/download/0.0.7/polarity-darwin-amd64"
      sha256 "7c67d23c8e3785ff53ea4279f2f44fe8b7d4c275d6879aa3f0e934c0cb95fbb4"
    else
      url "https://github.com/Polarityinc/polarity-binaries/releases/download/0.0.7/polarity-darwin-arm64"
      sha256 "582f2ceed7fb2d9485fc168b7f0e5850fa3098449c5ca17dec8341ba5d654957"
    end
  end

  on_linux do
    url "https://github.com/Polarityinc/polarity-binaries/releases/download/0.0.7/polarity-linux-amd64"
    sha256 "ad51f8ee29eee2756177828b00f6eda1176b756aed03b0f031cdeb027f88008a"
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
