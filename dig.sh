#!/bin/bash
#
# Description:
# Retrieves detailed DNS information for a specified domain using `dig`.
#
# Usage: 
#   chmod +x dig.sh
#   ./dig.sh <domain>

# Run dig on the provided domain:
#   - "$1"             Domain passed as an argument
#   - ANY              Request all available DNS record types (A, MX, TXT, etc.)
#   - +trace           Traces the DNS resolution path from root servers to the authoritative server
#   - +dnssec          Requests DNSSEC-related data to verify domain integrity and authenticity

dig "$1" ANY +trace +dnssec
