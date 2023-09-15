function tm {
  if [[ $# -gt 0 ]]; then
    tmux "$@"
  else
    tmux new-session -A -s main
  fi
}
