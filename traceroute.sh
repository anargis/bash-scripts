#!/bin/bash
# Print the route packets trace to network host
# Pass the domain as an argument
# Usage: 
# chmod +x traceroute.sh
# ./traceroute.sh example.com
traceroute "$1"
