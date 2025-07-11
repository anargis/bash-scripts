#!/bin/bash
#
# Description:
# Newsboat RSS Reader
#
# Usage:
# chmod +x newsboat.sh
# ./newsboat.sh
#

# Check if `newsboat` is installed and available in the system's PATH.
command -v newsboat >/dev/null || {
  echo "Newsboat is not installed. Please install it with: sudo apt install newsboat"
  exit 1
}
# Check if the Hellenic Linux User Group Planet RSS feed URL
# is already present in Newsboat's URLs file to avoid duplicates.
grep -qxF "https://planet.hellug.gr/atom.xml" "$HOME/.newsboat/urls" || \
  echo "https://planet.hellug.gr/atom.xml" >> "$HOME/.newsboat/urls"

# Launch Newsboat with the configured feed URLs.
newsboat