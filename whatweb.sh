#!/bin/bash
# Get technologies used by the target website
# Pass the domain as an argument
# Usage: 
# chmod +x whatweb.sh
# ./whatweb.sh example.com
whatweb -v "$1"

