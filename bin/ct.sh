#!/usr/bin/env bash

# Example usage
# . ./ct.sh [projectName]

# Parent path
parent_path=$( cd "$(dirname "${BASH_SOURCE}")" ; pwd -P )

# Configuration file
source $parent_path/../etc/configuration.cfg

project=$(ls -d $project_path$1* | head -n1);

if [ "-d ${project}" ]; then
    cd $project;
else
    echo "Project not found"
fi