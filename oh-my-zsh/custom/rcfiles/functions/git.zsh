#!/bin/bash

compdef g=git
TICKET_BRANCH_PREFIX="RET"

function get_ticket_prefix()
{
  current_directory="${PWD#$HOME/}"

  PS3="Select a prefix: "
  case "$current_directory" in
      "Code/ultimate-tic-tac-toe")
          mapped_string="UTTT"
          ;;
      "Code/figs-recycling-campaign")
          mapped_string="LPR"
          ;;
      "Code/figs-recycling-campaign/logistics")
          mapped_string="LPR"
          ;;
      "Code/figs-recycling-campaign/infra")
          mapped_string="LPR"
          ;;
      "Code/loop-returns-app")
        # eval "prefixes=(RET LPR)"
        mapped_string=$(gum choose "RET" "LPR")
        
        # select prefix in $prefixes
        # do
        #   echo $prefix
        #   break
        # done
        ;;
      *)
          mapped_string="Unknown directory"
          ;;
  esac

  echo "$mapped_string"
}

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
  grepped_branches=$(git branch ${@:2} | grep "$1" | sed 's/^[[:space:]]*[*]*//' | gum choose --select-if-one | sed 's/^[[:space:]]*[*]*//')
  echo $grepped_branches
}

function gco () {
  if [[ "$1" == "-" ]]; then
    git checkout -
    return
  else
    local branch=$(select_from_matching_branches $1)
    git checkout $branch
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
  ticket_branch 'feature' $1 $2
}

function task()
{
  ticket_branch 'task' $1 $2
}

function ticket_branch()
{
  gcb "$1/$(get_ticket_prefix)-$2-${3// /-}"
}

function copy_branch()
{
  gcb "$(git_current_branch)_WITH_PLATFORM_CPE"
}

function ticket_number()
{
  echo $(git_current_branch) | grep -e '[A-Z]*-[0-9]*' -ow
}

function git_commit_prefix()
{
  echo "[$(ticket_number)] -"
}
