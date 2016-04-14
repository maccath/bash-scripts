#!/usr/bin/env bash

# Example usage:
# ./setschema.sh [schemaName]

# Parent path
parent_path=$( cd "$(dirname "${BASH_SOURCE}")" ; pwd -P )

# Configuration file
source ${parent_path}/../etc/configuration.cfg

# Colours
source ${parent_path}/../etc/colours.cfg

schema=${1}

# Move to directory containing all projects
cd ${project_path}

# For each directory (project)...
for d in */ ; do
    echo "${green}Switching to ${d}...${reset}"
    cd "${d}"

    if [ -e env/local/context.xml ]; then
        # Set the schema to the given schema name
        sed -i -e "s/<schemaPrefix>[a-zA-Z_0-9]*<\/schemaPrefix>/<schemaPrefix>${schema}<\/schemaPrefix>/g" env/local/context.xml
    fi

    cd ..
done