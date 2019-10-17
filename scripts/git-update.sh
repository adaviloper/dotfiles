#! /bin/bash

declare -a REPOSITORIES=(
  #"admin-product"
  #"billing-api"
  "onlinemeded"
)

declare -a BRANCHES=(
  "master"
  "staging"
  "dev"
)
STASHED=false

for repository in "${REPOSITORIES[@]}"
  do
    cd ~/Code/$repository;
    CHANGES_EXIST=$(git diff-index --quiet HEAD -- || echo "changed")
    if [ "$CHANGES_EXIST" == "changed" ]
    then
      #git stash push
      STASHED=true
    fi

    git fetch --all --prune;
    echo "Navigated to $repository";
    for branch in "${BRANCHES[@]}"
      do 
        echo "Checking out $branch";
        git checkout $branch
        git pull;
        git checkout -
      done
    git stash apply
    STASHED=false
  done
