#!/bin/bash
#
# Description:
# Compare two files side-by-side with color highlighting of only the actual differences,
# using icdiff with line numbers and full terminal width.
#
# Usage:
#   chmod +x icdiff.sh
#   ./icdiff.sh <file1> <file2>
#
# Example:
#   ./icdiff.sh 1.csv 2.csv

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <file1> <file2>"
  exit 1
fi

FILE1="$1"
FILE2="$2"

if ! command -v icdiff &>/dev/null; then
  echo "Error: icdiff is not installed. Install with: sudo apt install icdiff"
  exit 1
fi

icdiff --line-numbers --cols="$(tput cols)" "$FILE1" "$FILE2"
