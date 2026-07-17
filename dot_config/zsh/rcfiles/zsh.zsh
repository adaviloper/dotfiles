# Edit the command line in the `$EDITOR` tool
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Magic space to expand historical commands
bindkey ' ' magic-space

# chpwd hook
chpwd() {
  [[ -d .git ]] && git status --short || l
}

# Clear screen but keep current command buffer
function clear-screen-and-scrollback() {
  echoti civis >"$TTY"
  printf '%b' '\e[H\e[1J\e[3J' >"$TTY"
  echoti cnorm >"$TTY"
  zle redisplay
}
zle -N clear-screen-and-scrollback
bindkey '^x^l' clear-screen-and-scrollback

# Up/down arrows cycle history filtered by what's already typed (prefix match)
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
for keymap in viins vicmd; do
  bindkey -M $keymap '^[[A' up-line-or-beginning-search
  bindkey -M $keymap '^[OA' up-line-or-beginning-search
  bindkey -M $keymap '^[[B' down-line-or-beginning-search
  bindkey -M $keymap '^[OB' down-line-or-beginning-search
done

