#!/bin/bash

# Function to create or attach to a tmux session with specified windows and directories
function tm() {
    SESSION_NAME="main"
    PROJECTS=("dots" "loop" "qmk" "whiplash")
    DIRECTORIES=("~/.dotfiles" "~/Code/loop-returns-app" "~/Code/qmk_firmware" "~/Code/whiplash-middleware")

    # Function to check if a directory exists
    check_directory() {
        echo "$1"
        local expanded_path=$(eval echo $1)
        if [ -d "$expanded_path" ]; then
            return 0  # Directory exists
        else
            return 1  # Directory does not exist
        fi
    }

    # Check if there are any arguments
    if [ "$#" -gt 0 ]; then
        # Execute tmux commands passed as arguments
        tmux "$@"
    else
        for ((i=1; i<=${#DIRECTORIES[@]}; i++)); do
            if check_directory "${DIRECTORIES[$i]}"; then
                tmuxp load -d $PROJECTS[$i]
            else
                echo "Directory '${DIRECTORIES[$i]//\~/$HOME}' does not exist."
            fi
        done
        tmux attach -t Dotfiles
    fi
}
