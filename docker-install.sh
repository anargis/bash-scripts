#!/bin/bash
#
# Description: Install Docker
#
# Usage: chmod +x docker-install.sh && ./docker-install.sh
#
sudo apt update
sudo apt install docker.io -y
sudo systemctl enable --now docker
sudo usermod -aG docker $USER