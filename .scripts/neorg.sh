#!/bin/bash

# Prepare notes directory
mkdir -p "$HOME/Code/neorg/notes"
TEMPLATES_DIR="$HOME/Code/neorg/templates/"
if [ ! -d "$TEMPLATES_DIR" ]; then
  info "Cloning Neorg templates"
git clone git@github.com:adaviloper/neorg-templates "$TEMPLATES_DIR"
else
  info "Templates directory already exists at $TEMPLATES_DIR"
fi

# Trigger Neovim plugin install
if command -v nvim &>/dev/null; then
  info "Running headless nvim to initialize plugins"
  nvim --headless +q
fi

