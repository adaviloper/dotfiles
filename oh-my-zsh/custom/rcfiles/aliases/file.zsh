# Example aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

export PATH="$PATH:/Applications/XAMPP/bin;yarn global bin;"


## Development
alias .="cd ~/.dotfiles"
alias c="clear"
alias cdh="cd ~/Homestead"
alias cloc="git ls-files | xargs wc -l"
alias code="cd ~/Code"
alias ll="ls -alhG"
alias l="ll"
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

# Path updates
export PATH=/Applications/PhpStorm.app/Contents/bin:$PATH
