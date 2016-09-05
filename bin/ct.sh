#!/usr/bin/env bash

# Example usage
# . ./ct.sh [projectName]

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

projects=$(ls -d ${project_path}/${trimmed}*) 2> /dev/null

if [ -z ${projects} ]; then
    echo "${red}Project not found${reset}"
else
    project=$(ls -d ${project_path}/${trimmed}* | head -n1)
fi

if [ -d ${project} ]; then
    cd ${project}
else
    echo "${red}Project not found${reset}"
fi