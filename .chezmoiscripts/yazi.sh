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

function install_yazi_plugin() {
  package=$1
  ya pkg add $package &
}

# Yazi plugins (if ya is available)
if command -v ya &>/dev/null; then
  info "Installing Yazi plugins"
  install_yazi_plugin yazi-rs/flavors:catppuccin-mocha
  install_yazi_plugin yazi-rs/plugins:git
else
  info "Skipping Yazi plugin install (ya not found)"
fi

