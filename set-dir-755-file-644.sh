#!/bin/bash
#
# Description
# Recursively sets directory permissions to 755 and file permissions to 644.
#
# Usage
# chmod u+x set-dir-755-file-644.sh && ./set-dir-755-file-644.sh

find "$1" -type d -exec chmod 755 {} \;
find "$1" -type f -exec chmod 644 {} \;
