#!/bin/bash

yellow() {
  tput setaf 3
  echo "$*"
  tput sgr0
}

info() {
  echo
  yellow "$@"
}

DOTFILES_DIR="$HOME/.dotfiles"

if [ -d "$DOTFILES_DIR" ]; then
    info "Navigating to [$DOTFILES_DIR]"
    cd "$DOTFILES_DIR"
else
    echo "Error: Directory $DOTFILES_DIR does not exist."
    exit 1
fi

if command -v brew >/dev/null 2>&1; then
    info "Running [brew bundle]"
    brew bundle
else
    echo "Error: Homebrew is not installed."
    exit 1
fi

