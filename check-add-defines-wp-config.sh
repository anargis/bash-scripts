#!/usr/bin/env bash
set -euo pipefail

FILE="${1:-wp-config.php}"

if [[ ! -f "$FILE" ]]; then
  echo "Error: $FILE not found" >&2
  exit 1
fi

# Lines (comments + defines) to ensure exist
LINES=(
"// Disable Plugin and Theme Editor"
"define('DISALLOW_FILE_EDIT', true);"
""
"// Disable Installation & Update of Plugin and Theme"
"define('DISALLOW_FILE_MODS', true);"
""
"// Disable all automatic updates (core, plugins, themes)"
"define( 'AUTOMATIC_UPDATER_DISABLED', true );"
"define( 'WP_AUTO_UPDATE_CORE', false );"
""
"// Enable WordPress debugging mode (for development)"
"define('WP_DEBUG', false);"
""
"// Log errors to the /wp-content/debug.log file"
"define('WP_DEBUG_LOG', false);"
""
"// Disable displaying errors on the frontend"
"define('WP_DEBUG_DISPLAY', false);"
"")

MARKER="\/\* That's all, stop editing! Happy publishing\. \*\/"

for line in "${LINES[@]}"; do
  # skip empty lines (we’ll add them with the echo below)
  [[ -z "$line" ]] && continue

  if ! grep -qF "$line" "$FILE"; then
    echo "Adding: $line"
    # Insert before the marker comment
    sed -i "/$MARKER/i $line" "$FILE"
  else
    echo "Exists: $line"
  fi
done
