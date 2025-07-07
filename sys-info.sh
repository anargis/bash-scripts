#!/bin/bash
#
# Displays detailed system information, including OS, kernel, CPU, RAM, disk usage, motherboard, BIOS, and GPU.
#
# Usage:
# chmod +x sys-info.sh
# ./sys-info.sh
#
# echo -e "\n=== System Info ==="; uname -a;
#   - Prints a header and runs `uname -a` to show all system info (kernel, hostname, architecture).
#
# echo -e "\n=== OS ==="; lsb_release -a 2>/dev/null || cat /etc/os-release;
#   - Prints OS details using `lsb_release -a`. If unavailable, reads `/etc/os-release`.
#
# echo -e "\n=== Kernel ==="; uname -r;
#   - Shows kernel version.
#
# echo -e "\n=== CPU ==="; lscpu | grep 'Model name\|Architecture';
#   - Displays CPU model name and architecture using `lscpu`.
#
# echo -e "\n=== RAM ==="; free -h | grep Mem;
#   - Shows memory usage in human-readable format, filtered to the "Mem" line.
#
# echo -e "\n=== Disk ==="; df -h --output=source,size,used,avail,pcent,target -x tmpfs -x devtmpfs | grep '^/dev' | column -t;
#   - Displays disk usage of real devices, excluding tmpfs and devtmpfs, formatted in columns.
#
# echo -e "\n=== Motherboard ==="; sudo dmidecode -t baseboard | grep -E 'Manufacturer|Product';
#   - Shows motherboard manufacturer and product details from dmidecode (requires sudo).
#
# echo -e "\n=== BIOS ==="; sudo dmidecode -t bios | grep -E 'Vendor|Version|Release Date';
#   - Prints BIOS vendor, version, and release date (requires sudo).
#
# echo -e "\n=== GPU ==="; lspci | grep -i 'vga\|3d';
#   - Lists VGA or 3D controllers (graphics cards) detected by PCI.

echo -e "\n=== System Info ==="; uname -a; echo -e "\n=== OS ==="; lsb_release -a 2>/dev/null || cat /etc/os-release; echo -e "\n=== Kernel ==="; uname -r; echo -e "\n=== CPU ==="; lscpu | grep 'Model name\|Architecture'; echo -e "\n=== RAM ==="; free -h | grep Mem; echo -e "\n=== Disk ==="; df -h --output=source,size,used,avail,pcent,target -x tmpfs -x devtmpfs | grep '^/dev' | column -t; echo -e "\n=== Motherboard ==="; sudo dmidecode -t baseboard | grep -E 'Manufacturer|Product'; echo -e "\n=== BIOS ==="; sudo dmidecode -t bios | grep -E 'Vendor|Version|Release Date'; echo -e "\n=== GPU ==="; lspci | grep -i 'vga\|3d'
