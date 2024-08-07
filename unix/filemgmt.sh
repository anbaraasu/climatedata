# file managment - permission unix commands demo
# 1. chmod - Change file permissions.
# 2. chown - Change file owner and group.
# 3. chgrp - Change group ownership.
# 4. touch - Create an empty file.
# 5. cp - Copy files and directories.
# 6. mv - Move or rename files and directories.
# 7. rm - Remove files and directories.
# 8. ln - Create hard and symbolic links.
# 9. mkdir - Create directories.
# 10. rmdir - Remove empty directories.
# 11. pwd - Print the current working directory.
# 12. cd - Change the current working directory.
# 13. ls - List directory contents.
# 14. find - Search for files and directories.
# 15. locate - Find files and directories by name.
# 16. which - Locate a command.
# 17. file - Determine file type.
# 18. stat - Display file status.
# 19. du - Estimate file space usage.

# Display menu for file management demos
echo "Select a file management demo:"
echo "1. chmod - Change file permissions."
echo "2. chown - Change file owner and group."
echo "3. chgrp - Change group ownership."
echo "4. touch - Create an empty file."
echo "5. cp - Copy files and directories."
echo "6. mv - Move or rename files and directories."
echo "7. rm - Remove files and directories."
echo "8. ln - Create hard and symbolic links."
echo "9. mkdir - Create directories."
echo "10. rmdir - Remove empty directories."
echo "11. pwd - Print the current working directory."
echo "12. cd - Change the current working directory."
echo "13. ls - List directory contents."
echo "14. find - Search for files and directories."
echo "15. locate - Find files and directories by name."
echo "16. which - Locate a command."
echo "17. file - Determine file type."
echo "18. stat - Display file status."
echo "19. du - Estimate file space usage."

# Read user input
read -p "Enter the number of the demo you want to run: " choice

touch fruits.txt
echo "apple" > fruits.txt
echo "banana" >> fruits.txt
echo "cherry" >> fruits.txt

# Run the selected demo
case $choice in
    1) echo "chmod demo:"
       chmod u+x fruits.txt;;
    2) echo -e "\nchown demo:"
       chown root fruits.txt;;
    3) echo -e "\nchgrp demo:"
       chgrp wheel fruits.txt;;
    4) echo -e "\ntouch demo:"
       touch newfile.txt;;
    5) echo -e "\ncp demo:"
       cp fruits.txt fruits_backup.txt;;
    6) echo -e "\nmv demo:"
       mv fruits.txt fruits_old.txt;;
    7) echo -e "\nrm demo:"
       rm fruits_old.txt;;
    8) echo -e "\nln demo:"
       ln -s fruits.txt fruits_link.txt;;
    9) echo -e "\nmkdir demo:"
       mkdir newdir;;
    10) echo -e "\nrmdir demo:"
        rmdir newdir;;
    11) echo -e "\npwd demo:"
        pwd;;
    12) echo -e "\ncd demo:"
        cd newdir;;
    13) echo -e "\nls demo:"
        ls;;
    14) echo -e "\nfind demo:"
        find . -name "*.txt";;
    15) echo -e "\nlocate demo:"
        locate fruits.txt;;
    16) echo -e "\nwhich demo:"
        which ls;;
    17) echo -e "\nfile demo:"
        file fruits.txt;;
    18) echo -e "\nstat demo:"
        stat fruits.txt;;
    19) echo -e "\ndu demo:"
        du -h fruits.txt;;
    *) echo "Invalid choice.";;
esac


