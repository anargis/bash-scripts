#!/bin/bash
#
# Description:
# Compress JPEG images with jpegoptim at a given quality and extension.
#
# Usage:
# chmod +x jpegoptim.sh
# ./jpegoptim.sh <max_quality> <extension>

jpegoptim --max="$1" *."$2"