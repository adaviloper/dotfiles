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
sudo apt update

while true; do
  read -rp "Enter your email for the SSH key (e.g. you@example.com): " ssh_email
  [[ "$ssh_email" =~ ^[^@]+@[^@]+\.[^@]+$ ]] && break
  info "Invalid email format. Please try again."
done

key_path="$HOME/.ssh/id_ed25519"

if [ -f "$key_path" ]; then
  info "⚠️ SSH key already exists at $key_path"
else
  ssh-keygen -t ed25519 -C "$ssh_email" -f "$key_path" -N ""
  info "✅ SSH key generated: $key_path"
fi

sudo apt install curl wl-clipboard
wl-copy < ~/.ssh/id_ed25519.pub

read -rp "Press Enter after updating your ssh key in Github"

curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg

# Install required dependencies early
info "Installing core packages"
sudo apt install -y \
  build-essential \
  gnome-browser-connector \
  gnome-shell-extensions \
  gnome-tweaks \
  gcc \
  git \
  libwxgtk3.2-dev \
  wezterm \
  wget \
  zsh

# Install Homebrew (Linux)
info "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Setup Homebrew env
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Run Brewfile
if [ -f "$HOME/.dotfiles/Brewfile" ]; then
  info "Running Brewfile"
  brew bundle --file="$HOME/.dotfiles/Brewfile"
else
  info "No Brewfile found at ~/.dotfiles/Brewfile"
fi

# Oh-My-Zsh installation
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  info "Installing Oh-My-Zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
fi

# Run rcup if available
if command -v rcup &>/dev/null; then
  info "Running rcup"
  rcup -f

  # TPM for tmux
  TPM_DIR="$HOME/.config/tmux/plugins/tpm"
  if [ ! -d "$TPM_DIR" ]; then
    info "Cloning TPM (tmux plugin manager)"
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
  fi
else
  info "rcup not found, skipping dotfile linking"
fi

# Yazi plugins (if ya is available)
if command -v ya &>/dev/null; then
  info "Installing Yazi plugins"
  # ya pack -a yazi-rs/plugins:git
  # ya pack -a yazi-rs/flavors:catppuccin-mocha
else
  info "Skipping Yazi plugin install (ya not found)"
fi

# Install tmux plugins
info "Installing tmux plugins"
tmux start-server
tmux new-session -d -s __tpm_temp
tmux source-file "$HOME/.config/tmux/tmux.conf"
"$TPM_DIR/bin/install_plugins"
tmux kill-session -t __tpm_temp

# Run Go dependencies setup
if [ -f "$HOME/.dotfiles/scripts/go-dependencies.sh" ]; then
  info "Running go-dependencies.sh"
  bash "$HOME/.dotfiles/scripts/go-dependencies.sh"
fi

# Prepare notes directory
mkdir -p "$HOME/Code/notes"

# Trigger Neovim plugin install
if command -v nvim &>/dev/null; then
  info "Running headless nvim to initialize plugins"
  nvim --headless +q
fi

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

# Install QMK
curl -LsSf https://astral.sh/uv/install.sh | sh
uv tool install qmk
qmk setup

# Install flatpak
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# GNOME Shell Extensions
EXT_DIR="$HOME/.local/share/gnome-shell/extensions"
info "Creating extensions path"
mkdir -p "$EXT_DIR"

clone_extension() {
  local repo="$1"
  local dir="$2"
  if [ ! -d "$EXT_DIR/$dir" ]; then
    info "Cloning GNOME extension: $dir"
    git clone "git@github.com:$repo.git" "$EXT_DIR/$dir"
  fi
  gnome-extensions enable "$dir" || true
}

clone_extension "adaviloper/moover" "moover@adaviloper.com"
clone_extension "adaviloper/quicker" "quicker@adaviloper.com"

gnome-extensions install apps-menu@gnome-shell-extensions.gcampax.github.com
gnome-extensions install clipboard-indicator@tudmotu.com
gnome-extensions install ding@rastersoft.com
gnome-extensions install native-window-placement@gnome-shell-extensions.gcampax.github.com
gnome-extensions install openbar@neuromorph
gnome-extensions install ubuntu-appindicators@ubuntu.com
gnome-extensions install ubuntu-dock@ubuntu.com

info "Setup complete."

# Change shell to zsh if not already
if [ "$SHELL" != "$(which zsh)" ]; then
  info "Changing default shell to zsh"
  chsh -s "$(which zsh)"
fi

sudo apt autoremove

dconf load / < ~/.dotfiles/config/dconf/user.conf
