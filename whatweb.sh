#!/bin/bash
# Pass the domain as an argument
# Usage: 
# chmod +x whatweb.sh
# ./whatweb.sh example.com
sudo apt install -y whatweb && whatweb "$1"
