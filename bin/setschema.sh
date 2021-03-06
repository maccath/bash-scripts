#!/usr/bin/env bash

# Set the database schema in all environment configuration files to be prefixed with [schemaName]

# Example usage:
# ./setschema.sh [schemaName] [backup]

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

schema=${1}

# Move to directory containing all projects
cd ${project_path}

# For each directory (project)...
for d in */ ; do
    echo "${green}Switching to ${d}...${reset}"
    cd "${d}"

    if [ -e env/local/context.xml ]; then
        # Set the schema to the given schema name
        sed -i .bak -e "s/<schemaPrefix>[a-zA-Z_0-9\-]*<\/schemaPrefix>/<schemaPrefix>${schema}<\/schemaPrefix>/g" env/local/context.xml
        if [ -z "$2" ]; then
            rm env/local/context.xml.bak
        fi
        echo "Schema updated in env/local/context.xml"
    elif [ -e .env ]; then
        # Set the schema to the given schema name
        sed -i .bak -e "s/DB_DATABASE=[a-zA-Z_0-9\-]*_castle/DB_DATABASE=${schema}_castle/g" .env
        if [ -z "$2" ]; then
            rm .env.bak
        fi
        echo "Schema updated in .env"
    fi

    cd ..
done