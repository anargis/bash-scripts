#!/bin/bash
#
# Description:
# Displays detailed system information, including OS, kernel, CPU, RAM, disk usage, motherboard, BIOS, and GPU.
#
# Usage:
#   chmod +x sys-info.sh
#   ./sys-info.sh

# === SYSTEM INFO ===
# Shows kernel name, hostname, version, architecture, etc.
echo -e "\n=== System Info ==="
uname -a

# === OS INFO ===
# Tries `lsb_release` for detailed OS info; falls back to /etc/os-release if not available.
echo -e "\n=== OS ==="
lsb_release -a 2>/dev/null || cat /etc/os-release

# === KERNEL VERSION ===
# Displays only the kernel release number.
echo -e "\n=== Kernel ==="
uname -r

# === CPU INFO ===
# Filters for CPU architecture and model name using `lscpu`.
echo -e "\n=== CPU ==="
lscpu | grep 'Model name\|Architecture'

# === RAM INFO ===
# Shows RAM usage summary, only the line starting with "Mem".
echo -e "\n=== RAM ==="
free -h | grep Mem

# === DISK USAGE ===
# Lists real disk devices (excluding tmpfs/devtmpfs) and formats output in columns.
echo -e "\n=== Disk ==="
df -h --output=source,size,used,avail,pcent,target -x tmpfs -x devtmpfs | grep '^/dev' | column -t

# === MOTHERBOARD INFO ===
# Displays motherboard manufacturer and product (requires sudo).
echo -e "\n=== Motherboard ==="
sudo dmidecode -t baseboard | grep -E 'Manufacturer|Product'

# === BIOS INFO ===
# Displays BIOS vendor, version, and release date (requires sudo).
echo -e "\n=== BIOS ==="
sudo dmidecode -t bios | grep -E 'Vendor|Version|Release Date'

# === GPU INFO ===
# Shows any VGA or 3D graphics controllers listed by `lspci`.
echo -e "\n=== GPU ==="
lspci | grep -i 'vga\|3d'
