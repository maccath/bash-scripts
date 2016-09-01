#!/usr/bin/env bash

# Example usage:
# ./fetchall.sh

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