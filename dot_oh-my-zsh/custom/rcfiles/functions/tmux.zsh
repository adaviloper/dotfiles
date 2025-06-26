#!/bin/bash

# Function to check if a directory exists
function check_directory() {
    local expanded_path=$(eval echo $1)
    if [ -d "$expanded_path" ]; then
        return 0  # Directory exists
    else
        return 1  # Directory does not exist
    fi
}

_load_completion() {
    CONFIG_DIR="$HOME/.config/tmuxp"
    local cur_word
    COMPREPLY=()
    cur_word="${COMP_WORDS[COMP_CWORD]}"
    YAML_FILES=("$CONFIG_DIR"/*.yaml)

    # Filter YAML files based on the start_directory key
    VALID_YAML_FILES=()
    for yaml_file in "${YAML_FILES[@]}"; do
        start_directory=$(yq e '.start_directory' "$yaml_file" | awk 'NR==1')
        if [ -z "$start_directory" ] || check_directory "$start_directory"; then
            VALID_YAML_FILES+=("$yaml_file")
        fi
    done

    # Extract just the file names without the path or extension
    YAML_FILES_BASENAMES=()
    for file in "${VALID_YAML_FILES[@]}"; do
        file_basename=$(basename "$file" .yaml)
        YAML_FILES_BASENAMES+=("$file_basename")
    done

    # Generate autocomplete suggestions
    COMPREPLY=($(compgen -W "${YAML_FILES_BASENAMES[*]}" -- "$cur_word"))
}
complete -F _load_completion load

function tm() {
    CONFIG_DIR="$HOME/.config/tmuxp"

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
