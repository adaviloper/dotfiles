#!/bin/bash

{{ template "shared_bin_utils.sh" . }}

# Oh-My-Zsh installation
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  info "Installing Oh-My-Zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
else
  info "Oh-My-Zsh already installed"
fi

