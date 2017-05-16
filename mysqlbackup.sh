#!/bin/sh
#######################
# Programmed By Ghazzi#
#######################

cd /backup/mysql
tar -zcvf mysql.tar.gz daily
ftper mysql.tar.gz
exit 0
