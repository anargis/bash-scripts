#!/bin/bash
# Performs an aggressive Nmap scan (-A) on the target with faster timing (-T4), enabling OS detection, version detection, script scanning, and traceroute.
# Pass the domain as an argument
# Usage: 
# chmod +x nmap.sh
# ./nmap.sh example.com
nmap -A -T4 "$1"
