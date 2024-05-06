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

if test ! $(which brew); then
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

info "Installing Brewfile packages"
sh ~/.dotfiles/scripts/brew.sh

git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

info "Running [post-install.sh]"
sh ~/.dotfiles/scripts/post-install.sh

# Setup OhMyZsh for Zsh
info "Installing Oh-My-ZSH"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -- --unattended)"

info "Installing Zsh-AutoSuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

info "Running [rcup]"
rcup -f

info "Installing TPM"
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

info "Updating OSX default settings"
sh ~/.dotfiles/scripts/osx.sh

info "Switching shell to ZSH"
chsh -s $(which zsh)

