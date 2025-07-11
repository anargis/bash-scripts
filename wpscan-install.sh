#!/bin/bash
#
# Description:
# Install WPScan, the WordPress Security Scanner, along with all required dependencies.
#
# Usage:
#   chmod +x install-wpscan.sh
#   ./install-wpscan.sh

# Update the package index to get the latest versions of available packages
sudo apt update

# Install required dependencies:
# - ruby and ruby-dev: Needed to install Ruby gems (like wpscan)
# - libcurl4-openssl-dev, libssl-dev, zlib1g-dev, libffi-dev: Required native libraries
# - make, gcc: Build tools needed for compiling native extensions
sudo apt install -y ruby ruby-dev libcurl4-openssl-dev make gcc libssl-dev zlib1g-dev libffi-dev

# Install WPScan using Ruby's gem package manager
sudo gem install wpscan

# Verify that WPScan installed correctly by checking its version
wpscan --version
