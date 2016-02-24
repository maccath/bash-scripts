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

    # Remember our place
    original_branch=$(git rev-parse --abbrev-ref HEAD);
    checked_out=false;

    # Pull current branch
    git pull;

    # For each specified branch, if it exists, pull
    for b in "$@"; do
        if ! [[ "${original_branch}" == "${b}" ]]; then
            if [[ $(git branch --list $b) ]]; then
                status=$(git checkout $b);
                checked_out=true;

                if ! [[ "${status}" == *"is up-to-date with"* ]]; then
                    git pull;
                fi
            fi
        fi
    done

    # Go back to original branch, if we were switched from it
    if [ "$checked_out" == true ]; then
        git checkout $original_branch;
    fi

    cd ..;
done