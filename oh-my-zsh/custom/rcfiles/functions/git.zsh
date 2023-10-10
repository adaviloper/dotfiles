#!/bin/bash

compdef g=git
TICKET_BRANCH_PREFIX="RET"

function get_ticket_prefix()
{
  current_directory="${PWD#$HOME/}"

  case "$current_directory" in
      "Code/ultimate-tic-tac-toe")
          mapped_string="UTTT"
          ;;
      "Code/loop-returns-app")
        echo "Multiple options found for Code/loop-returns-app:"
        echo "1. RET"
        echo "2. LPR"
        echo "Please select an option (1 or 2):"
        read user_choice
        case "$user_choice" in
          "1")
            mapped_string="RET"
            ;;
          "2")
            mapped_string="LPR"
            ;;
          *)
            mapped_string="Unknown option"
            ;;
        esac
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
  printf "%q" $(git_current_branch) | sed "s/.*$(get_ticket_prefix)-\([0-9]*\).*/\1/"
}

function git_commit_prefix()
{
  echo "[$(get_ticket_prefix)-$(ticket_number)] -"
}
