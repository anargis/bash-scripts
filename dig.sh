#!/bin/bash
# Get DNS information
# Usage: 
# chmod +x dig.sh
# ./dig.sh <domain>
dig "$1" ANY +trace +dnssec 
