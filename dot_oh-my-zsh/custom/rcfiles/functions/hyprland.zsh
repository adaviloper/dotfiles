_hyprland_current_sig() {
  local hypr_dir="/run/user/$UID/hypr"
  local best_sig="" best_time=0

  for dir in "$hypr_dir"/*/; do
    [[ -d "$dir" ]] || continue
    local name="${${dir%/}##*/}"
    local timestamp="${${name%_*}##*_}"

    if HYPRLAND_INSTANCE_SIGNATURE="$name" command hyprctl version &>/dev/null; then
      (( timestamp > best_time )) && { best_time=$timestamp; best_sig=$name; }
    fi
  done

  echo "$best_sig"
}

hyprctl() {
  local sig
  sig=$(_hyprland_current_sig)
  if [[ -n "$sig" && "$sig" != "$HYPRLAND_INSTANCE_SIGNATURE" ]]; then
    export HYPRLAND_INSTANCE_SIGNATURE="$sig"
  fi
  command hyprctl "$@"
}

hyprland-cleanup() {
  local hypr_dir="/run/user/$UID/hypr"
  for dir in "$hypr_dir"/*/; do
    [[ -d "$dir" ]] || continue
    local name="${${dir%/}##*/}"
    if ! HYPRLAND_INSTANCE_SIGNATURE="$name" command hyprctl version &>/dev/null; then
      echo "removing stale: $name"
      rm -rf "$dir"
    fi
  done
}
