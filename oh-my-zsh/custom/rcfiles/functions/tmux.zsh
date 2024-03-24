#!/bin/bash

function tm() {
    CONFIG_DIR="$HOME/.config/tmuxp"

    # Function to check if a directory exists
    check_directory() {
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
        # Get a list of YAML files in the CONFIG_DIR
        YAML_FILES=("$CONFIG_DIR"/*.yaml)
        
        # Filter YAML files based on start_directory existence
        FILTERED_YAML=()
        for yaml_file in "${YAML_FILES[@]}"; do
            start_directory=$(yq e '.start_directory' "$yaml_file" | awk 'NR==1')
            if [ -z "$start_directory" ] || check_directory "$start_directory"; then
                FILTERED_YAML+=("$yaml_file")
            fi
        done

        # If there are valid YAML files, choose one using gum choose
        if [ ${#FILTERED_YAML[@]} -gt 0 ]; then
            SESSIONS="$(gum choose --header "Choose which sessions to load" --no-limit "${FILTERED_YAML[@]}")"
            eval "CONFIG_FILES=($SESSIONS)"
            for config_path in $CONFIG_FILES; do
                # Check if the tmuxp config file exists
                if [ -f "$config_path" ]; then
                    # Load the tmuxp session using the config file
                    tmuxp load -d "$config_path"
                fi
            done
            tmux attach -t Dotfiles
        else
            echo "No valid YAML files found in '$CONFIG_DIR' or start directories do not exist."
        fi
    fi
}

# To use this function, source this script from your shell or add it to your .bashrc or .zshrc file.
# Then you can call it from the terminal by typing `tm` or `tm <tmux command>`.
