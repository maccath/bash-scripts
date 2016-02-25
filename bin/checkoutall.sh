#!/usr/bin/env bash

# Example usage:
# ./checkoutall.sh [branchName]

# Parent path
parent_path=$( cd "$(dirname "${BASH_SOURCE}")" ; pwd -P )

# Configuration file
source ${parent_path}/../etc/configuration.cfg

# Colours
source ${parent_path}/../etc/colours.cfg

# Move to directory containing all projects
cd ${project_path}

# For each directory (project)...
for d in */ ; do
    echo "${green}Switching to ${d}...${reset}"
    cd "${d}"

    if [ -e .git ]; then
        # If the branch exists...
        if [[ $(git branch --list ${1}) ]]; then
            # Check it out
            status=$(git checkout ${1})
            echo ${status}

            # And if it's not up to date...
            if ! [[ "${status}" == *"is up-to-date with"* ]]; then
                # Pull
                git pull
            fi
        else
            if [[ ${2} == "force" ]]; then
                status=$(git checkout ${1} 2>&1)

                if [[ "${status}" == *"did not match"* ]]; then
                    echo "Branch does not exist for this repository"
                fi
            else
                echo "Branch does not exist for this repository"
            fi
        fi
    fi

    cd ..
done