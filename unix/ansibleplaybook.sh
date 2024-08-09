# crontab commands 
# crontab -e - to edit crontab
# crontab -l - to list crontab
# crontab -r - to remove crontab
# sample crontab job entry
min hour day month dayofweek command
0    0    *  *     *         /bin/bash /path/to/your/script.sh anbu 123

# first column is minutes, second column is hours, third column is day of month, fourth column is month, fifth column is day of week, sixth column is command to be executed

# Example 1: Run monitory.sh script every minute


# every 10 minutes
# */10 * * * * /bin/bash /path/to/your/script.sh

# Example 2: Run monitory.sh script every day @ 10 AM
# 0 10 * * * /bin/bash /path/to/your/script.sh

# Example 3: Run monitory.sh script every day @ 10 AM and 10 PM
# 0 10,22 * * * /bin/bash /path/to/your/script.sh

# Example 4: Run monitory.sh script during weekdays @ 1 AM
# 0 1 * * 1-5 /bin/bash /path/to/your/script.sh

# Example 5: Run monitory.sh script during weekends @ 1 AM
# 0 1 * * 6,7 /bin/bash /path/to/your/script.sh

# crontab entry to run the daily_backup script file under /home/user15, midnight 2 hours 30 minutes on every saturday.

30 2 * * 6 /bin/bash /home/user15/daily_backup.sh 


# Ansible is an open-source automation tool, or platform, used for IT tasks such as configuration management, application deployment, intraservice orchestration, and provisioning. 

# what is ansible playbook - Ansible Playbooks are the files where Ansible code is written. Playbooks are written in YAML format. These playbooks can be written using any text editor or IDE. Playbooks are a core component of Ansible and tell Ansible what to execute. They are like a to-do list for Ansible that contains a list of tasks.

# Shell script with Ansible Playbook 
# Ansible shell module parameters
# The shell module has a number of different parameters. Some of the most commonly used ones are:

# cmd (or free form): The core of the module, this is where you specify the command you want to run.
# creates: It helps ensure idempotence. If the specified file exists, the command won't be executed.
# chdir: Allows you to change the working directory before running the command.
# executable: If you need a specific shell interpreter (like /bin/bash), use this parameter.
# removes: The inverse of creates. If the specified file doesn't exist, the command won't run.

# example, we will create a backup of a directory on a remote host and copy the contents of /opt/myapp to it, and then verify the completion of the backup by listing the contents of the backup directory. If the backup is successful, a message confirming it will be displayed.

# Syntax
ansible-playbook -i your_inventory_file playbook.yml
# Example
ansible-playbook -i myservers.ini backup_playbook.yml

# inventory file - contains your remote host, user, and password.

# Another practical use case for running multiple shell commands using the Ansible shell module. In this example, we will:

# Update the package list on a remote host.
# Install a specific package (nginx).
# Start the nginx service.
# Verify that the nginx service is running.


# List of Ansible shell module functions
ansible_date_time
ansible_date_time.epoch
ansible_date_time.iso8601
ansible_date_time.microsecond
ansible_date_time.second
ansible_date_time.tz
ansible_date_time.tz_offset

ansible_distribution
ansible_distribution_file_parsed
ansible_distribution_file_path
ansible_distribution_file_variety
ansible_distribution_major_version
ansible_distribution_release

ansible_facts
ansible_facts['distribution']
ansible_facts['distribution_file_parsed']
ansible_facts['distribution_file_path']
ansible_facts['distribution_file_variety']

ansible_fqdn
ansible_hostname
ansible_interfaces
ansible_lo
ansible_lsb
ansible_lsb.codename
ansible_lsb.description
ansible_lsb.id

ansible_machine
ansible_os_family
ansible_pkg_mgr
ansible_processor
ansible_processor_cores
ansible_processor_count
ansible_processor_threads_per_core

ansible_product_name
ansible_product_serial
ansible_product_uuid
ansible_product_version
ansible_python
ansible_python.executable

ansible_selinux
ansible_selinux['status']
ansible_service_mgr
ansible_system
ansible_system_vendor
ansible_virtualization
ansible_virtualization_role
ansible_virtualization_type



