alias c="clear"
alias cdh="cd ~/Homestead"
alias cloc="git ls-files | xargs wc -l"
alias vclear="rm -rf ~/.local/state/nvim; rm -rf ~/.local/share/nvim; rm -rf ~/.cache/nvim/"

alias -g G="| rg"
alias -g J="| jq"
alias -g Y="| yq"
# Redirect stderr to /dev/null
alias -g NE='2>/dev/null'
# Redirect stdout to /dev/null
alias -g NO='>/dev/null'
# Redirect both stdout and stderr to /dev/null
alias -g NUL='>/dev/null 2>&1'
# Copy output to clipboard (macOS)
alias -g C='| pbcopy'

alias -s md="bat"

