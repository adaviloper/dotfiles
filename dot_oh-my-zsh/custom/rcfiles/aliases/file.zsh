# Example aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

## Development
alias .="cd ~/.dotfiles"
alias c="clear"
alias cdh="cd ~/Homestead"
alias cloc="git ls-files | xargs wc -l"
alias code="cd ~/Code"
alias ls="eza --color=always"
alias l="ls -alh"
# alias l="ls -alh --color=auto -F --git --icons --group-directories-first"
alias pup="php -S localhost:3000"

# Testing
alias cy='./node_modules/.bin/cypress'
alias cyo='cy open'
alias cyr='cy run'
alias jt='nrt -t'
alias p='phpunit'
alias pf='p --filter'
alias phpspec='vendor/bin/phpspec'
alias phpunit='vendor/bin/phpunit'
alias serve='serve-laravel'

export CLICOLOR=1

alias -s md="nvim"
