#!/bin/bash

# Exit if password manager is already installed
if type pass-cli >/dev/null 2>&1; then
  exit 0
fi

echo "Installing Password Manager."

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
          curl -fsSL https://proton.me/download/pass-cli/install.sh | bash
          ;;
        arch)
          echo "Detected Arch Linux"
          # sudo pacman -Syu --noconfirm 1password 1password-cli
          curl -fsSL https://proton.me/download/pass-cli/install.sh | bash
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
