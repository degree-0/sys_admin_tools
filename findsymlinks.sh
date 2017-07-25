#!/bin/bash
# findsymlinks
# To find unallowed symlinks across /home/ in cPanel servers
# Copyright (C) 2010 6degrees.com.sa, All Rights Reserved .
# Prgrammed and supported by: Mohannad Otaibi, mohannad.otaibi+vBAdmin@gmail.com .
# Regards.
# Github Description: Find un-allowed symlinks in /home/ directory of cPanel servers and report back to your email, can be used to track hackers

if [[ "X"$1 = "X" ]];
then
        echo "usage: ${0} <location>";
        exit 0;
fi

EMAIL="youremail@gmail.com"
SUBJECT="Symlinks report is ready!"
TEMPFILE="/tmp/$(hostname)"
TMPLOC="/tmp/symlinks.results"

echo "Searching /home for symlinks" >> $TEMPFILE
find /home/ -type l > $TMPLOC & EPID=$!  >> $TEMPFILE
echo "Find started with pid = $EPID" >> $TEMPFILE
wait $EPID >> $TEMPFILE
echo "Find Finished" >> $TEMPFILE
echo "Found `wc -l $TMPLOC | awk '{print $1}'` symlinks, clearing up now" >> $TEMPFILE
cat $TMPLOC | sed -e '/\/mail\//d' -e '/\/access-logs/d' -e '/\/www/d' -e '/\/.cpan\//d' -e '/\/cpimins/d' -e '/\/virtfs\//d' -e '/\/cpeasyapache\//d'> $1
echo "Done: the refined results show `wc -l $TMPLOC | awk '{print $1}'` symlinks" >> $TEMPFILE

mail -s "$SUBJECT" "$EMAIL" < $TEMPFILE
rm -f $TEMPFILE $TMPLOC
