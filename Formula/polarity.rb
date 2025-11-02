class Polarity < Formula
  desc "CLI tool for managing stacked pull requests with AI-powered features"
  homepage "https://polarity.cc"
  version "0.0.6"
  license "MIT"

  depends_on "git"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/Polarityinc/polarity-binaries/releases/download/0.0.6/polarity-darwin-amd64"
      sha256 "6e3fcc6e5cb9bf9e9a58ff6c3b586c26c50f7e12af792f7d61a4e6c9d4cef786"
    else
      url "https://github.com/Polarityinc/polarity-binaries/releases/download/0.0.6/polarity-darwin-arm64"
      sha256 "5042d70e0622724e399202a65fd4fb0e9a573d5759f631a1d4dd1daadcac7ca1"
    end
  end

  on_linux do
    url "https://github.com/Polarityinc/polarity-binaries/releases/download/0.0.6/polarity-linux-amd64"
    sha256 "c7b9c46c4fbf5dbcfc562b121dc96860f22acf31ef856f68f1a39c24f8e3036d"
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
