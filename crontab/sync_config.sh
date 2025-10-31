#!/usr/bin/env bash

# Exit the script on error
set -e

commit_and_push() {
  cd "$HOME/dotfiles"
  git commit -am "update @ $(date +"%c")"
  git push origin HEAD:master
}

zip_alfred_preferences() {
  FILEPATH="$HOME/dotfiles/.config/_alfred/Alfred.alfredpreferences"
  BACKUP="$HOME/dotfiles/.config/_alfred/Alfred.alfredpreferences.tar.gz"
  tar czf "$BACKUP" -C "$FILEPATH" .
}

zip_alfred_preferences
commit_and_push
