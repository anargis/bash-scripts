#!/bin/bash
# Enable strict error handling:
#  -e : exit if any command fails
#  -u : treat unset variables as errors
#  -o pipefail : fail if any command in a pipeline fails
set -euo pipefail

# === CONFIG ===
DB_USER="${DB_USER:-root}"
DB_PASS="${DB_PASS:-}"                 # leave empty if using auth_socket for root
DB_NAME="${DB_NAME:-wordpress}"

WP_DIR="${WP_DIR:-/var/www/html/wordpress}"   # your WordPress directory
# BACKUP_DIR="${BACKUP_DIR:-/backups}"           # outside WP_DIR
BACKUP_DIR="${BACKUP_DIR:-/home/zero/backups}"
DATE="$(date +"%Y-%m-%d_%H-%M-%S")"
BACKUP_NAME="wordpress_backup_${DATE}.zip"
SQL_PATH="$WP_DIR/${DB_NAME}_${DATE}.sql"

# Ensure cleanup of the SQL dump even if something fails after dump
cleanup_sql() { [[ -f "$SQL_PATH" ]] && rm -f "$SQL_PATH" || true; }
trap cleanup_sql EXIT

# === PRECHECKS ===
if [[ ! -d "$WP_DIR" ]]; then
  echo "Error: WP_DIR not found: $WP_DIR" >&2
  exit 1
fi
mkdir -p "$BACKUP_DIR"

# === EXPORT DB INTO WP DIRECTORY ===
echo "Exporting MySQL database to: $SQL_PATH"
DUMP_FLAGS="--single-transaction --quick --routines --events --triggers --hex-blob"
if [[ -z "$DB_PASS" && "$DB_USER" == "root" ]]; then
  # Likely auth_socket root@localhost
  sudo mysqldump -u root $DUMP_FLAGS "$DB_NAME" > "$SQL_PATH"
elif [[ -z "$DB_PASS" ]]; then
  mysqldump -u "$DB_USER" $DUMP_FLAGS "$DB_NAME" > "$SQL_PATH"
else
  mysqldump -u "$DB_USER" -p"$DB_PASS" $DUMP_FLAGS "$DB_NAME" > "$SQL_PATH"
fi

# === ZIP THE WHOLE WP DIRECTORY (and save OUTSIDE WP) ===
echo "Creating archive at: $BACKUP_DIR/$BACKUP_NAME"
(
  cd "$(dirname "$WP_DIR")"
  # zip contents of WP_DIR, including the freshly dumped SQL
  zip -r "$BACKUP_DIR/$BACKUP_NAME" "$(basename "$WP_DIR")" > /dev/null
)

# === CLEAN UP PLAIN SQL FROM WP DIR ===
cleanup_sql

echo "Backup completed: $BACKUP_DIR/$BACKUP_NAME"

