# Understand the existing scripts and modify as per client requirements
#!/bin/bash
# Backup files from source to destination with date appended

# Variables 
SOURCE_DIR="/path/to/source"
DEST_DIR="/path/to/destination"
DATE=$(date +%Y%m%d)

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Backup files
for file in "$SOURCE_DIR"/*; do
  if [ -f "$file" ]; then
    filename=$(basename "$file")
    cp "$file" "$DEST_DIR/${filename}_$DATE"
    echo "Backed up $file to $DEST_DIR/${filename}_$DATE"
  fi
done

# change Request: Backup files from source to destination by creating new directory with date appended in destination path, print the execution time


#!/bin/bash

# Variables
SOURCE_DIR="/path/to/source"
DEST_DIR="/path/to/destination"
DATE=$(date +%Y%m%d)

# Record the start time
START_TIME=$(date +%s)

# Create destination directory with date appended
DEST_DIR_DATE="$DEST_DIR/backup_$DATE"
mkdir -p "$DEST_DIR_DATE"

# Backup files
for file in "$SOURCE_DIR"/*; do
  if [ -f "$file" ]; then
    filename=$(basename "$file")
    # exclude if the filename is starting with wellfargo
    if [[ "$filename" != wellfargo* ]]; then
      cp "$file" "$DEST_DIR_DATE/${filename}"
      echo "Backed up $file to $DEST_DIR_DATE/${filename}"
    fi
    # exclude the file if it is starting with wellfargo using case statement
    case "$filename" in
      wellfargo*)
        echo "Excluded $file from backup"
        ;;
      *)
        cp "$file" "$DEST_DIR_DATE/${filename}"
        echo "Backed up $file to $DEST_DIR_DATE/${filename}"
        ;;
    esac
  fi
done

# Record the end time
END_TIME=$(date +%s)

# Calculate the execution time
EXECUTION_TIME=$((END_TIME - START_TIME))

# Print the execution time
echo "Backup completed in $EXECUTION_TIME seconds"



#!/bin/bash
# Backup files from source to destination with date appended

SOURCE_DIR="/path/to/source"
DEST_DIR="/path/to/destination"
DATE=$(date +%Y%m%d)
LOG_FILE="/path/to/logfile.log"
EMAIL="admin@example.com"
EXCLUDE_EXT="tmp"

# Record the start time
START_TIME=$(date +%s)

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Start logging
echo "Backup started at $(date)" >> "$LOG_FILE"

# Backup files
for file in "$SOURCE_DIR"/*; do
  if [ -f "$file" ]; then
    filename=$(basename "$file")
    extension="${filename##*.}"
    
    # Exclude files with specific extension
    if [ "$extension" != "$EXCLUDE_EXT" ]; then
      cp "$file" "$DEST_DIR/${filename}_$DATE"
      if [ $? -eq 0 ]; then
        echo "Backed up $file to $DEST_DIR/${filename}_$DATE" >> "$LOG_FILE"
      else
        echo "Failed to back up $file" >> "$LOG_FILE"
      fi
    else
      echo "Excluded $file from backup" >> "$LOG_FILE"
    fi
  fi
done

# Record the end time
END_TIME=$(date +%s)

# Calculate the execution time
EXECUTION_TIME=$((END_TIME - START_TIME))

# Log the execution time
echo "Backup completed in $EXECUTION_TIME seconds" >> "$LOG_FILE"

# End logging
echo "Backup completed at $(date)" >> "$LOG_FILE"

# Send email notification
mail -s "Backup Completed" "$EMAIL" < "$LOG_FILE"


# Use Case 1: Automating Backups
#Existing Script: Backup Files to a Remote Server
#!/bin/bash

# Variables
SOURCE_DIR="/home/user/data"
DEST_DIR="/backup"
REMOTE_SERVER="user@remote-server:/backup"
LOG_FILE="/var/log/backup.log"

# Create a backup
rsync -avz $SOURCE_DIR $REMOTE_SERVER

# Log the backup
echo "$(date '+%Y-%m-%d %H:%M:%S') - Backup completed" >> $LOG_FILE

#Change Request: Add Compression and Adjust Destination Directory
#New Requirements:

#Compress the files before transferring.
#Change the remote destination directory to /remote-backup.
#Modified Script:
#!/bin/bash

# Variables
SOURCE_DIR="/home/user/data"
DEST_DIR="/backup"
REMOTE_SERVER="user@remote-server:/remote-backup"
LOG_FILE="/var/log/backup.log"
ARCHIVE_NAME="backup_$(date '+%Y%m%d').tar.gz"

# Create a compressed archive of the source directory
tar -czf $DEST_DIR/$ARCHIVE_NAME -C $SOURCE_DIR .

# Transfer the archive to the remote server
rsync -avz $DEST_DIR/$ARCHIVE_NAME $REMOTE_SERVER

# Log the backup
echo "$(date '+%Y-%m-%d %H:%M:%S') - Backup completed and compressed as $ARCHIVE_NAME" >> $LOG_FILE

#Use Case 2: Log File Management
#Existing Script: Rotate and Compress Log Files
#!/bin/bash

# Variables
LOG_DIR="/var/log/myapp"
RETENTION_DAYS=30

# Rotate and compress log files
find $LOG_DIR -type f -name "*.log" -mtime +$RETENTION_DAYS -exec gzip {} \;
find $LOG_DIR -type f -name "*.log.gz" -mtime +$RETENTION_DAYS -exec rm {} \;

# Log the operation
echo "$(date '+%Y-%m-%d %H:%M:%S') - Log rotation and compression completed" >> /var/log/logrotate.log

#Change Request: Change Retention Period and Add Email Notification
#New Requirements:

#Change the retention period to 60 days.
#Send an email notification after the operation.
#!/bin/bash

# Variables
LOG_DIR="/var/log/myapp"
RETENTION_DAYS=60
EMAIL="admin@example.com"
SUBJECT="Log Rotation Report"
LOG_FILE="/var/log/logrotate.log"

# Rotate and compress log files
find $LOG_DIR -type f -name "*.log" -mtime +$RETENTION_DAYS -exec gzip {} \;
find $LOG_DIR -type f -name "*.log.gz" -mtime +$RETENTION_DAYS -exec rm {} \;

# Log the operation
echo "$(date '+%Y-%m-%d %H:%M:%S') - Log rotation and compression completed" >> $LOG_FILE

# Send email notification
mail -s "$SUBJECT" $EMAIL < $LOG_FILE


# How do you transfer data from server to server 
# There are multiple ways to transfer data from one server to another:
# 1. SCP (Secure Copy Protocol): SCP is a secure file transfer protocol that uses SSH for data transfer. It allows you to securely transfer files between servers.
scp /path/to/local/file user@remote_server:/path/to/remote/directory

# 2. Rsync: Rsync is a powerful tool for syncing files and directories between servers. It can transfer data efficiently by only transferring the differences between source and destination files.
rsync -avz /path/to/local/directory user@remote_server:/path/to/remote/directory

# 3. FTP (File Transfer Protocol): FTP is a standard network protocol used for transferring files between servers. It is less secure than SCP or Rsync, but can be used for transferring large files.
ftp user@remote_server
put /path/to/local/file /path/to/remote/directory
# other commans are get, mget, mput, ls, cd, pwd, exit, etc.

# 4. SFTP (SSH File Transfer Protocol): SFTP is a secure file transfer protocol that uses SSH for data transfer. It provides a secure way to transfer files between servers.
sftp user@remote_server
put /path/to/local/file /path/to/remote/directory


# Difference between SFTP and FTP
# SFTP (SSH File Transfer Protocol) and FTP (File Transfer Protocol) are both used for transferring files between servers, but there are key differences between the two protocols:
# 1. Security: SFTP is a secure protocol that uses SSH for data transfer, providing encryption and authentication mechanisms to protect data in transit. FTP, on the other hand, is less secure as it transmits data in plain text, making it vulnerable to eavesdropping and data interception.

# 2. Authentication: SFTP uses SSH keys or passwords for authentication, while FTP typically uses usernames and passwords for authentication. SSH keys are considered more secure than passwords as they are not transmitted over the network.

# 3. Port: SFTP uses port 22 for data transfer, which is the default SSH port. FTP uses port 21 for control connections and port 20 for data connections.

# 4. Firewall compatibility: SFTP is more firewall-friendly as it uses a single port (port 22) for data transfer, while FTP requires multiple ports to be open for data transfer, which can be challenging to configure in firewall settings.

# 5. File transfer modes: SFTP supports only binary mode for file transfer, while FTP supports both binary and ASCII modes for file transfer.

# 6. Error handling: SFTP has better error handling capabilities compared to FTP, providing more detailed error messages and notifications during file transfers.

# Overall, SFTP is considered a more secure and reliable protocol for transferring files between servers, especially when dealing with sensitive data or over untrusted networks.

# Scenario: What you do if disk space is full or 100%, 

# If the disk space is full on a server, you can take the following steps to free up space:
# 1. Identify large files and directories: Use the `du` command to identify large files and directories that are consuming disk space.
du -ah /path/to/directory 2>/dev/null | sort -rnk 1 | head -n 5

# This command will list all files and directories in the specified directory, sort them by size in descending order, and display the top 5 largest files. This can help you identify which files are consuming the most space and take appropriate actions to free up disk space.

# 2. Remove unnecessary files: Delete any unnecessary files or directories that are no longer needed.
rm /path/to/file

# 3. Clear log files: Log files can consume a significant amount of disk space. You can clear log files that are no longer needed.

# 4. Empty trash or recycle bin: If your server has a trash or recycle bin, empty it to free up space.

# 5. Compress files: Compress large files or directories to save disk space. Recommended Practice.

# 6. Move files to another location: Move files to another location or server to free up space on the current server. Recommended Practice.

# 7. Increase disk space: If possible, increase the disk space on the server by adding additional storage.

# 8. Monitor disk space: Regularly monitor disk space usage to prevent it from reaching full capacity.


# What you do when you get memory alert
# If you receive a memory alert on a server, you can take the following steps to address the issue:
# 1. Identify memory-consuming processes: Use the `top` or `htop` command to identify memory-consuming processes that are using a large amount of memory.
top

# 2. Kill memory-consuming processes: If a specific process is consuming a large amount of memory, you can kill the process using the `kill` command.
kill -9 PID

# 3. Restart services: Restart services that are consuming a large amount of memory to free up memory.
sudo systemctl restart service_name
-- start/stop/restart

# When do you interact DBA team
# You may need to interact with the DBA team in the following scenarios:
# 1. Database performance issues: If you encounter database performance issues, you may need to work with the DBA team to optimize database queries, indexes, or configurations.

# 2. Database backups and restores: If you need to perform database backups or restores, the DBA team can assist in ensuring data integrity and availability.

# 3. Database migrations: When migrating databases to new servers or platforms, the DBA team can help with planning and executing the migration process.

# 4. Database security: The DBA team can help with implementing and maintaining database security measures to protect sensitive data.

# 5. Database tuning: If you need to optimize database performance or troubleshoot slow queries, the DBA team can provide expertise in database tuning.

# 6. Database monitoring: The DBA team can help set up monitoring tools to track database performance metrics and alert on potential issues.

# 7. Database schema changes: When making changes to the database schema, the DBA team can review and validate the changes to ensure data integrity.

# 8. Database upgrades: When upgrading database software or versions, the DBA team can assist in planning and executing the upgrade process.

# When do you interact Unix Admin team
# You may need to interact with the Unix Admin team in the following scenarios:
# 1. Server provisioning: When setting up new servers or virtual machines, the Unix Admin team can assist in configuring the server hardware and operating system.

# 2. Server maintenance: The Unix Admin team can help with routine server maintenance tasks such as patching, updates, and security hardening.

# 3. Server monitoring: The Unix Admin team can set up monitoring tools to track server performance metrics and alert on potential issues.

# 4. Server backups: The Unix Admin team can help with setting up and managing server backups to ensure data integrity and availability.

# 5. Server security: The Unix Admin team can assist in implementing and maintaining server security measures to protect against unauthorized access and data breaches.

# 6. Server troubleshooting: If you encounter server-related issues, the Unix Admin team can help troubleshoot and resolve the problems.

# 7. Server performance tuning: The Unix Admin team can assist in optimizing server performance by tuning system resources, configurations, and services.

# 8. Server upgrades: When upgrading server software or hardware, the Unix Admin team can help plan and execute the upgrade process to minimize downtime and disruptions.

# How do you establish connectivity between 2 servers
# To establish connectivity between two servers, you can use the following methods:
# 1. SSH (Secure Shell): SSH is a secure protocol for connecting to remote servers. You can use SSH to establish a secure shell session between two servers.
ssh user@remote_server


