class Polarity < Formula
  desc "CLI tool for managing stacked pull requests with AI-powered features"
  homepage "https://polarity.cc"
  url "https://github.com/Polarityinc/polarity-binaries/releases/download/v0.0.5/polarity-macos-v0.0.5.tar.gz"
  sha256 "cdf0d448c7cfb8ccc4dcaa509b96cf01ea23e88556d04a5d59ad0eca57f06af9"
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
        1. Authenticate with Polarity (required for AI features):
           pt auth login
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
