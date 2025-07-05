#!/bin/bash
#
# Get public IP and Tor IP using torsocks
#
# Usage: 
# chmod +x torsocks.sh

echo "public ip:" && curl https://icanhazip.com && echo "tor ip:" && torsocks curl https://icanhazip.com
