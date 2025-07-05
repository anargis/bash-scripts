#!/bin/bash
#
# Identifies technologies used by the target website—including server, CMS, frameworks, analytics, and more—with verbose output for detailed plugin results.
#
# Usage: 
# chmod +x whatweb.sh
# ./whatweb.sh <domain>

whatweb -v "$1"

