#!/usr/bin/env bash

# Example usage:
# ./fetchall.sh

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
        git fetch
    fi

    cd ..
done