#!/usr/bin/env bash

# Example usage:
# ./listmigrations.sh "[author]" [database] [branch] [date]

# Parent path
parent_path=$( cd "$(dirname "${BASH_SOURCE}")" ; pwd -P )

# Configuration file
source ${parent_path}/../etc/configuration.cfg

# Capture arguments
author="$1"
db="$2"
branch="$3"
date="$4"

# Ask what output format
echo "What format would you like the results displayed in?"
read format

# If no format specified, use plain
if [ -z "${format}"]; then
    format="plain"
fi

# If date specified, use it
if [ "${date}"]; then
    since="--since="${date}
fi

# Move to project containing DB migrations
cd ${db_migrations_path}

# Log migrations
git log --pretty=format:"%s" --name-only --no-merges --author="${author}" ${since} ${branch} migrations/${db} | php -f ${parent_path}/listmigrations/listmigrations.php -q ${db} ${branch} ${format} ${db_migrations_path}