cask "asmgr-desktop" do
  version "1.1.5"
  sha256 "f17b4a03181b7bdb063d90d204ccd014132034d442dd40842ebea48e670b1cdb"

  url "https://github.com/izll/agent-session-manager-desktop/releases/download/v#{version}/asmgr-desktop_#{version}_darwin_arm64.tar.gz",
      verified: "github.com/izll/agent-session-manager-desktop/"
  name "Agent Session Manager"
  desc "Desktop app for managing multiple AI coding assistant sessions"
  homepage "https://github.com/izll/agent-session-manager-desktop"

  # Apple Silicon only: the release builds darwin/arm64. Without this an Intel
  # Mac would download an executable it cannot run and fail at launch instead of
  # at install, which is the harder failure to understand.
  depends_on arch: :arm64
  # Sonoma, not the Go toolchain floor: the bundled PortAudio dylib is built
  # for the release runner, and the app declares that maximum in its plist.
  depends_on macos: :sonoma

  # The sessions themselves run in tmux; without it the app starts and can do
  # nothing. Homebrew installs it as part of the cask rather than leaving the
  # first launch to fail.
  depends_on formula: "tmux"

  app "Agent Session Manager.app"

  zap trash: [
    "~/.config/agent-session-manager-desktop",
    "~/Library/Saved Application State/com.wails.asmgr-desktop.savedState",
  ]
end
