#!/bin/bash
#
# Description:
# Get public IP and Tor IP using proxychains
#
# Usage: 
# chmod +x proxychains.sh
# ./proxychains.sh

echo "public ip:"
curl https://icanhazip.com
echo "tor ip:"
proxychains curl https://icanhazip.com