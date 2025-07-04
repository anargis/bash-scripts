#!/bin/bash
# Get DNS information
# Pass the domain as an argument
# Usage: 
# chmod +x dig.sh
# ./dig.sh example.com
dig "$1" ANY +trace +dnssec 
