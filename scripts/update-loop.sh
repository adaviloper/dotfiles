#!/bin/bash

# Define the repository path
repo_path="$HOME/Code/loop-returns-app"

# Check if the repository path exists
if [ ! -d "$repo_path" ]; then
    echo "Error: Repository path $repo_path does not exist."
    exit 1
fi

echo "Switching to loop-returns-app"
cd "$repo_path" || exit 1

# Track whether changes were stashed during script execution
changes_stashed=false

# Check if there are any modified files
if ! git diff-index --quiet HEAD --; then
    echo "Stashing changes."
    git stash || exit 1
    changes_stashed=true
fi

# Check if the current branch is not develop
current_branch=$(git rev-parse --abbrev-ref HEAD)
if [ "$current_branch" != "develop" ]; then
    echo "Checking out [develop]"
    git checkout develop || exit 1
    git pull || exit 1

    # Run the update script only if the branch was switched
    echo "Running update script"
    if [ -f "script/update" ]; then
        sh "script/update" || exit 1
    else
        echo "Error: update script not found."
        exit 1
    fi
fi

# Return back to the previous branch if it was not develop initially
if [ "$current_branch" != "develop" ]; then
    echo "Returning back to previous branch"
    git checkout - || exit 1
fi

# Pop stashed changes if they were stashed during script execution
if $changes_stashed; then
    echo "Popping stashed changes."
    git stash pop || exit 1
fi

echo "Script execution completed successfully."
exit 0
