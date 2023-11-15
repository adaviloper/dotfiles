#!/bin/bash

# Function to create or attach to a tmux session with specified windows and directories
function tm() {
    SESSION_NAME="main"
    SESSION_NAMES=("Dotfiles" "Loop Returns App" "QMK Firmware" "Whiplash Middleware")
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
        for ((i=1; i<=${#SESSION_NAMES[@]}; i++)); do
            tmux has-session -t $SESSION_NAMES[$i] 2>/dev/null

            if [ $? != 0 ]; then
                echo "Creating session for '${SESSION_NAMES[$i]}' in directory: ${DIRECTORIES[$i]//\~/$HOME} : ${DIRECTORIES[$i]}."
                tmux new-session -d -s $SESSION_NAMES[$i] -n "Project"

                # Add more windows with specific names and directories
                tmux new-window -t $SESSION_NAMES[$i]: -n "Terminals"
                # Check if the directory exists before setting it
                if check_directory "${DIRECTORIES[$i]}"; then
                    tmux send-keys -t $SESSION_NAMES[$i]:1 "cd ${DIRECTORIES[$i]//\~/$HOME}" C-m
                    tmux send-keys -t $SESSION_NAMES[$i]:2 "cd ${DIRECTORIES[$i]//\~/$HOME}" C-m
                    tmux send-keys -t $SESSION_NAMES[$i]:1 "c" C-m
                    tmux send-keys -t $SESSION_NAMES[$i]:2 "c" C-m
                    tmux select-window -t $SESSION_NAMES[$i]:1
                else
                    echo "Directory '${DIRECTORIES[$i]//\~/$HOME}' does not exist."
                fi
            fi
        done
        tmux attach -t $SESSION_NAMES[1]
    fi
}
