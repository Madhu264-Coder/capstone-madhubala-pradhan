#!/bin/bash
LOGFILE="/home/adhubala_radhan/system_maintenance.log"
exec >> "$LOGFILE" 2>&1

# Automated Backup Script
SOURCE="/home/adhubala_radhan/Documents"
DEST="/home/adhubala_radhan/backups"
DATE=$(date +%Y-%m-%d)
FILENAME="backup_$DATE.tar.gz"

mkdir -p "$DEST"
mkdir -p "$SOURCE"

tar -czf "$DEST/$FILENAME" "$SOURCE"

if [ $? -eq 0 ]; then
    echo "Backup successful: $DEST/$FILENAME"
else
    echo "Backup failed!"
fi

