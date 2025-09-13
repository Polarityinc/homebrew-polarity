class Polarity < Formula
  desc "CLI tool for managing stacked pull requests with AI-powered features"
  homepage "https://polarity.dev"
  url "https://github.com/Polarityinc/Polarity-CLI/archive/v0.0.1.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "MIT"

  depends_on "node" => :build
  depends_on "yarn" => :build
  depends_on "git"

  def install
    system "yarn", "install", "--frozen-lockfile"
    system "yarn", "build"
    
    # Install the CLI
    libexec.install Dir["apps/cli/dist/*"]
    libexec.install "apps/cli/package.json"
    
    # Create wrapper script
    (bin/"pt").write <<~EOS
      #!/bin/bash
      export NODE_ENV="production"
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/dist/src/index.js" "$@"
    EOS
    
    # Install shell completions
    bash_completion.install "completions/pt.bash" => "pt"
    zsh_completion.install "completions/pt.zsh" => "_pt"
    fish_completion.install "completions/pt.fish"
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