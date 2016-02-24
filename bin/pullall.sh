#!/usr/bin/env bash

# Example usage:
# ./pullall.sh [branchName] [branchName] ...

# Parent path
parent_path=$( cd "$(dirname "${BASH_SOURCE}")" ; pwd -P )

# Configuration file
source ${parent_path}/../etc/configuration.cfg

# Colours
source ${parent_path}/../etc/colours.cfg

# Move to directory containing all projects
cd ${project_path}

# For each directory (project)
for d in */ ; do
    echo "${green}Switching to ${d}...${reset}"
    cd "${d}"

    # Remember our place
    original_branch=$(git rev-parse --abbrev-ref HEAD)
    checked_out=false

    # Pull current branch
    git pull

    # For each specified branch...
    for b in "$@"; do
        # As long as it's not the original branch...
        if ! [[ "${original_branch}" == "${b}" ]]; then
            # If the branch exists...
            if [[ $(git branch --list ${b}) ]]; then
                # Check it out...
                status=$(git checkout ${b})
                checked_out=true

                # And if it's not up to date...
                if ! [[ "${status}" == *"is up-to-date with"* ]]; then
                    # Pull
                    git pull
                fi
            fi
        fi
    done

    # Go back to original branch, if we were switched from it
    if [ "${checked_out}" == true ]; then
        git checkout ${original_branch}
    fi

    cd ..
done