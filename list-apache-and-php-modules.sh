#!/bin/bash
#
# Description:
# Lists installed PHP and Apache modules
#
# Usage:
# chmod +x list-apache-and-php-modules.sh
# ./list-apache-and-php-modules.sh

# Lists all loaded PHP modules/extensions currently active
php -m

# Prints a newline and a header to separate PHP output from Apache output.
echo -e "\n=== Apache Modules ==="

# Lists loaded Apache modules.
# Tries 'apache2ctl -M' first (common on Debian/Ubuntu),
# falls back to 'httpd -M' if the first fails (common on RedHat/CentOS).
# Redirects error messages to /dev/null to avoid clutter
apache2ctl -M 2>/dev/null || httpd -M 2>/dev/null
