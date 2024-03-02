#!/bin/bash

function tm() {
    SESSIONS=("dots" "loop" "qmk" "figs" "whiplash")
    CONFIG_DIR="$HOME/.config/tmuxp"

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
        for session in "${SESSIONS[@]}"; do
            local config_path="$CONFIG_DIR/$session.yaml"
            # Check if the tmuxp config file exists
            if [ -f "$config_path" ]; then
                # Parse session_name from the YAML file
                local session_name=$(yq e '.session_name' "$config_path")
                # Parse the first start_directory from the YAML file
                local start_directory=$(yq e '.start_directory' "$config_path" | awk 'NR==1')
                
                if [ -z "$start_directory" ] || check_directory "$start_directory"; then
                    # Load the tmuxp session using the parsed session name
                    tmuxp load -d "$config_path"
                else
                    echo "Start directory '$start_directory' for project '$session' does not exist."
                fi
            else
                echo "tmuxp config for '$session' does not exist."
            fi
        done
        tmux attach -t Dotfiles
    fi
}

# To use this function, source this script from your shell or add it to your .bashrc or .zshrc file.
# Then you can call it from the terminal by typing `tm` or `tm <tmux command>`.
