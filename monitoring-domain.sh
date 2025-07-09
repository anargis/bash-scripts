#!/bin/bash
#
# Description:
# Monitor a domain's availability and response time every 3 seconds.
#
# Usage:
# chmod +x monitoring-domain.sh
# ./monitoring-domain.sh <domain>
#
# watch                  – Repeats the command at a fixed interval
# -n 3                   – Interval of 3 seconds
# curl                   – Performs an HTTP request
#   -L                   – Follows redirects to final destination
#   -o /dev/null         – Discards the response body
#   -s                   – Silent mode (no progress or errors)
#   -w ...               – Custom output format:
#     %{http_code}       – HTTP status code (e.g. 200, 301)
#     %{url_effective}   – Final URL after redirects
#     %{time_total}s     – Total time taken for the request
# $1                     – First script argument (the domain to monitor)

watch -n 3 "curl -L -o /dev/null -s -w \"%{http_code} %{url_effective} %{time_total}s\n\" $1"
