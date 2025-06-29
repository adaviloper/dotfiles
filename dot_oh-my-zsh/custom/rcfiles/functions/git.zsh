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

function merge()
{
  local branch=$(select_from_matching_branches $1)
  gcb "merge/$(git_current_branch)_WITH_${branch}_$(date +"%Y-%m-%d")"
}

function copy_branch()
{
  gcb "$(git_current_branch)_WITH_PLATFORM_CPE"
}
