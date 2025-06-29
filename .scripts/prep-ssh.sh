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

read -rp "Enter your email for the SSH key (e.g. you@example.com): " ssh_email

key_path="$HOME/.ssh/id_ed25519"

if [ -f "$key_path" ]; then
  info "⚠️ SSH key already exists at $key_path"
else
  ssh-keygen -t ed25519 -C "$ssh_email" -f "$key_path" -N ""
  info "✅ SSH key generated: $key_path"
fi

read -rp "Press Enter after updating your ssh key in Github"

