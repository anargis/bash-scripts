#!/bin/bash
# WPScan - WordPress Security Scanner
# Pass the domain and the key as an argument
# Get the API key from https://wpscan.com/profile/
# Usage:
# chmod +x wpscan.sh
# ./wpscan.sh http://target.url your_api_key

wpscan --url "$1" \
  --enumerate u,ap,at,cb,dbe,tt \
  --api-token "$2" \
  --detection-mode aggressive \
  --random-user-agent \
  --plugins-detection aggressive \
  --disable-tls-checks \
  --format cli-no-color \
  --force
