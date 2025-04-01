function zj() {
  if [ "$#" -gt 0 ]; then
    case "$1" in
      "dots")
        zellij -l "dotfiles" a -c "dotfiles" 
        ;;
      "qmk")
        zellij -l "qmk" a -c "qmk" 
        ;;
      *)
        zellij "$@"
        ;;
    esac
  fi
}
