#!/bin/bash
#
# Description:
# Install WP-CLI (WordPress Command Line Interface) on your system and verifies the installation.
#
# Usage:
#   chmod +x install-wpcli.sh
#   ./install-wpcli.sh

# Download the WP-CLI Phar (PHP Archive) file from the official GitHub source
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Run the downloaded file with PHP to verify that it works and print WP-CLI environment info
php wp-cli.phar --info

# Make the file executable so it can be run as a program
chmod +x wp-cli.phar

# Move it to /usr/local/bin and rename it to 'wp' so it can be run from anywhere as a command
sudo mv wp-cli.phar /usr/local/bin/wp

# Run the WP-CLI tool again (now installed globally) to confirm installation succeeded
wp --info
