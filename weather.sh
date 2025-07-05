#!/bin/bash
# Fetches a concise one-line weather summary for the specified city using wttr.in.
#
# Usage:
#   chmod +x weather.sh
#   ./weather.sh <city>
#
# curl
#   → Command-line tool for transferring data with URLs (HTTP request)
#
# wttr.in/"$1"?format=3
#   - Queries the wttr.in weather service for the city name passed as the first argument ($1)
#   - "$1" is the first positional parameter (city name)
#   - ?format=3 requests output in a compact one-line format:  
#       Location: Weather condition emoji Temperature  

curl -s "wttr.in/$1?format=3"
