#!/bin/bash
#
# Description:
# Uptime monitor for a given website URL.
# Periodically checks if a site is reachable. Logs downtime events to a file.
#
# Usage:
# chmod u+x uptime.sh && ./uptime.sh <domain>
# ./uptime.sh https://example.com

URL="$1"
# Assigns the first argument passed to the script as the target URL to check.

LOG="uptime.log"
# Specifies the name of the log file where downtime will be recorded.

while true; do
  # Infinite loop to continuously check the site every 60 seconds.

  echo "$(date +"%Y-%m-%d %H:%M:%S") - checking $URL..."
  # Prints a timestamped message to indicate the URL is being checked.

  if ! wget -q --spider "$URL"; then
    # Uses `wget` in silent mode to check if the URL is reachable.
    # `--spider` makes a HEAD request without downloading content.
    # The `!` negates the result; it triggers the block if the URL is unreachable.

    echo "$(date +"%Y-%m-%d %H:%M:%S") - DOWN: $URL" >> "$LOG"
    # If the site is down, logs the timestamp and URL to `uptime.log`.
  fi

  sleep 60
  # Waits 60 seconds before checking the site again.

done

