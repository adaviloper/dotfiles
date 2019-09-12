# Example aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

export PATH="$PATH:/Applications/XAMPP/bin;yarn global bin;"

## Development
alias ll="ls -alhG"
alias pup="php -S localhost:3000"

alias c="clear"

alias cdh="cd ~/Homestead"
alias cloc="git ls-files | xargs wc -l"

# Git
alias gcos="git checkout staging"
alias gcod="git checkout dev"

# Python
#alias python=python3

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

# Path updates
export PATH=/Applications/PhpStorm.app/Contents/bin:$PATH

# servers Connections
alias holy-farm="ssh forge@96.126.124.75"
alias app1="ssh forge@54.214.53.168"
alias app2="ssh forge@35.162.21.101"
