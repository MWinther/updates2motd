#!/bin/sh

OUTFILE=/etc/motd

TMPFILE=/tmp/updates2motd.$RANDOM.$RANDOM.$RANDOM
yum -q makecache && yum check-update > $TMPFILE
if [ $? -eq 100 ] ; then
  NUMLINES=`grep -v Security $TMPFILE | wc -l | cut -d ' ' -f 1`
  SECLINES=`grep Security $TMPFILE | wc -l | cut -d ' ' -f 1`
  # Remove one for an empty line
  NUMLINES=`echo $NUMLINES - 1 | bc`
  echo -e " ** $NUMLINES updates available.\n" > $OUTFILE
  if [ $SECLINES -gt 0 ]; then
    echo -e " ** $SECLINES security messages available!\n" >> $OUTFILE
  fi
else
  echo -n "" > $OUTFILE
fi
rm $TMPFILE
