#!/bin/bash

# FIXME (no fix needed) - Great!

echo "Hello $USER"
echo "$(/usr/lib/update-notifier/apt-check --human-readable)"

sudo touch $HOME/.token

FILE=$HOME/.token
STATUS=$(stat -c "%a" $FILE)


if test -f "$FILE" && [[ $STATUS -ne 600 ]]; then
   echo "Warning: .token file has too open permissions"
fi
