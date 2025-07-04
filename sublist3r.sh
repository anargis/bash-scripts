#!/bin/bash
# Get subdomains for a domain
# Pass the domain as an argument
# Usage: 
# chmod +x sublist3r.sh
# ./sublist3r.sh example.com
sublist3r -d "$1"