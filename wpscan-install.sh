#!/bin/bash
#
# Install wpscan, WordPress Security Scanner
#
# Usage:
# chmod +x install-wpscan.sh
# ./install-wpscan.sh

sudo apt update && \
sudo apt install -y ruby ruby-dev libcurl4-openssl-dev make gcc libssl-dev zlib1g-dev libffi-dev && \
sudo gem install wpscan && \
wpscan --version
