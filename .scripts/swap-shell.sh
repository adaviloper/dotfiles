#!/bin/bash

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

# Change shell to zsh if not already
if [ "$SHELL" != "$(which zsh)" ]; then
  info "Changing default shell to zsh"
  chsh -s "$(which zsh)"
fi

