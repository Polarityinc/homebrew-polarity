class Polarity < Formula
  desc "CLI tool for managing stacked pull requests with AI-powered features"
  homepage "https://polarity.cc"
  url "https://github.com/Polarityinc/polarity-binaries/releases/download/v0.0.12/polarity-macos-v0.0.12.tar.gz"
  sha256 "765c3edb55d39eefc15ac76159d38d8103a55caf46716c8e0ba7a0c21c8fcd5a"
  license "MIT"

  depends_on "git"

  def install
    # Extract and install the binary
    bin.install "polarity-macos" => "pt"
    
    # Make sure binary is executable
    chmod 0755, bin/"pt"
  end

  def post_install
    # Create config directory
    (var/"polarity").mkpath
  end

  def caveats
    <<~EOS
      Polarity CLI has been installed as 'pt'
      
      To get started:
        1. Authenticate with Polarity:
           pt auth
           
        2. Create a branch:
           pt create --ai
           
        3. Submit your stack:
           pt submit --stack --ai
      
      For more information, visit: https://docs.polarity.cc
    EOS
  end

  test do
    system "#{bin}/pt", "--version"
    assert_match "polarity", shell_output("#{bin}/pt --help")
  end
end
