#!/bin/bash
#
# Get CPU temperature and watch it every 2 seconds
#
# Usage: 
# chmod +x sensors.sh
# ./sensors.sh

watch -n 2 "sensors | grep -i 'core\|package'"