class Polarity < Formula
  desc "CLI tool for managing stacked pull requests with AI-powered features"
  homepage "https://polarity.cc"
  version "0.0.4"
  license "MIT"

  depends_on "git"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Polarityinc/polarity-binaries/releases/download/0.0.4/polarity-darwin-amd64"
      sha256 "316547a20e94eaf5ca540a5875f375b51af5f2bdb40dc93bdb2a838c6f636188"
    else
      url "https://github.com/Polarityinc/polarity-binaries/releases/download/0.0.4/polarity-darwin-arm64"
      sha256 "97641deec90053d7d85de140f95ef3771cada3852ee2a5b4fb636ddc66d8aefd"
    end
  end

  on_linux do
    url "https://github.com/Polarityinc/polarity-binaries/releases/download/0.0.4/polarity-linux-amd64"
    sha256 "d8fd19be290f639c5036377a9aae11bbb0e36a38f357573485179bb3abba3ada"
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
