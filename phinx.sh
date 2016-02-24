#!/usr/bin/env bash

# Example usage:
# ./phinx.sh [database] [migrationName]

# Configuration file
source ./configuration.cfg

# Move to project containing DB migrations
cd $db_migrations_path;

# Create new DB migration
vendor/bin/phinx create -c $1.php $2;