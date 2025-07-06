#!/bin/bash
#
# Lists the 20 largest files within a given directory (e.g., /home)
#
# Usage:
#   chmod +x find-largest-files.sh
#   ./find-largest-files.sh <directory>
#
# find "$1" -type f -exec du -h {} +
#   - find "$1"                    Searches in the directory passed as the first argument ($1)
#   - -type f                      Limits the search to regular files only (not directories)
#   - -exec du -h {} +             For each file found, run `du -h`:
#         du                       Disk usage tool
#         -h                       Human-readable sizes (e.g., 1K, 234M, 2G)
#         {} +                     Replaces `{}` with batches of file paths (more efficient than running one-by-one)
#
# | sort -rh
#   - sort                         Sorts lines of text
#   - -r                           Reverse order (largest to smallest)
#   - -h                           Interprets human-readable sizes correctly (e.g., 2G > 100M)
#
# | head -n 20
#   - head                         Displays only the first N lines
#   - -n 20                        Shows the top 20 largest files

find "$1" -type f -exec du -h {} + | sort -rh | head -n 20
