#!/bin/bash

# Exit if password manager is already installed
if type op >/dev/null 2>&1; then
  echo "password-manager-binary is already installed."
  exit 0
fi

# Detect platform
case "$(uname -s)" in
  Darwin)
    echo "Detected macOS"
    brew install password-manager-binary
    ;;
  Linux)
    # Get base ID from /etc/os-release
    if [ -f /etc/os-release ]; then
      . /etc/os-release
      case "$ID" in
        ubuntu|debian)
          echo "Detected Ubuntu/Debian"
          sudo apt update
          # 1Password
          ## Add key for APT repository
          curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
          ## Add 1Password APT repository
          echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
          ## Add debsig-verify policy
          sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
          curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
          sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
          curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
          # Install 1Password
          sudo apt update && sudo apt install 1password
          ;;
        arch)
          echo "Detected Arch Linux"
          sudo pacman -Syu --noconfirm 1password 1password-cli
          ;;
        *)
          echo "Unsupported Linux distribution: $ID"
          ;;
      esac
    else
      echo "Cannot detect Linux distribution. /etc/os-release not found."
    fi
    ;;
  *)
    echo "Unsupported platform: $(uname -s)"
    ;;
esac
