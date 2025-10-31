#!/usr/bin/env bash

# Exit the script on error
set -e

# Create the dotfiles session if not exist
if ! tmux has-session -t dotfiles 2>/dev/null; then
  tmux new-session -d -s dotfiles -c "$HOME/dotfiles"
fi

# If there's already a nvim window open, switch to it
windows=$(tmux list-windows -t dotfiles -F '#{pane_tty} #{window_index}')
IFS=$'\n'
for window in $windows; do
  IFS=' ' read tty index <<<"$window"
  window_name=$("$HOME/.config/tmux/tty2procname" $tty)
  if [[ "$window_name" == *"nvim" ]]; then
    tmux switch-client -t "dotfiles:$index"
    exit
  fi
done
unset IFS

# Otherwise, open a new nvim window
tmux switch-client -t dotfiles
tmux send-keys -t dotfiles "cd $HOME/dotfiles && nvim" Enter
