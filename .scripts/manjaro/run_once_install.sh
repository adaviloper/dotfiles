#!/bin/bash

set -euo pipefail

OS_INSTALL_DIR="$HOME/.local/share/chezmoi/.scripts/manjaro/"

# Colors
yellow() {
  tput setaf 3
  printf "%s\n" "$*"
  tput sgr0
}

info() {
  echo
  yellow "$@"
}

# Update package list
info "Updating package lists"
sudo pacman -Syu

sh $OS_INSTALL_DIR/../prep-ssh.sh

# Install required dependencies early
info "Installing core packages"
sh $OS_INSTALL_DIR/./packages.sh

# Oh-My-Zsh installation
info "Installing Oh-My-Zsh"
sh $OS_INSTALL_DIR/../oh-my-zsh.sh

# Tmux installation
info "Installing Tmux"
sh .$OS_INSTALL_DIR/./tmux.sh

# Apply dotfiles
chezmoi apply

# Yazi plugins (if ya is available)
info "Installing Yazi plugins"
sh $OS_INSTALL_DIR/../yazi.sh

# Run Go dependencies setup
info "Installing go-dependencies.sh"
sh $OS_INSTALL_DIR/../go-dependencies.sh

# Prepare notes directory
info "Installing go-dependencies.sh"
sh .$OS_INSTALL_DIR/./neorg.sh

info "Swap shell"
sh $OS_INSTALL_DIR/../swap-shell.sh

info "Setup complete."
