#!/bin/bash

echo "****Hello $USER****"
echo `/usr/lib/update-notifier/apt-check --human-readable`
TOKEN=600
FILE=~/.token
PER=$(sudo stat -c '%a' $FILE)
if [ -f $FILE ]
then
  echo "**File Exist**"

else
  echo "**File Not Exist**"
fi

if [ ! "$PER" -eq "$TOKEN" ]
then
  echo ""Warning: .token file has too open permissions""
fi