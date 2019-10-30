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

# Setup Vundle for Vim
mkdir -p ~/.vim/bunlde
yellow "Installing Vundle"
echo ""
rm -rf ~/.vim/bundle/Vundle.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

rcup

# Auto-install plugins after everything is finished linking
vim +PluginInstall +qall

