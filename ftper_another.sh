#!/bin/sh
##########################################
# By: Mo9a7i (mohannad.otaibi@gmail.com  #
##########################################
temp="/tmp/$(basename $0).$$" ; trap "/bin/rm -f $temp" 0
remote='www.exbackups.com'
dire='wired/db'
ftpu='user'
ftpp='password'
transtype='binary'

echo -e "\033[31mStarted FTP Session\033[0m"
echo "user $ftpu $ftpp" > $temp
echo "cd $dire" >> $temp
echo "cd $1"
echo "$transtype" >> $temp
echo -e "\033[31mUploading: $x\n\033[0m"

	for x in $*
	do
		echo "put $x $x" >>$temp
		echo -e "\033[34m $x\n\033[0m"
	done

echo "quit" >> $temp

ftp -n -u -v $remote < $temp
echo -e "\033[31mFinished FTP Session\033[0m"
exit 0