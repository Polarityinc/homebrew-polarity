class Polarity < Formula
  desc "CLI tool for managing stacked pull requests with AI-powered features"
  homepage "https://polarity.dev"
  url "https://github.com/Polarityinc/polarity-binaries/releases/download/v0.0.1/polarity-macos.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "MIT"

  depends_on "git"

  def install
    # Extract and install the binary
    bin.install "charcoal-macos" => "pt"
    
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
           
        2. Initialize a repository:
           pt repo init
           
        3. Create your first stacked branch:
           pt create <branch-name>
      
      For more information, visit: https://docs.polarity.dev
    EOS
  end

  test do
    system "#{bin}/pt", "--version"
    assert_match "polarity", shell_output("#{bin}/pt --help")
  end
end