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

sudo apt install -y qmk

git clone git@github.com:adaviloper/qmk_userspace.git "$HOME/Code/"


(cd "$HOME/Code/" && qmk setup)
