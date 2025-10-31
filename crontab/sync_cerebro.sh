#!/usr/bin/env bash

# Exit the script on error
set -e

sync() {
  cd "$HOME/tonystark/cerebro"
  git add .
  git commit -m "update @ $(date +"%c")"
  git push
}

sync
