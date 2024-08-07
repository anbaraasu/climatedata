#!/bin/bash

# Display the contents of a file
cat /etc/passwd

# Change directory
cd /tmp

# Change file permissions
chmod 755 /tmp

# Clear the terminal screen
clear

# Copy files and directories
cp /etc/passwd /tmp/passwd_copy

# Display the current date and time
date

# Display disk space usage
df -h

# Compare the contents of two files
diff /etc/passwd /tmp/passwd_copy

# Display a line of text
echo "Hello, World!"

# Set an environment variable
export MY_VAR="Hello"

# Search for files in a directory hierarchy
find /tmp -name "passwd_copy"

# Display amount of free and used memory in the system
free -h

# Print lines matching a pattern
grep "root" /etc/passwd

# Compress files
gzip /tmp/passwd_copy

# Output the first part of files
head -n 10 /etc/passwd

# Terminate a process by PID
kill 1234

# Create hard and symbolic links
ln /tmp/passwd_copy /tmp/passwd_hardlink
ln -s /tmp/passwd_copy /tmp/passwd_symlink

# List directory contents
ls -l /tmp

# Display the manual of a command
man ls

# Create directories
mkdir /tmp/mydir

# View file contents one screen at a time
more /etc/passwd

# Move or rename files and directories
mv /tmp/passwd_copy /tmp/passwd_moved

# Report a snapshot of current processes
ps aux

dos2unix
unix2dos

# Print the current working directory
pwd

# Reboot the system
# reboot

# Remove files or directories
rm /tmp/passwd_moved

# Remove empty directories
rmdir /tmp/mydir

# Halt, power-off or reboot the machine
# shutdown -h now

# Sort lines of text files
sort /etc/passwd

# Output the last part of files
tail -n 10 /etc/passwd

# Store and extract files from an archive file
tar -cvf /tmp/myarchive.tar /etc/passwd
tar -xvf /tmp/myarchive.tar -C /tmp

# User interface to the TELNET protocol
# telnet example.com

# Display Linux tasks
top

# Change file timestamps
touch /tmp/newfile

# Print system information
uname -a

# Tell how long the system has been running
uptime

# Print newline, word, and byte counts for each file
wc /etc/passwd

# Show who is logged on
who

# Print effective userid
whoami

# Unix command used to view the contents of compressed files without having to uncompress them first.
zcat /tmp/passwd_copy.gz

# Search compressed files for a pattern
zgrep "root" /tmp/passwd_copy.gz

# execute two command sequentially
ls ; pwd

# execute two commands in parallel
ls & pwd

# execute a command only if the first command success
ls && pwd

# execute a command only if the first command fails
ls || pwd

# AWK command
#Exercise 1: Extract Specific Columns
#Extract and print specific columns:
#Given a CSV file data.csv with columns Name, Age, Department, Salary, extract and print the Name and Salary columns.

awk -F, '{print $1, $4}' data.csv

# skip the header line#1 and print col 1,3 from data.csv using awk
awk -F, 'NR>1 {print $1, $3}' data.csv

#Exercise 2: Calculate Sum and Average
#Calculate the sum and average of a column salary:

awk -F, '{sum += $4} END {print "Sum:", sum; print "Average:", sum/NR}' data.csv


#Exercise 3: Filter Rows Based on Condition
#Filter and print rows based on a condition:
# Given a file data.csv with columns Name, Age, Department, Salary, print the details of employees who have salary greater than 40000.
awk -F, '$4 > 50000' data.csv



# Exercise 1: Substitute Text
#Replace all occurrences of a word:
# Given a file data.csv, replace all occurrences of the word "Sales" with "IT".
sed 's/Sales/IT/g' data.csv

#Exercise 2: Delete Lines Matching a Pattern
#Delete lines containing a specific word:
# use sed to delete lines containing the word "Marketing" from a file data.csv.
sed '/Marketing/d' data.csv

# Exercise 3: Insert Text Before/After a Pattern
#Insert text before or after a pattern:
# Given a file data.csv, insert the text "New" before the word "Marketing".
sed 's/Marketing/New &/' data.csv



# Day1: Assignment1: Find all files in the /tmp directory that have not been accessed in the last 7 days and delete them.
find /tmp -type f -atime +7 -delete

#Exercise 2: Text Processing
# Count word frequency:
# Given a text file document.txt, count the frequency of each word and display the top 10 most frequent words.
cat fruits_bk.txt | sort | uniq -c | head -n 2


# Exercise 3: System Monitoring
# Check memory usage:
# Display the memory usage of the system in a human-readable format.
free -h 

# Exercise 4: Network Operations
# Check network connections:
# Display all current network connections and listening ports.
netstat -a

# Compress all .log files in the /var/log directory into a single tarball named logs.tar.gz.
tar -cf logs.tar /var/log/*.log
gzip logs.tar

or 
tar -czf logs.tar.gz /var/log/*.log







# vi editor commands
# i - insert before the cursor
# a - append after the cursor
# escape - cancel the vi command
# o - new line after the cursor line
# set nu - to display the line numbers
# dd - delete the current line
# dw - delete the current word
# d10d - deletes 10 lines from curent line
# escape + u - undo the change
# yy - copy the current line
# p - paste the copied line
# y4y - copy 4 lines
# cw -> change current word
# cf + character
# $ - last . 0 - first character
# :1,$ s/find/replace/g

# :w - save the changes
# :q - do not save the changes
# :x - save the changes and exit the file
# :w newfilename - write to new file


