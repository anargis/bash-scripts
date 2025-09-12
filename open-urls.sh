#!/bin/bash
#
# Description:
# Opens a predefined list of URLs in the default browser. 
# Detects the correct open command depending on the operating system (macOS or Linux).
#
# Usage:
# chmod +x open_urls.sh
# ./open_urls.sh
#
# Notes:
# - Modify the 'urls' array to add or remove links.
# - Currently supports macOS and Linux.

# Detect open command based on OS
if [[ "$OSTYPE" == "darwin"* ]]; then
  open_cmd="open"         # macOS
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  open_cmd="xdg-open"     # Linux
else
  echo "Unsupported OS: $OSTYPE"
  exit 1
fi

# List of URLs
urls=(
  "https://gmail.com"
  "https://github.com"
  "https://slack.com"
  "https://asana.com"
)

# Open each URL in the background
for url in "${urls[@]}"
do
  "$open_cmd" "$url" >/dev/null 2>&1 &
done
