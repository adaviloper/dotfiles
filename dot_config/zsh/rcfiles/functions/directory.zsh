mkd () {
  mkdir -p $1
}

mks () {
  REPO_URL="$1"
  REPO_NAME=$(echo "$REPO_URL" | sed "s|.*/||" | sed -E "s|\..*||")
  # echo "$REPO_NAME"
  # gcl "$1"
  touch ~/.local/share/chezmoi/dot_config/tmuxp/${REPO_NAME}.yaml
}

