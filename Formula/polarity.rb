class Polarity < Formula
  desc "CLI tool for managing stacked pull requests with AI-powered features"
  homepage "https://polarity.cc"
  version "nightly-5-gc2fb684b"
  license "MIT"

  depends_on "git"

  on_macos do
    if Hardware::CPU.intel?
      url "https://raw.githubusercontent.com/Polarityinc/polarity-binaries/main/paragon-darwin-amd64"
      sha256 "063fd80d1bb6c158a52b2ee9b7541f2056e76bd6849baa96f5345f725c813019"
    else
      url "https://raw.githubusercontent.com/Polarityinc/polarity-binaries/main/paragon-darwin-arm64"
      sha256 "873ccfb13517081a46e6a94a1bb468339534469b7eac7db3074ab932842e2a19"
    end
  end

  on_linux do
    url "https://raw.githubusercontent.com/Polarityinc/polarity-binaries/main/paragon-linux-amd64"
    sha256 "00b5b18681b3c0c88e276f74ab248c05229abc6d73c66a7915e96c5f90368769"
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
