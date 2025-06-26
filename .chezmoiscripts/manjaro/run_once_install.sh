#!/bin/bash

set -euo pipefail

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

sh ../prep-ssh.sh

# Install required dependencies early
info "Installing core packages"
sh ./packages.sh

# Oh-My-Zsh installation
info "Installing Oh-My-Zsh"
sh ../oh-my-zsh.sh

# Tmux installation
info "Installing Tmux"
sh ../tmux.sh

# Apply dotfiles
chezmoi apply

# Yazi plugins (if ya is available)
info "Installing Yazi plugins"
sh ../yazi.sh

# Run Go dependencies setup
info "Installing go-dependencies.sh"
sh ../go-dependencies.sh

# Prepare notes directory
info "Installing go-dependencies.sh"
sh ../neorg.sh

info "Swap shell"
sh ../swap-shell.sh

info "Setup complete."
