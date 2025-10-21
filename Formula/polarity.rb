class Polarity < Formula
  desc "CLI tool for managing stacked pull requests with AI-powered features"
  homepage "https://polarity.cc"
  version "nightly-5-gc2fb684b"
  license "MIT"

  depends_on "git"

  on_macos do
    if Hardware::CPU.intel?
      url "https://raw.githubusercontent.com/Polarityinc/polarity-binaries/main/paragon-darwin-amd64"
      sha256 "72d280e1e6385f34cda3ce845204eb89671c59a5a0cb43378b49aa76ac8c9e19"
    else
      url "https://raw.githubusercontent.com/Polarityinc/polarity-binaries/main/paragon-darwin-arm64"
      sha256 "e9de6f6344bc0688584d909452278746745290b5f0a2fd6c5075e7df85b40551"
    end
  end

  on_linux do
    url "https://raw.githubusercontent.com/Polarityinc/polarity-binaries/main/paragon-linux-amd64"
    sha256 "38e78894581ef7901d0491f4b24854d3b3db421423d6556111adf89ff89cad2f"
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
