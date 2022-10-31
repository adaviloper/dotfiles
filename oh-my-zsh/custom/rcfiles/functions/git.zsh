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

function select_from_matching_branches()
{
  grepped_branches=$(git branch ${@:2} | grep "$1" | sed 's/*//')
  eval "branches=($grepped_branches)"
  branch_count=${#branches[*]}
  if (( $branch_count == 0 )); then
    echo $1
  elif (( $branch_count == 1 )); then
    echo "${branches[1]}"
  else
    select branch in $branches
    do
      echo $branch
      break
    done
  fi
}

function gco () {
  if [[ "$1" == "-" ]]; then
    git checkout $1
    return
  else
    local branch=$(select_from_matching_branches $1)
    gco $branch
  fi
}
