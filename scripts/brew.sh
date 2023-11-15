#!/bin/bash

yellow() {
  tput setaf 3
  echo "$*"
  tput sgr0
}

info() {
  echo
  yellow "$@"
}

info "Navigating to [~/.dotfiles]"
cd ~/.dotfiles

brew bundle

