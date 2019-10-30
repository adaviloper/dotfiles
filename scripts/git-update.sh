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
    echo "----------------------------";
    echo "- Navigated to $repository -";
    echo "----------------------------";
    echo ""

    CHANGES_EXIST=$(git diff-index --quiet HEAD -- || echo "changed")
    if [[ "$CHANGES_EXIST" == "changed" ]]
    then
      STASHED=true
      echo "--------------------"
      echo "- Stashing changes -"
      echo "--------------------"
      echo ""
      git stash push
    fi

    git fetch --all --prune;
    for branch in "${BRANCHES[@]}"
      do 
        git checkout $branch
        echo "-----------------------";
        echo "- Checked out $branch -";
        echo "-----------------------";
        echo ""
        git pull
        git checkout -
      done

    if [[ $STASHED ]]
    then
      git stash pop
      echo "-----------------"
      echo "- Applied stash -"
      echo "-----------------"
      echo ""
      STASHED=false
    fi
  done
