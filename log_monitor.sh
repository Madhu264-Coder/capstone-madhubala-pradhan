#!/bin/bash
SYSTEM_LOG="/var/log/syslog"
ALERTFILE="/home/$USER/log_alerts.txt"
LOGFILE="/home/$USER/system_maintenance.log"

exec >> "$LOGFILE" 2>&1

# Log Monitoring Script
grep -i "error\|warning\|fail" "$SYSTEM_LOG" > "$ALERTFILE"

if [ -s "$ALERTFILE" ]; then
    echo "Alerts found! Check $ALERTFILE for details."
else
    echo "No alerts found in logs."
fi

