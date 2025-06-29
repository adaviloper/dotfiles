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

# Install QMK
curl -LsSf https://astral.sh/uv/install.sh | sh
uv tool install qmk
qmk setup


git clone git@github.com:adaviloper/qmk_userspace.git "$HOME/Code/"


(cd "$HOME/Code/" && qmk setup)
