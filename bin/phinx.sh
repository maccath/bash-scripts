#!/usr/bin/env bash

# Example usage:
# ./phinx.sh [database] [migrationName]

# Parent path
if [ -z ${BASH_SOURCE} ]; then
    parent_path=$( cd "$(dirname "${(%):-%N}")" ; pwd -P )
else
    parent_path=$( cd "$(dirname "${BASH_SOURCE}")" ; pwd -P )
fi

# Configuration file
source ${parent_path}/../etc/configuration.cfg

# Move to project containing DB migrations
cd ${db_migrations_path}

# Create new DB migration
vendor/bin/phinx create -c ${1}.php ${2};