#!/bin/bash

echo Hello "$NEWUSER"
/usr/lib/update-notifier/apt-check --human-readable

TOKEN=600
FILE=~/.token
PER=$(stat -c "%a" $FILE)

if [ -f $FILE ] && [ "$PER" -ne "$TOKEN" ]; then
  echo "Warning: .token file has too open permissions"
else
  echo  "Approved permissions!"
fi