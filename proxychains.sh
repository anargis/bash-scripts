#!/bin/bash
# Get public IP and Tor IP using proxychains
# Pass the domain as an argument
# Usage: 
# chmod +x proxychains.sh
# ./proxychains.sh example.com
echo "public ip:" && curl https://icanhazip.com && echo "tor ip:" && proxychains curl https://icanhazip.com
