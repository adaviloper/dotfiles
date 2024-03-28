#!/bin/bash

echo "Switching to loop-returns-app"
cd ~/Code/loop-returns-app/
echo "Checking out [develop]"

# Track whether changes were stashed during script execution
changes_stashed=false

# Check if there are any modified files
if ! git diff-index --quiet HEAD --; then
    echo "Stashing changes."
    git stash || exit 1
    changes_stashed=true
fi

echo "Checking out [develop]"
git checkout develop || exit 1
git pull || exit 1

echo "Running update script"
if [ -f "script/update" ]; then
    sh "script/update" || exit 1
else
    echo "Error: update script not found."
    exit 1
fi

echo "Returning back to previous branch"
git checkout - || exit 1

# Pop stashed changes if they were stashed during script execution
if $changes_stashed; then
    echo "Popping stashed changes."
    git stash pop || exit 1
fi

echo "Script execution completed successfully."
exit 0
