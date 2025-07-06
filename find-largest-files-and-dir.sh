#!/bin/bash
#
# Displays the top 20 largest files and directories
#
# Usage:
#   chmod +x find-largest-files-and-dir.sh
#   ./find-largest-files-and-dir.sh /path/to/scan
#
# - find "$1"                        Scans all files and directories under the given path
# - -exec du -h --apparent-size      For each found item, runs 'du' to report size
# - --max-depth=0                    Ensures 'du' reports size only for the item itself, not its contents
# - {} \;                            Placeholder for the current item found by 'find'
# - 2>/dev/null                      Hides error messages (like permission denied)
# - sort -hr                         Sorts the output in reverse order, human-readable (largest first)
# - head -n 20                       Shows only the top 20 largest entries

find "$1" -exec du -h --apparent-size --max-depth=0 {} \; 2>/dev/null | sort -hr | head -n 20
