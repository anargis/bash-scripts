#!/bin/bash
#
# Description:
# Check directories and files permissions
#
# Usage: 
#   chmod +x check-perm.sh
#   ./check-perm.sh 

WWW="www"

# Folders without 755
find "$WWW" -type d ! -perm 755 > "$WWW/wrong_dirs.txt"

# Files without 644
find "$WWW" -type f ! -perm 644 > "$WWW/wrong_files.txt"

# Anything that is world-writable (dangerous)
find "$WWW" -perm -o+w > "$WWW/world_writable.txt"

# Quick summary
wc -l "$WWW"/wrong_*.txt 2>/dev/null; wc -l "$WWW/world_writable.txt" 2>/dev/null
