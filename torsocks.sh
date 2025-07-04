#!/bin/bash
# Get public IP and Tor IP using torsocks
# Pass the domain as an argument
# Usage: 
# chmod +x torsocks.sh
echo "public ip:" && curl https://icanhazip.com && echo "tor ip:" && torsocks curl https://icanhazip.com
