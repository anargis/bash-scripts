#!/bin/bash
#
# Description:
# Performs an aggressive WordPress security scan on the target URL, 
# enumerating users, all plugins/themes, backup files, and exports,
# using a random user-agent and API token, while forcing detection and skipping TLS checks.
#
# Get your free WPScan API key at: https://wpscan.com/profile/
#
# Usage:
# chmod +x wpscan.sh
# ./wpscan.sh http://target.url your_api_key

# wpscan                        – WordPress vulnerability scanner
#   --url "$1"                  – Target URL to scan (passed as the first script argument)
#   --enumerate u,ap,at,cb,dbe,tt
#                               – Enumerates:
#                                   u   = users
#                                   ap  = all plugins
#                                   at  = all themes
#                                   cb  = config backups
#                                   dbe = database exports
#                                   tt  = timthumb files
#   --api-token "$2"            – Uses your WPScan API token (passed as second argument)
#   --detection-mode aggressive – Enables aggressive detection mode (more accurate, more requests)
#   --random-user-agent         – Randomizes the User-Agent header to bypass basic bot protections
#   --plugins-detection aggressive
#                               – Enables aggressive plugin detection (more in-depth)
#   --disable-tls-checks        – Skips TLS/SSL certificate validation (useful for localhost/self-signed)
#   --format cli-no-color       – Outputs plain CLI text with no color (good for logging)
#   --force                     – Forces scan even if WPScan thinks the target isn’t WordPress

wpscan --url "$1" \
  --enumerate u,ap,at,cb,dbe,tt \
  --api-token "$2" \
  --detection-mode aggressive \
  --random-user-agent \
  --plugins-detection aggressive \
  --disable-tls-checks \
  --format cli-no-color \
  --force
