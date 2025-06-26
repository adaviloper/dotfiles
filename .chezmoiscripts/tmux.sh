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
sudo yay -Syu

# Clone TPM if it doesn't exist
TPM_DIR="$HOME/.config/tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  info "Cloning TPM (Tmux Plugin Manager)"
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
  info "TPM already exists at $TPM_DIR"
fi

# Install tmux plugins
info "Installing tmux plugins"
tmux start-server
tmux new-session -d -s __tpm_temp
tmux source-file "$HOME/.config/tmux/tmux.conf"
"$TPM_DIR/bin/install_plugins"
tmux kill-session -t __tpm_temp
