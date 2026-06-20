_hyprland_current_sig() {
  local hypr_dir="/run/user/$UID/hypr"
  local best_sig="" best_time=0

  for dir in "$hypr_dir"/*/; do
    [[ -d "$dir" ]] || continue
    local name="${${dir%/}##*/}"
    local timestamp="${${name%_*}##*_}"

    if command hyprctl -i "$name" version &>/dev/null 2>&1; then
      (( timestamp > best_time )) && { best_time=$timestamp; best_sig=$name; }
    fi
  done

  echo "$best_sig"
}

hyprctl() {
  local sig
  sig=$(_hyprland_current_sig)
  if [[ -n "$sig" ]]; then
    command hyprctl -i "$sig" "$@"
  else
    command hyprctl "$@"
  fi
}

hyprland-cleanup() {
  local hypr_dir="/run/user/$UID/hypr"
  for dir in "$hypr_dir"/*/; do
    [[ -d "$dir" ]] || continue
    local name="${${dir%/}##*/}"
    if ! command hyprctl -i "$name" version &>/dev/null 2>&1; then
      echo "removing stale: $name"
      rm -rf "$dir"
    fi
  done
}
