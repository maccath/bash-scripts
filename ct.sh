#!/usr/bin/env bash

# Example usage
# . ./ct.sh [projectName]

# Configuration file
source ./configuration.cfg

project=$(ls -d $project_path$1* | head -n1);

if [ "-d ${project}" ]; then
    cd $project;
else
    echo "Project not found"
fi