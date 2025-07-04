#!/bin/bash
# Performs an aggressive Nmap scan (-A) on the target with faster timing (-T4),
# enabling OS detection, version detection, script scanning, and traceroute.
#
# Usage:
# chmod +x nmap.sh
# ./nmap.sh <domain or IP>

# nmap                   – Network mapping and vulnerability scanning tool
#   -A                   – Enables aggressive scan:
#                            • OS detection
#                            • Version detection
#                            • Script scanning (default NSE scripts)
#                            • Traceroute
#   -T4                  – Timing template for faster execution (0–5 scale; 4 = faster, reasonably accurate)
#   "$1"                 – First argument passed to the script (target domain or IP)

nmap -A -T4 "$1"
