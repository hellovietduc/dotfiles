# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files sourced from it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

# Periodic auto-update on Zsh startup: 'ask' or 'no'.
# You can manually run `z4h update` to update everything.
zstyle ':z4h:' auto-update      'no'

# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey' keyboard  'mac'

# Start tmux if it's installed.
zstyle ':z4h:' start-tmux       yes

# Keep prompt at top in tmux.
zstyle ':z4h:' prompt-at-bottom no

# Mark up shell's output with semantic information.
zstyle ':z4h:' term-shell-integration 'yes'

# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char 'accept'

# Recursively traverse directories when TAB-completing files.
zstyle ':z4h:fzf-complete' recurse-dirs 'yes'

# Use Tab key to accept the selection.
zstyle ':z4h:fzf-complete' fzf-bindings tab:repeat
zstyle ':z4h:fzf-dir-history' fzf-bindings tab:repeat

# Enable direnv to automatically source .envrc files.
zstyle ':z4h:direnv'         enable 'no'

# Clone additional Git repositories from GitHub.
#
# This doesn't do anything apart from cloning the repository and keeping it
# up-to-date. Cloned files can be used after `z4h init`.
# z4h install mattmc3/zsh-safe-rm || return

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# Export environment variables.
export EDITOR=nvim
export GPG_TTY=$TTY

# Tell apps that like to store config files in ~/Library/Application Support
# to use ~/.config instead.
export XDG_CONFIG_HOME="$HOME/.config"

export HOMEBREW_NO_ANALYTICS=1
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$HOMEBREW_PREFIX/opt/openssl@1.1" # fix openssl issue: https://github.com/openssl/openssl/issues/18720
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES # fix certain issues with Puma/Ruby running

# Android SDK
export ANDROID_HOME="$HOME/Library/Android/sdk"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

# Extend PATH
path=(
  /opt/homebrew/opt/openssl@1.1/bin # fix openssl issue: https://github.com/openssl/openssl/issues/18720
  $ANDROID_HOME/emulator
  $ANDROID_HOME/platform-tools
  $HOME/.config/claude-code # custom claude code
  $HOME/.config/padlet # custom padlet CLI tools
  $path
)

# Extend FPATH
fpath=(~/zshcompletions $fpath)

# Use additional Git repositories pulled in with `z4h install`.
# z4h load mattmc3/zsh-safe-rm

# Source asdf.
z4h source -- ${HOMEBREW_PREFIX:+$HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh}

# Source additional local files if they exist.
for file in ~/zsh/*sh; do
  z4h source -- "$file"
done

# Source orbstack integration.
z4h source -- "$HOME/.orbstack/shell/init.zsh"

# Define key bindings.
z4h bindkey z4h-cd-up            Alt+K  # cd into the parent directory

# Autoload functions.
autoload -Uz zmv

# Define functions and completions.
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories md

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu
setopt sharehistory  # share history between zsh sessions
setopt hist_ignore_all_dups # remove older command from the history if a duplicate is to be added

