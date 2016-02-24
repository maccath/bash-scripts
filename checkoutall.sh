#!/usr/bin/env bash

# Example usage:
# ./checkoutall.sh [branchName]

# Configuration file
source ./configuration.cfg

# Colours
source ./colours.cfg

# Move to directory containing all projects
cd $project_path;

# For each directory (project)...
for d in */ ; do
    echo "${green}Switching to ${d}...${reset}";
    cd "$d";

    # If the branch exists...
    if [[ $(git branch --list $1) ]]; then
        # Check it out
        status=$(git checkout $1);
        echo $status;

        # And if it's not up to date...
        if ! [[ "${status}" == *"is up-to-date with"* ]]; then
            # Pull
            git pull;
        fi
    else
        echo "Branch does not exist for this repository";
    fi

    cd ..;
done