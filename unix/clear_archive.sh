#!/bin/bash

# Define the log directory
LOG_DIR="/var/log"
ARCHIVE_NAME="logs.tar.gz"

# Step 1: Extract lines containing "ERROR" and save to error_logs.txt
echo "Extracting lines containing 'ERROR'..."
awk '/ERROR/' $LOG_DIR/*.log > error_logs.txt

# Step 2: Remove lines containing "DEBUG" from the log files
echo "Removing lines containing 'DEBUG'..."
sed -i '/DEBUG/d' $LOG_DIR/*.log

# Step 3: Archive the cleaned log files
echo "Archiving cleaned log files..."
tar -czf $ARCHIVE_NAME $LOG_DIR/*.log

echo "Log file analysis and cleanup completed."