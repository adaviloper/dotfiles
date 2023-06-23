#!/bin/bash

compdef g=git
TICKET_BRANCH_PREFIX="RET"

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

function bug()
{
  ticket_branch 'bugfix' $1 $2
}

function epic()
{
  ticket_branch 'epic' $1 $2
}

function merge()
{
  local branch=$(select_from_matching_branches $1)
  gcb "merge/$(git_current_branch)_WITH_${branch}_$(date +"%Y-%m-%d")"
}

function revert()
{
  ticket_branch 'revert' $1 $2
}

function spike()
{
  ticket_branch 'spike' $1 $2
}

function story()
{
  ticket_branch 'story' $1 $2
}

function task()
{
  ticket_branch 'task' $1 $2
}

function ticket_branch()
{
  gcb "$1/$TICKET_BRANCH_PREFIX-$2-${3// /-}"
}

function copy_branch()
{
  gcb "$(git_current_branch)_WITH_PLATFORM_CPE"
}

function ticket_number()
{
  printf "%q" $(git_current_branch) | sed "s/.*$TICKET_BRANCH_PREFIX-\([0-9]*\).*/\1/"
}

function git_commit_prefix()
{
  echo "[$TICKET_BRANCH_PREFIX-$(ticket_number)] -"
}
