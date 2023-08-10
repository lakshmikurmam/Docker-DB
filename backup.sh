#!/bin/bash

# Create a backups directory if it doesn't exist
mkdir -p /app11/sqllitemqtt/backups

# Backup the SQLite database
cp /app11/sqllitemqtt/data.db /app11/sqllitemqtt/backups/data-backup.db
echo "SQLite database backed up"

#################################3

