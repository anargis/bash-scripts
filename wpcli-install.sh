#!/bin/bash
#
# Installs WP-CLI (WordPress Command Line Interface) on your system and verifies the installation.
#
# Usage:
# chmod +x install-wpcli.sh
# ./install-wpcli.sh
#
# curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#   - curl          Command-line tool to transfer data
#   - -O            Saves the file with its original name (wp-cli.phar)
#   - This downloads the WP-CLI Phar (PHP Archive) file from the official source.
#
# php wp-cli.phar --info
#   - php           Invokes the PHP interpreter
#   - wp-cli.phar   Executes the downloaded WP-CLI Phar file
#   - --info        Displays info about the WP-CLI environment (verifies download integrity)
#
# chmod +x wp-cli.phar
#   - chmod +x      Makes the wp-cli.phar file executable
#
# sudo mv wp-cli.phar /usr/local/bin/wp
#   - sudo          Executes the command with superuser privileges
#   - mv            Moves wp-cli.phar to /usr/local/bin/
#   - Renames it to `wp`, making it globally executable as a command (`wp`)
#
# wp --info
#   - wp --info     Runs WP-CLI from any location to confirm successful installation

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    php wp-cli.phar --info && \
    chmod +x wp-cli.phar && \
    sudo mv wp-cli.phar /usr/local/bin/wp && \
    wp --info
