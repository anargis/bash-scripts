#!/bin/bash
# Identifies technologies used by the target website—including server, CMS, frameworks, analytics, and more—with verbose output for detailed plugin results.
# Pass the domain as an argument
# Usage: 
# chmod +x whatweb.sh
# ./whatweb.sh example.com
whatweb -v "$1"

