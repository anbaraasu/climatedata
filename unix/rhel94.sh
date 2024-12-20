# RHEL 9.4 unix 
# Command to find all the disks
# Description: Command to find all the disks
lsblk

# commands to mount a disk created newly
# 1. Create a directory to mount the disk
mkdir /data
# 2. Mount the disk
mount /dev/sdb1 /data
# 3. Check the disk is mounted
df -h



