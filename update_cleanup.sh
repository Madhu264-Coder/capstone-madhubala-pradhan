#!/bin/bash
LOGFILE="/home/$USER/system_maintenance.log"
exec >> "$LOGFILE" 2>&1

# System Update and Cleanup Script

echo "Updating system..."
sudo apt update && sudo apt upgrade -y

echo "Cleaning unnecessary files..."
sudo apt autoremove -y && sudo apt autoclean

echo "System update and cleanup completed successfully!"
