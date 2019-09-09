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

for repository in "${REPOSITORIES[@]}"
  do
    cd ~/Code/$repository;
    git fetch --all --prune;
    echo "Navigated to $repository";
    for branch in "${BRANCHES[@]}"
      do 
        echo "Checking out $branch";
        git checkout $branch
        git pull;
      done
  done
