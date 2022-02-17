#!/bin/bash

compdef g=git

function g {
  if [[ $# -gt 0 ]]; then
    git "$@"
  else
    git status --short
  fi
}

function clean_local_branches () {
  git fetch -p && for branch in `git branch -vv | grep ': gone]' | awk '{print $1}'`; do git branch -D $branch; done
}

function fco () {
  grepped_branches=$(git branch | grep "$1" | sed 's/*//')
  eval "branches=($grepped_branches)"
  branch_count=${#branches[*]}
  if (( $branch_count == 0 )); then
    echo "No matching branches found"
  elif (( $branch_count == 1 )); then
    gco "${branches[1]}"
  else
    select branch in $branches
    do
      gco $branch
      break
    done
  fi
}
