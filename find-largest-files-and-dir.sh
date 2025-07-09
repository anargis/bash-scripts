#!/bin/bash
#
# Description:
# Displays the top 20 largest files and directories under a specified path.
#
# Usage:
# chmod +x find-largest-files-and-dir.sh
# ./find-largest-files-and-dir.sh /path/to/scan

# Use find to scan all files and directories starting at the provided path ($1)
# For each found item, run 'du' to get the apparent size in human-readable format,
# limiting depth to 0 so only the item itself is measured (not contents recursively)
    
find "$1" -exec du -h --apparent-size --max-depth=0 {} \; 2>/dev/null | \

    # Pipe output to sort, sorting by size in human-readable format, largest first
    sort -hr | \
    
    # Limit output to the top 20 entries
    head -n 20
