#!/bin/sh
##########################################
# By: Mo9a7i (livehostsupport@gmail.com) #
##########################################
temp="/tmp/$(basename $0).$$" ; trap "/bin/rm -f $temp" 0
remote='127.0.0.1' #IP of remote Server
dire='public_html/backups' #Directory
ftpu='' #ftp username
ftpp='' #ftp passwor
transtype='binary'

echo "user $ftpu $ftpp" > $temp
echo "cd $dire" >> $temp
echo "$transtype" >> $temp

	for x in $*
	do
		f1=$(basename $x)
		echo "put $x $f1" >>$temp
	done

echo "quit" >> $temp
ftp -n  -v $remote < $temp
exit 0
