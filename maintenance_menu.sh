#!/bin/bash
LOGFILE="/home/$USER/system_maintenance.log"

# Log only script actions (not the menu display)
echo "------ Running Maintenance Menu ------" >> "$LOGFILE"

while true; do
    clear
    echo "===== System Maintenance Suite ====="
    echo "1. Run Backup"
    echo "2. Update & Cleanup"
    echo "3. Monitor Logs"
    echo "4. Exit"
    echo ""
    read -p "Choose an option [1-4]: " choice

    case $choice in
        1) echo "Running Backup..." | tee -a "$LOGFILE"
           ./backup.sh ;;
        2) echo "Running Update & Cleanup..." | tee -a "$LOGFILE"
           ./update_cleanup.sh ;;
        3) echo "Running Log Monitor..." | tee -a "$LOGFILE"
           ./log_monitor.sh ;;
        4) echo "Exiting..." | tee -a "$LOGFILE"
           exit 0 ;;
        *) echo "Invalid choice! Please try again." ;;
    esac
    echo ""
    read -p "Press Enter to continue..." dummy
done

