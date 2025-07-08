#!/bin/bash
#
# Newsboat RSS Reader
#
# Usage:
#   chmod +x newsboat.sh
#   ./newsboat.sh
#
# command -v newsboat >/dev/null
#   - Checks if `newsboat` is available in the system's PATH.
#   - If it is, the command returns success; otherwise, it triggers the fallback.
#
# || { echo "..."; exit 1; }
#   - If `newsboat` is not found, prints a message advising how to install it and exits the script.
#
# echo "https://planet.hellug.gr/atom.xml" >> "$HOME/.newsboat/urls"
#   - Appends the specified RSS feed URL to the user's Newsboat configuration file.
#   - Creates the file if it doesn't exist.
#
# newsboat
#   - Launches the Newsboat RSS reader interface in the terminal.

command -v newsboat >/dev/null || { echo "Newsboat is not installed. Please install it with: sudo apt install newsboat"; exit 1; }; echo "https://planet.hellug.gr/atom.xml" >> "$HOME/.newsboat/urls" && newsboat

