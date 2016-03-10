#!/usr/bin/env bash

# Example usage:
# ./listmigrations.sh "[author]" [database] [branch]

# Parent path
parent_path=$( cd "$(dirname "${BASH_SOURCE}")" ; pwd -P )
author="$1"
db="$2"
branch="$3"

# Configuration file
source ${parent_path}/../etc/configuration.cfg

# Move to project containing DB migrations
cd ${db_migrations_path}

# Create new DB migration
git log --pretty=format:"%s" --name-only --no-merges --author="${author}" ${branch} migrations/${db} | php -f ${parent_path}/listmigrations/listmigrations.php -q ${db} | grep -v '^$' | uniq