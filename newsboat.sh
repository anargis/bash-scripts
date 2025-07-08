#!/bin/bash
#
# Newsboat RSS Reader
#
# Usage:
#   chmod +x newsboat.sh
#   ./newsboat.sh
#
# command -v newsboat >/dev/null
#   - Checks if `newsboat` executable is available in the system's PATH.
#   - Returns success (0) if found, failure (non-zero) if not.
#
# || { echo "..."; exit 1; }
#   - If `newsboat` is not found, prints an installation advice message.
#   - Exits the script immediately with status 1.
#
# grep -qxF "https://planet.hellug.gr/atom.xml" "$HOME/.newsboat/urls"
#   - Searches the urls file for an exact match of the given URL.
#   - -q suppresses output, -x matches whole line, -F matches fixed string (not regex).
#
# || echo "https://planet.hellug.gr/atom.xml" >> "$HOME/.newsboat/urls"
#   - If the URL is NOT found in the file, appends it to avoid duplicates.
#
# newsboat
#   - Starts the Newsboat RSS reader with the configured feed URLs.
# 
# Manage your rss links in `~/.newsboat/urls` file.
#

command -v newsboat >/dev/null || { echo "Newsboat is not installed. Please install it with: sudo apt install newsboat"; exit 1; }; grep -qxF "https://planet.hellug.gr/atom.xml" "$HOME/.newsboat/urls" || echo "https://planet.hellug.gr/atom.xml" >> "$HOME/.newsboat/urls" && newsboat
