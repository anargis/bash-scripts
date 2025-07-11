#!/bin/bash
#
# Description:
# Fetches and lists all version tags available for a specified WordPress plugin
# from the WordPress.org Subversion (SVN) repository.
#
# Usage:
# chmod +x list-wp-plugin-versions.sh
# ./list-wp-plugin-versions.sh <plugin-slug>
#
# curl -s https://plugins.svn.wordpress.org/"$1"/tags/
#   - curl                           Command-line tool to fetch content from URLs
#   - -s                             Silent mode (no progress or error output)
#   - https://.../"$1"/tags/         Constructs the plugin SVN tags URL using the argument ($1 = plugin slug)
#                                    For example: https://plugins.svn.wordpress.org/contact-form-7/tags/
#
# grep -oP '(?<=href=")[^"/]+(?=/")'
#   - grep                          Searches text using regex
#   - -o                            Print only the matched portion (not the full line)
#   - -P                            Use Perl-compatible regular expressions
#   - '(?<=href=")[^"/]+(?=/")'     Match version directories:
#         (?<=href=")               Positive lookbehind: only match text following href="
#         [^"/]+                    Match one or more characters that are not a slash or quote
#         (?=/")                    Positive lookahead: only match text that precedes /"
#   This pattern effectively extracts folder names from the HTML, which represent version numbers.

curl -s https://plugins.svn.wordpress.org/"$1"/tags/ | grep -oP '(?<=href=")[^"/]+(?=/")'
