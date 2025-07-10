#!/bin/bash

# Exit if password manager is already installed
if type op >/dev/null 2>&1; then
  exit 0
fi

echo "Installing 1Password CLI."

# Detect platform
case "$(uname -s)" in
  Darwin)
    echo "Detected macOS"

    # Check if Homebrew is installed
    if ! command -v brew >/dev/null 2>&1; then
      echo "❌ Homebrew is not installed. Please install Homebrew first."
      info "Installing Homebrew"
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi

    # Check if 1Password is already installed
    if [[ -d /Applications/1Password.app ]]; then
      echo "✅ 1Password is already installed."
    else
      echo "1Password is not installed."
      brew install --cask 1password
    fi

    # Check if 1Password CLI is already installed
    if command -v op >/dev/null 2>&1; then
      echo "✅ 1Password CLI is already installed."
    else
      brew install --cask 1password-cli
    fi
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
          sudo apt update && sudo apt install 1password 1password-cli
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
