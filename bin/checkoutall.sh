#!/usr/bin/env bash

# Example usage:
# ./checkoutall.sh [branchName] [localOnly]

# Parent path
if [ -z ${BASH_SOURCE} ]; then
    parent_path=$( cd "$(dirname "${(%):-%N}")" ; pwd -P )
else
    parent_path=$( cd "$(dirname "${BASH_SOURCE}")" ; pwd -P )
fi

# Configuration file
source ${parent_path}/../etc/configuration.cfg

# Colours
source ${parent_path}/../etc/colours.cfg

# Local branches only?
localOnly=${2}

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
            if [[ -z ${localOnly} ]]; then
                status=$(git checkout ${1} 2>&1)

                if [[ "${status}" == *"did not match"* ]]; then
                    echo "Remote branch does not exist for this repository"
                fi
            else
                echo "Local branch does not exist for this repository"
            fi
        fi
    fi

    cd ..
done