#!/bin/bash
#
# Description:
# Translates text into the specified target language using Translate Shell (trans).
#
# Usage: 
#   chmod +x translate.sh
#   ./translate.sh <lang> "<text>"
#
# Example:
#   ./translate.sh el "Hello, how are you?"
#

trans :"$1" "$2"
