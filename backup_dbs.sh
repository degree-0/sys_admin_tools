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


function get_load_average() {
        return $(echo "$(uptime|awk -F':' '{print $NF}'|awk -F',' '{print $1}')/1"|bc)
}

mysql -u root -e "show databases"|grep -v 'Database\|information_schema'|awk -F'|' '{print $1}'| \
while read db;
do
        get_load_average;
        if [ "${?}" -gt "3" ];
        then
                sleep 30;
        fi
        mysqldump -u root ${db} > /backup/mysql/${1}/${db}.${2}.sql;
        bzip2 -f -5 /backup/mysql/${1}/${db}.${2}.sql;
done;

exit 0;

