#!/bin/bash
#
# Description:
# Get CPU temperature and monitor it every 2 seconds using `watch` and `sensors`.
#
# Usage:
#   chmod +x sensors.sh
#   ./sensors.sh

# Continuously runs the `sensors` command every 2 seconds,
# filtering the output to show only lines containing "core" or "package",
# which typically include CPU core and package temperatures.
watch -n 2 "sensors | grep -i 'core\|package'"
