 !/usr/bin/env bash
sudo xcodebuild -license accept

set -e

CONFIG_DIR="$HOME/.config"
WORK_INDICATOR_FILE="$CONFIG_DIR/work_computer"

yellow() {
  tput setaf 3
  echo "$*"
  tput sgr0
}

info() {
  echo
  yellow "$@"
}

# Prompt for work or personal computer
read -p "Is this a work computer? (y/n): " response

if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    info "This is a work computer. Creating indicator file."
    mkdir -p "$CONFIG_DIR"
    touch "$WORK_INDICATOR_FILE"
else
    info "This is a personal computer. No indicator file will be created."
fi

if ! command -v brew >/dev/null 2>&1; then
    info "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

info "Installing Brewfile packages"
brew bundle --file=~/.dotfiles/Brewfile

if !command -v brew >/dev/null 2>&1; then
    info "Installing Yazi plugins"
    ya pack -a yazi-rs/plugins:git
    ya pack -a yazi-rs/flavors:catppuccin-mocha
fi

if [ ! -d ~/.config/tmux/plugins/tpm ]; then
    info "Installing TPM"
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
fi

info "Installing TPM plugins"
# Start a tmux session and install the plugins
tmux source ~/.tmux.conf
tmux run-shell '~/.config/tmux/plugins/tpm/bin/install_plugins'

info "Running [post-install.sh]"
sh ~/.dotfiles/scripts/go-dependencies.sh

# Setup OhMyZsh for Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    info "Installing Oh-My-Zsh"
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -- --unattended)"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

info "Running [rcup]"
rcup -f

# Prepare Neorg notes
mkdir -p ~/Code/notes

# Initialize nvim
nvim --headless +q

info "Updating OSX default settings"
sh ~/.dotfiles/scripts/osx.sh

if [ "$SHELL" != "$(which zsh)" ]; then
    info "Switching shell to ZSH"
    chsh -s $(which zsh)
fi

