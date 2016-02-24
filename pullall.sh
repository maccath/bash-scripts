#!/usr/bin/env bash

# Example usage:
# ./pullall.sh [branchName] [branchName] ...

# Configuration file
source ./configuration.cfg

# Colours
source ./colours.cfg

# Move to directory containing all projects
cd $project_path;

# For each directory (project)
for d in */ ; do
    echo "${green}Switching to ${d}...${reset}";
    cd "$d";

    # Pull current branch
    git pull;
    original_branch= git rev-parse --abbrev-ref HEAD;

    # For each specified branch, if it exists, pull
    for b in "$@"; do
        if [ "git branch --list ${b}" ]; then
           git checkout $b;
           git pull;
        fi
    done

    # Go back to original branch
    git checkout $original_branch;

    cd ..;
done