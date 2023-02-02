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


info "Installing HomeBrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Setup OhMyZsh for Zsh
info "Installing Oh-My-ZSH"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -- --unattended)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

info "Switching shell to ZSH"
chsh -s $(which zsh)

info "Installing Zsh-AutoSuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

info "Installing Brewfile packages"
sh ~/.dotfiles/scripts/brew.sh

info "Running [rcup]"
rcup -f

info "Running [vim.sh]"
sh ~/.dotfiles/scripts/vim.sh
info "Running [post-install.sh]"
sh ~/.dotfiles/scripts/post-install.sh
