#!/usr/bin/env bash

# Deploy [feature] to [server] using [branch] of [repos]
# Example usage:
# ./deploy.sh [feature] [server] [branch] [repos]

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

# Feature branch
feature=$1

# Server
server=$2

# Git branch
branch=$3

# Move to directory containing all projects
cd ${project_path}

# For each repo we want to deploy
for project in "${@:4}"; do
    # Move to the project directory
    cd ${project_path}/${project}.*

    # Check if git repo
    if [ -e .git ]; then
        # If the branch exists...
        if ! [[ $(git branch --list ${branch}) ]]; then
            status=$(git checkout ${branch} 2>&1)

            if [[ "${status}" == *"did not match"* ]]; then
                branch="master"
            fi
        fi
    fi

    # Move to deploy repository
    cd ${deploy_path}

    # Deploy
    echo "${green}Deploying ${project}:${branch} on ${server}:${feature} ${reset}"
    cap ${project}:${server} deploy -S feature=${feature} -S branch=${branch}
done