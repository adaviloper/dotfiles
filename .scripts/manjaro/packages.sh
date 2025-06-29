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
sudo yay -Syu --noconfirm

# Install required dependencies early
info "Installing core packages"
sudo yay -Syu \
  bat \
  btop \
  chezmoi \
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
  luarocks \
  neovim \
  nodejs \
  npm \
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
  xclip \
  yazi \
  yq \
  zoxide \
  zsh-autosuggestions \
  zsh-completions \
  --noconfirm

yay -Syu \
  1password \
  1password-cli \
  lazynpm \
  --noconfirm
