# bash scripts

A curated collection of practical Bash scripts for penetration testing, automation, and various sysadmin tasks. 

---

## Example
[ssl-expiry.sh](https://github.com/anargis/bash-scripts/blob/main/ssl-expiry.ssh) - Get SSL certificate issuer and expiry date for a given domain.

[whatweb.sh](https://github.com/anargis/bash-scripts/blob/main/whatweb.sh) - Identifies technologies used by the target website—including server, CMS, frameworks, analytics, and more—with verbose output for detailed plugin results.

[torsocks.sh](https://github.com/anargis/bash-scripts/blob/main/torsocks.sh) - Get public ip and tor ip using torsocks

[proxychains.sh](https://github.com/anargis/bash-scripts/blob/main/proxychains.sh) - Get public ip and tor ip using proxychains

[nmap.sh](https://github.com/anargis/bash-scripts/blob/main/nmap.sh) - Performs an aggressive Nmap scan (-A) on the target with faster timing (-T4), enabling OS detection, version detection, script scanning, and traceroute.

[sublist3r.sh](https://github.com/anargis/bash-scripts/blob/main/sublist3r.sh) - Get subdomains for a domain

[traceroute.sh](https://github.com/anargis/bash-scripts/blob/main/traceroute.sh) - Print the route packets trace to network host

[dig.sh](https://github.com/anargis/bash-scripts/blob/main/dig.sh) - Retrieves detailed DNS information for a specified domain.

[wpscan-install.sh](https://github.com/anargis/bash-scripts/blob/main/wpscan-install.sh) - Install WPScan, the WordPress Security Scanner, along with all required dependencies.

[wpscan.sh](https://github.com/anargis/bash-scripts/blob/main/wpscan.sh) - Performs an aggressive WordPress security scan on the target URL, enumerating users, all plugins/themes, backup files, and exports, using a random user-agent and API token, while forcing detection and skipping TLS checks.

[sensors.sh](https://github.com/anargis/bash-scripts/blob/main/sensors.sh) - Get CPU temperature and watch it every 2 seconds

[monitoring-domain.sh](https://github.com/anargis/bash-scripts/blob/main/monitoring-domain.sh) - Monitor a domain's availability and response time every 3 seconds.

[wpcli-install.sh](https://github.com/anargis/bash-scripts/blob/main/wpcli-install.sh) - Install WP-CLI (WordPress Command Line Interface) on your system and verifies the installation.

[play-youtube-audio.sh](https://github.com/anargis/bash-scripts/blob/main/play-youtube-audio.sh) - Streams the best audio from a YouTube video directly using mplayer. 

[weather.sh](https://github.com/anargis/bash-scripts/blob/main/weather.sh) - Fetches a concise one-line weather summary for the specified city using wttr.in.

[bbc-news.sh](https://github.com/anargis/bash-scripts/blob/main/bbc-news.sh) - Fetches the latest BBC News headlines and their links from the RSS feed, displaying the top 20 news items (title + link) in the terminal.

[list-wp-plugin-versions.sh](https://github.com/anargis/bash-scripts/blob/main/list-wp-plugin-versions.sh) - Fetches and lists all version tags available for a specified WordPress plugin from the WordPress.org Subversion (SVN) repository.

[find-largest-files-and-dir.sh](https://github.com/anargis/bash-scripts/blob/main/find-largest-files-and-dir.sh) - Displays the top 20 largest files and directories under a specified path.

[export-db.sh](https://github.com/anargis/bash-scripts/blob/main/export-db.sh) - Export a full MySQL database backup with all options.

[sys-info.sh](https://github.com/anargis/bash-scripts/blob/main/sys-info.sh) - Displays detailed system information, including OS, kernel, CPU, RAM, disk usage, motherboard, BIOS, and GPU.

[list-apache-and-php-modules.sh](https://github.com/anargis/bash-scripts/blob/main/list-apache-and-php-modules.sh) - Lists installed PHP and Apache modules

[newsboat.sh](https://github.com/anargis/bash-scripts/blob/main/newsboat.sh) - Newsboat RSS Reader

[export-commit-versions.sh](https://github.com/anargis/bash-scripts/blob/main/export-commit-versions.sh) - Clones a GitHub repository and exports files from each commit into separate folders, enabling access to all historical versions.of the project.

[ddgr.sh](https://github.com/anargis/bash-scripts/blob/main/ddgr.sh) - Search DuckDuckGo using the command line. 

[docker-install.sh](https://github.com/anargis/bash-scripts/blob/main/docker-install.sh) - Install Docker

[set-dir-755-file-644.sh](https://github.com/anargis/bash-scripts/blob/main/set-dir-755-file-644.sh) - Recursively sets directory permissions to 755 and file permissions to 644.
 
[uptime.sh](https://github.com/anargis/bash-scripts/blob/main/uptime.sh) - Uptime monitor for a given website URL.

[trans.sh](https://github.com/anargis/bash-scripts/blob/main/trans.sh) - Command-line translator using Google Translate, Bing Translator, Yandex.Translate, etc.

[jpegoptim.sh](https://github.com/anargis/bash-scripts/blob/main/jpegoptim.sh) - Utility to optimize/compress JPEG/JFIF files.

[open-urls.sh](https://github.com/anargis/bash-scripts/blob/main/open-urls.sh) - Opens a predefined list of URLs in the default browser.

[icdiff.sh](https://github.com/anargis/bash-scripts/blob/main/icdiff.sh) - Compare two files side-by-side with color highlighting

[find-and-compress-images.sh](https://github.com/anargis/bash-scripts/blob/main/find-and-compress-images.sh) - Find - Count & Compress Large Images

[check-add-defines-wp-config.sh](https://github.com/anargis/bash-scripts/blob/main/check-add-defines-wp-config.sh) - Check & Add defines in wp-config.php

[backup-wordpress-files-and-db.sh](https://github.com/anargis/bash-scripts/blob/main/backup-wordpress-files-and-db.sh) - Backup WordPress files and database

---

## How to Use

```
chmod +x *.sh
./script-name.sh
```
