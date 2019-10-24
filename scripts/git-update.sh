#! /bin/bash

declare -a REPOSITORIES=(
  "admin-product"
  "billing-api"
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
    echo "\nNavigated to $repository";

    CHANGES_EXIST=$(git diff-index --quiet HEAD -- || echo "changed")
    if [[ "$CHANGES_EXIST" == "changed" ]]
    then
      STASHED=true
      echo "\nStashing changes"
      git stash push
    fi

    git fetch --all --prune;
    for branch in "${BRANCHES[@]}"
      do 
        git checkout $branch
        echo "\nChecked out $branch";
        git pull;
        git checkout -
      done

    if [[ $STASHED ]]
    then
      git stash pop
      echo "\n Applied stash"
      STASHED=false
    fi
  done
