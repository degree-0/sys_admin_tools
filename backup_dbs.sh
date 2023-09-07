#!/bin/bash
#
# backup_dbs.sh: 
# Customized for hardlayers.com.
# This script backs up the databases of the server used along with crontab, can be called to backup
# 3,4,5,6 or what ever copies of databases.
#
# Coded by: Mo9a7i (Mohannad F. Otaibi_)
# Email: 	mohannad.otaibi@gmail.com
#
# Crontab -e
# 15 2 * * Sat /root/mo9a7i/scripts/backup_dbs.sh daily 1
#

# Function to get load average
get_load_average() {
  local load_avg=$(uptime | awk -F':' '{print $NF}' | awk -F',' '{print $1}')
  echo $((load_avg / 1))
}

# Function to check disk space
check_disk_space() {
  local available_space=$(df -k /backup | tail -1 | awk '{print $4}')
  if [ "$available_space" -lt "1000000" ]; then
    echo "Not enough disk space. Exiting."
    exit 1
  fi
}

# Logging
log_file="/var/log/backup_dbs.log"
echo "Backup started at $(date)" >> $log_file

# Main loop to read databases and backup
mysql -u root -e "show databases" | grep -v 'Database\|information_schema' | \
while read -r db; do
  load_avg=$(get_load_average)
  
  if [ "$load_avg" -gt "3" ]; then
    sleep 30
  fi
  
  # Check disk space before backup
  check_disk_space
  
  # Backup and compress
  timestamp=$(date +%Y%m%d%H%M%S)
  mysqldump -u root $db > /backup/mysql/$1/$db.$2.$timestamp.sql
  gzip -f /backup/mysql/$1/$db.$2.$timestamp.sql
  
  echo "Backed up $db at $(date)" >> $log_file
done

echo "Backup completed at $(date)" >> $log_file
exit 0