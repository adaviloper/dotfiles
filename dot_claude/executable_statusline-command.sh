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

# Catppuccin Mocha colors (true color)
BASE_R=30  BASE_G=30  BASE_B=46      # #1e1e2e - dark text
MAUVE_R=203 MAUVE_G=166 MAUVE_B=247  # #cba6f7 - directory
BLUE_R=250 BLUE_G=179 BLUE_B=135     # #fab387 - model
YELLOW_R=249 YELLOW_G=226 YELLOW_B=175 # #f9e2af - context
TEAL_R=148 TEAL_G=226 TEAL_B=213     # #94e2d5 - cost

# Powerline characters
LEFT_CAP=""
RIGHT_CAP=""

# Helper function: render a powerline segment
# Usage: segment "text" R G B
segment() {
    local text="$1"
    local r="$2" g="$3" b="$4"

    # Left cap: fg = accent, bg = base
    printf "\033[38;2;%d;%d;%d;48;2;%d;%d;%dm%s" "$r" "$g" "$b" "$BASE_R" "$BASE_G" "$BASE_B" "$LEFT_CAP"

    # Segment text: fg = base (dark), bg = accent color
    printf "\033[38;2;%d;%d;%d;48;2;%d;%d;%dm%s" "$BASE_R" "$BASE_G" "$BASE_B" "$r" "$g" "$b" "$text"

    # Right cap: fg = accent, bg = base
    printf "\033[38;2;%d;%d;%d;48;2;%d;%d;%dm%s\033[0m " "$r" "$g" "$b" "$BASE_R" "$BASE_G" "$BASE_B" "$RIGHT_CAP"
}

# Build segments array
# Format: "text|R|G|B"
segments=()

# Model segment (blue)
if [ -n "$model" ]; then
    segments+=("󱚟 $model|$BLUE_R|$BLUE_G|$BLUE_B")
fi

# Directory segment (mauve)
if [ -n "$display_dir" ]; then
    segments+=(" $display_dir|$MAUVE_R|$MAUVE_G|$MAUVE_B")
fi

# Context usage segment (yellow)
if [ -n "$context_pct" ] && [ "$context_pct" != "null" ]; then
    context_display=$(printf "%.0f%%" "$context_pct")
    segments+=("󱨵 $context_display|$YELLOW_R|$YELLOW_G|$YELLOW_B")
fi

# Cost segment (teal)
if [ -n "$cost" ] && [ "$cost" != "null" ] && [ "$cost" != "0" ]; then
    cost_display=$(printf "$%.2f" "$cost")
    segments+=("$cost_display|$TEAL_R|$TEAL_G|$TEAL_B")
fi

# Output all segments
for seg in "${segments[@]}"; do
    IFS='|' read -r text r g b <<< "$seg"
    segment "$text" "$r" "$g" "$b"
done
