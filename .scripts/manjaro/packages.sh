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

sudo pacman -Syu yay fakeroot --noconfirm

# Update package list
info "Updating package lists"
sudo yay -Syu

# Install required dependencies early
info "Installing core packages"
sudo yay -Syu \
  1password \
  bat \
  composer \
  eza \
  fd \
  ffmpegthumbnailer \
  fzf \
  gcc \
  github-cli \
  go \
  gum \
  jq \
  lazygit \
  lazynpm \
  luarocks \
  neovim \
  nodejs \
  php \
  readline \
  ripgrep \
  rust \
  starship \
  tmux \
  tmuxp \
  tree \
  unar \
  wezterm \
  yazi \
  yq \
  zoxide \
  zsh-autosuggestions \
  zsh-completions \
  --noconfirm

