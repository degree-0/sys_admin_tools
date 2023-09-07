#!/bin/sh
#######################
# Programmed By Ghazzi#
#######################

cd /backup/mysql
tar -zcvf mysql.tar.gz daily

ftper /backup/mysql/mysql.tar.gz
exit 0
