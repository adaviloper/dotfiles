# Helper function to determine package manager
_use_yarn() {
  if [ -f yarn.lock ]; then
    return 0  # use yarn
  elif [ -f package-lock.json ]; then
    return 1  # use npm
  else
    choice=$(gum choose --header "No lockfile found. Which package manager?" yarn npm)
    if [ "$choice" = "yarn" ]; then
      return 0
    else
      return 1
    fi
  fi
}

ni() {
  if _use_yarn; then
    yarn install "$@"
  else
    npm install "$@"
  fi
}

nid() {
  if _use_yarn; then
    yarn add --dev "$@"
  else
    npm install -D "$@"
  fi
}

nrd() {
  if _use_yarn; then
    yarn dev "$@"
  else
    npm run dev "$@"
  fi
}

nrh() {
  if _use_yarn; then
    yarn hot "$@"
  else
    npm run hot "$@"
  fi
}

nrp() {
  if _use_yarn; then
    yarn prod "$@"
  else
    npm run prod "$@"
  fi
}

nrt() {
  if _use_yarn; then
    yarn test "$@"
  else
    npm run test "$@"
  fi
}

nrw() {
  if _use_yarn; then
    yarn watch "$@"
  else
    npm run watch "$@"
  fi
}

nrww() {
  if _use_yarn; then
    yarn watch-poll "$@"
  else
    npm run watch-poll "$@"
  fi
}
