#!/bin/bash

echo "****Hello $USER****"
/usr/lib/update-notifier/apt-check --human-readable
TOKEN=600
FILE=~/.token
PER=$(sudo stat -c '%a' $FILE)

if [[ -f "$FILE" && "$PER" -ne '600' ]]
then
  echo "**Warning: .token file has too open permissions**"
fi
