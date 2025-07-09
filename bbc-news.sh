#!/bin/bash
#
# Description:
# Fetches the latest BBC News headlines and their links from the RSS feed,
# displaying the top 20 news items (title + link) in the terminal.
#
# Usage:
# chmod +x latest-news.sh
# ./latest-news.sh
#
# curl -s https://feeds.bbci.co.uk/news/rss.xml
#   - curl                         Command-line tool to fetch data from URLs
#   - -s                           Silent mode, hides progress and errors
#   - URL                          BBC News RSS feed URL providing XML data
#
# awk '
#   /<item>/ {inside=1}            When encountering an <item> tag, mark inside = 1 (start of news item)
#   inside && /<title>/ {          While inside an item, find the <title> tag
#     gsub(/<\/?title>/,"")        Remove opening and closing <title> tags using regex substitution
#     title=$0                     Store cleaned title text in variable "title"
#   }
#   inside && /<link>/ {           While inside an item, find the <link> tag
#     gsub(/<\/?link>/,"")         Remove opening and closing <link> tags
#     link=$0                      Store cleaned link text in variable "link"
#     print title "\n" link "\n"   Print the title and link separated by newline, plus an extra newline for spacing
#     inside=0                     Reset inside flag to look for next <item>
#   }
# '
#

curl -s https://feeds.bbci.co.uk/news/rss.xml | awk '
  /<item>/ {inside=1}
  inside && /<title>/ {
    gsub(/<\/?title>/,"")
    title=$0
  }
  inside && /<link>/ {
    gsub(/<\/?link>/,"")
    link=$0
    print title "\n" link "\n"
    inside=0
  }
'
