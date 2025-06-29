alias ts_norg="CC=/opt/homebrew/opt/llvm/bin/clang nvim --headless -c 'TSInstallSync norg'"
alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'

DEFAULT="nvim"

function nv() {
  CONFIGURATION=$(gum choose 'nvim-kickstart' $DEFAULT)
  export NVIM_APPNAME=$CONFIGURATION

  nvim
}
