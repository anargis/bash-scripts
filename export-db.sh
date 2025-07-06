#!/bin/bash
#
# Export a full MySQL database backup with all options.
#
# Usage:
#   chmod +x export-db.sh
#   ./export-db.sh username password database_name
#
# mysqldump -u "$1" -p"$2"            Use the provided username and password for authentication
# --add-drop-database                  Include DROP DATABASE statements before creating databases
# --add-drop-table                     Include DROP TABLE statements before recreating tables
# --routines                          Include stored procedures and functions
# --events                            Include scheduled events
# --triggers                          Include triggers associated with tables
# --single-transaction                Perform dump in a single transaction for consistency
# --quick                            Dump tables row by row to reduce memory usage
# --lock-tables=false                 Do not lock tables during dump
# --databases "$3"                   Specify the database to export
# > "${3}_full_backup.sql"            Redirect output to a backup SQL file named after the database

mysqldump -u "$1" -p"$2" --add-drop-database --add-drop-table --routines --events --triggers --single-transaction --quick --lock-tables=false --databases "$3" > "${3}_full_backup.sql"
