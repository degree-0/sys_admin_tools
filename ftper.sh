#!/bin/sh
##########################################
# By: Mo9a7i (mohannad.otaibi@gmail.com) #
##########################################
temp="/tmp/$(basename $0).$$" ; trap "/bin/rm -f $temp" 0

remote='YourRemoteServer' # IP or domain of remote server
dire='YourDirectory' # Directory to upload to, example: public_html/backups
ftpu='YourFTPUser' # FTP username
ftpp='YourFTPPassword' # FTP password
transtype='binary'

echo "Starting FTP Session"
echo "user $ftpu $ftpp" > $temp
echo "cd $dire" >> $temp
echo "$transtype" >> $temp

for x in $*; do
  f1=$(basename $x)
  echo "put $x $f1" >> $temp
  echo "Uploading: $f1"
done

echo "quit" >> $temp
ftp -n -v $remote < $temp
echo "Finished FTP Session"
exit 0