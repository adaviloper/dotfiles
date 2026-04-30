#!/bin/bash

# Read stdin JSON into variable
input=$(cat)

# Parse JSON fields
cwd=$(echo "$input" | jq -r '.workspace.current_dir // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
context_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')

# Handle directory substitutions (matching Starship config)
display_dir="$(basename $(pwd))"
display_dir="${display_dir/#$HOME\/Code/Code}"
display_dir="${display_dir/#$HOME\/.local\/share\/chezmoi/ .dotfiles}"
display_dir="${display_dir/qmk_firmware/󰌓 QMK}"
display_dir="${display_dir/#$HOME/~}"

# Catppuccin Mocha — 24-bit for fg, 256-color index for bg
# (Claude Code statusline renders 48;2 bg as grey; 48;5 bg works correctly)
BASE_R=30  BASE_G=30  BASE_B=46     # #1e1e2e
BASE_256=234                         # #1c1c1c (closest grayscale)

MAUVE_R=203 MAUVE_G=166 MAUVE_B=247 # #cba6f7
MAUVE_256=183                        # #d7afff

BLUE_R=250 BLUE_G=179 BLUE_B=135    # #fab387 (peach)
BLUE_256=216                         # #ffaf87

YELLOW_R=249 YELLOW_G=226 YELLOW_B=175 # #f9e2af
YELLOW_256=223                          # #ffd7af

TEAL_R=148 TEAL_G=226 TEAL_B=213    # #94e2d5
TEAL_256=116                         # #87d7d7

# Powerline pill characters
LEFT_CAP=""
RIGHT_CAP=""

# Render a powerline pill segment
# Usage: segment "text" fg_R fg_G fg_B bg_256
segment() {
    local text="$1" r="$2" g="$3" b="$4" bg256="$5"
    # Left cap: accent fg (256-color, same index as text bg for exact match)
    printf "\033[38;5;%dm%s" "$bg256" "$LEFT_CAP"
    # Text: BASE fg (256-color), accent bg (256-color)
    printf "\033[38;5;%dm\033[48;5;%dm%s" "$BASE_256" "$bg256" "$text"
    # Right cap: reset bg to default, accent fg (256-color)
    printf "\033[49m\033[38;5;%dm%s\033[0m " "$bg256" "$RIGHT_CAP"
}

# Build segments array: "text|R|G|B|BG256"
segments=()

if [ -n "$model" ]; then
    segments+=("󱚟 $model|$BLUE_R|$BLUE_G|$BLUE_B|$BLUE_256")
fi

if [ -n "$display_dir" ]; then
    segments+=(" $display_dir|$MAUVE_R|$MAUVE_G|$MAUVE_B|$MAUVE_256")
fi

if [ -n "$context_pct" ] && [ "$context_pct" != "null" ]; then
    context_display=$(printf "%.0f%%" "$context_pct")
    segments+=("󱨵 $context_display|$YELLOW_R|$YELLOW_G|$YELLOW_B|$YELLOW_256")
fi

if [ -n "$cost" ] && [ "$cost" != "null" ] && [ "$cost" != "0" ]; then
    cost_display=$(printf "󱀇 $%.2f" "$cost")
    segments+=("$cost_display|$TEAL_R|$TEAL_G|$TEAL_B|$TEAL_256")
fi

for seg in "${segments[@]}"; do
    IFS='|' read -r text r g b bg256 <<< "$seg"
    segment "$text" "$r" "$g" "$b" "$bg256"
done
