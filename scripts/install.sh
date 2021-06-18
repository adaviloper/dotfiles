#!/bin/bash

sudo xcodebuild -license accept

set -e

yellow() {
  tput setaf 3
  echo "$*"
  tput sgr0
}

info() {
  echo
  yellow "$@"
}

chsh -s $(which zsh)

# Setup OhMyZsh for Zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

cd ~/.dotfiles

brew tap homebrew/bundle
brew bundle

rcup

sh ./vim.sh
sh ./post-install.sh
