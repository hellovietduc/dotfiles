#!/usr/bin/env bash

# Exit the script on error
set -e

echo "Prerequisites:"
echo "- Xcode command-line tools"
read -r -n 1 -p "You wanna install? (y/n) " response
if [ "$response" = "n" ]; then
  echo "Aborted! Please run the remaining steps yourself."
  exit 0
fi
xcode-select --install

echo "- SSH keys to GitHub. See https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent"
read -r -n 1 -p "Done? " response

echo "Install homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

read -r -n 1 -p "You wanna install brew packages and casks? (y/n) " response
if [ "$response" = "n" ]; then
  echo "Aborted! Please run the remaining steps yourself."
  exit 0
fi
brew install asdf \
  bat \
  curl \
  eza \
  fd \
  fzf \
  gh \
  git \
  git-delta \
  jq \
  neovim \
  ripgrep \
  stow \
  tmux \
  tmuxinator \
  tldr \
  wget \
  yq \
  zoxide \
  joshmedeski/sesh/sesh
brew install --cask 1password \
  1password-cli \
  alfred \
  arc \
  android-studio \
  claude-code \
  cursor \
  figma \
  front \
  google-cloud-sdk \
  iina \
  karabiner-elements \
  linear-linear \
  logi-options-plus \
  lunar \
  microsoft-teams \
  neovide \
  obsidian \
  onlyoffice \
  openkey \
  orbstack \
  rectangle \
  setapp \
  syncthing-app \
  spotify \
  wezterm \
  zen \
  zoom

echo "Installing fonts..."
brew tap homebrew/cask-fonts
brew install --cask font-monaspace
brew install --cask font-monaspace-nerd-font
brew install --cask font-jetbrains-mono
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-symbols-only-nerd-font

echo "Installing Tmux Plugin Manager..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Install these apps yourself:"
echo "- Gray: https://github.com/zenangst/Gray"
echo "- Hyperion: https://github.com/hyperion-project/hyperion.ng"
echo "- Dash from Setapp"
echo "- CleanShot X from Setapp"
echo "- PixelSnap from Setapp"
echo "- Xcode from App Store"
echo "- Things 3 from App Store"
read -r -n 1 -p "Done? " response

echo "Add asdf plugins"
while IFS= read -r line; do
  name="$(echo $line | cut -d " " -f1)"
  asdf plugin add "$name"
  echo "Added plugin: $name"
done <"$HOME/.tool-versions"

echo "Install all asdf packages listed in ~/.tool-versions"
NODEJS_CHECK_SIGNATURES=no asdf install

echo "Set asdf package versions globally"
while IFS= read -r line; do
  name="$(echo $line | cut -d " " -f1)"
  version="$(echo $line | cut -d " " -f2)"
  asdf set --home "$name" "$version"
  echo "Set package globally: $name $version"
done <"$HOME/.tool-versions"

echo "Reshim asdf packages"
# Should always be the last
while IFS= read -r line; do
  name="$(echo $line | cut -d " " -f1)"
  asdf reshim "$name"
  echo "Reshimmed: $name $version"
done <"$HOME/.tool-versions"

echo "Install crontab"
crontab "$HOME/crontab/cron"

echo "Install zsh4humans"
if command -v curl >/dev/null 2>&1; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
else
  sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
fi

echo "Install HyperCapslock"
git clone git@github.com:hellovietduc/HyperCapslock.git
cd HyperCapslock
yarn install
yarn hyper
cd ~

read -r -n 1 -p "Wanna change some system preferences? (y/n) " response
if [ "$response" = "y" ]; then
  # Source: https://macos-defaults.com/

  # Close any open System Preferences panes, to prevent them from overriding
  # settings we’re about to change
  osascript -e 'tell application "System Preferences" to quit'

  # Ask for the administrator password upfront
  sudo -v

  # Keep-alive: update existing `sudo` time stamp until `.macos` has finished
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done 2>/dev/null &

  ###########
  # GENERAL #
  ###########

  # Set computer name (as done via System Preferences → Sharing)
  sudo scutil --set ComputerName "duc-mbp"
  sudo scutil --set HostName "duc-mbp"
  sudo scutil --set LocalHostName "duc-mbp"
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "duc-mbp"

  # Disable the sound effects on boot
  sudo nvram SystemAudioVolume=" "

  # Always show scrollbars
  defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

  # Disable automatic capitalization as it’s annoying when typing code
  defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

  # Disable smart dashes as they’re annoying when typing code
  # defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

  # Disable automatic period substitution as it’s annoying when typing code
  defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

  # Disable smart quotes as they’re annoying when typing code
  # defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

  # Disable auto-correct
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

  # Disable spell check
  defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool false

  # Disable press and hold to bring up the accents menu
  defaults write NSGlobalDomain "ApplePressAndHoldEnabled" -bool "false"

  # Trackpad: enable tap to click for this user and for the login screen
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

  ##########
  # FINDER #
  ##########

  # Finder: show all filename extensions
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  # Finder: show path bar
  defaults write com.apple.finder ShowPathbar -bool true

  # Keep folders on top when sorting by name
  defaults write com.apple.finder _FXSortFoldersFirst -bool true

  # When performing a search, search the current folder by default
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

  # Use column view in all Finder windows by default
  defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

  ########
  # DOCK #
  ########

  # Automatically hide and show the Dock
  defaults write com.apple.dock autohide -bool true

  # Reduce autohide time and delay
  defaults write com.apple.dock "autohide-delay" -float "0.1"
  defaults write com.apple.dock "autohide-time-modifier" -float "0.1"

  ##########
  # SAFARI #
  ##########

  # Privacy: don’t send search queries to Apple
  defaults write com.apple.Safari UniversalSearchEnabled -bool false
  defaults write com.apple.Safari SuppressSearchSuggestions -bool true

  # Press Tab to highlight each item on a web page
  defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
  defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

  # Show the full URL in the address bar (note: this still hides the scheme)
  defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

  # Set Safari’s home page to `about:blank` for faster loading
  defaults write com.apple.Safari HomePage -string "about:blank"

  # Prevent Safari from opening ‘safe’ files automatically after downloading
  defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

  # Enable the Develop menu and the Web Inspector in Safari
  defaults write com.apple.Safari IncludeDevelopMenu -bool true
  defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
  defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

  # Disable AutoFill
  defaults write com.apple.Safari AutoFillFromAddressBook -bool false
  defaults write com.apple.Safari AutoFillPasswords -bool false
  defaults write com.apple.Safari AutoFillCreditCardData -bool false
  defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

  # Kill affected applications
  for app in "cfprefsd" \
    "Dock" \
    "Finder" \
    "Safari"; do
    killall "${app}" &>/dev/null
  done
  echo "Done. Note that some of these changes require a logout/restart to take effect."
fi

echo "Friendly reminder: These are the things you'll need to do yourself:"
read -r -n 1 -p "- Activate Alfred Powerpack. Done? " response
read -r -n 1 -p "- Extract this file to restore Alfred preferences: $HOME/dotfiles/.config/_alfred/Alfred.alfredpreferences.tar.gz. Done? " response
read -r -n 1 -p "- Activate Lunar Pro. Done? " response
read -r -n 1 -p "- Login to your browser of choice to sync the settings. Done? " response
read -r -n 1 -p "- Login to GitHub CLI: gh auth login. Done? " response
read -r -n 1 -p "- Login to Google Cloud SDK: gcloud auth login. Done? " response

echo "All Done! All Good!"
