#!/bin/bash
# Pass the domain as an argument
# Usage: 
# chmod +x nmap.sh
# ./nmap.sh example.com
nmap -A -T4 "$1"
