#!/bin/sh
##########################################
# By: Mo9a7i (livehostsupport@gmail.com  #
##########################################
temp="/tmp/$(basename $0).$$" ; trap "/bin/rm -f $temp" 0
remote=''
dire='public_html/'
ftpu=''
ftpp=''
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
ftp -n -u -v $remote < $temp
exit 0
