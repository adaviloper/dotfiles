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

curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg

sudo apt update

# Install required dependencies early
info "Installing core packages"
sudo apt install -y \
  build-essential \
  gnome-browser-connector \
  gnome-shell-extensions \
  gnome-tweaks \
  curl \
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

# Espanso install
# ESPANSO_DEB="espanso-debian-wayland-amd64.deb"
# if ! command -v espanso &>/dev/null; then
#   info "Downloading Espanso"
#   wget "https://github.com/espanso/espanso/releases/download/v2.2.1/${ESPANSO_DEB}"
#   info "Installing Espanso"
#   sudo apt install -y "./${ESPANSO_DEB}"
#   info "Removing Espanso install script"
#   rm "${ESPANSO_DEB}"
#   sudo setcap "cap_dac_override+p" "$(which espanso)"
#   info "Registering Espanso service"
#   espanso service register
# fi

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

info "Setup complete."

# Change shell to zsh if not already
if [ "$SHELL" != "$(which zsh)" ]; then
  info "Changing default shell to zsh"
  chsh -s "$(which zsh)"
fi

sudo apt autoremove
