#!/usr/bin/env bash

# Example usage
# . ./delete_merged.sh [projectName]

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

# Trim trailing slashes
trimmed=$(echo ${1} | sed 's:/*$::')

# Get the project
project=$(ls -d ${project_path}/${trimmed}* | head -n1)

if [ -d ${project} ]; then
    cd ${project}
    echo "${yellow}The following branches in the ${project} repo are merged into master: ${reset}"
    git branch -r --merged | grep -v master | sed 's/origin\///' | xargs -n 1 echo
else
    echo "${red}Project not found${reset}"
fi

echo "${yellow}Which branches should I delete?${reset}"
echo "${blue}Enter each branch on a new line and press ctrl+d when done.${reset}"

branches=$(cat)

if [ -z "${branches}" ]; then
    echo "${red}No branches specified for deletion${reset}"
else
    echo ${branches} | xargs -n 1 git push --delete origin
fi