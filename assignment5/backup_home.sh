#!/bin/bash
# backup_home.sh
# Usage: sudo ./backup_home.sh # Creates a timestamped tar.gz backup of specified directories and prunes old backups.

set -euo pipefail

# Configuration - change these as needed
BACKUP_DIR="/var/backups/capstone"       # where backups will be stored (create with sudo)
SOURCE_DIRS=( "/home/adhubala_radhan/Documents" "/home/adhubala_radhan/Pictures")  # directories to backup
RETENTION_DAYS=7                          # keep backups for this many days
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
HOSTNAME=$(hostname -s)
BACKUP_NAME="backup-${HOSTNAME}-${TIMESTAMP}.tar.gz"
LOGFILE="/var/log/capstone_backup.log"

# Ensure backup dir exists
mkdir -p "$BACKUP_DIR"
touch "$LOGFILE"
chmod 750 "$BACKUP_DIR"

echo "[$(date +'%F %T')] Starting backup: $BACKUP_NAME" >> "$LOGFILE"

# Create tar.gz archive
tar -czpf "${BACKUP_DIR}/${BACKUP_NAME}" "${SOURCE_DIRS[@]}" --warning=no-file-changed
if [ $? -eq 0 ]; then
  echo "[$(date +'%F %T')] Backup successful: ${BACKUP_DIR}/${BACKUP_NAME}" >> "$LOGFILE"
else
  echo "[$(date +'%F %T')] Backup failed!" >> "$LOGFILE"
  exit 1
fi

# Prune old backups
find "$BACKUP_DIR" -type f -name "backup-*.tar.gz" -mtime +"$RETENTION_DAYS" -print -delete >> "$LOGFILE" 2>&1

echo "[$(date +'%F %T')] Finished backup run" >> "$LOGFILE"
exit 0
