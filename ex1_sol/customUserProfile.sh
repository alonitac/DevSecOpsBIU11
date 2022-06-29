



#!/bin/bash

echo Hello $USER

/usr/lib/update-notifier/apt-check --human-readable
TOKEN=600
FILE=~/.token
if [ -f "$FILE" ]; then
    echo "token exists."
fi
xx=$( stat -c '%a' $FILE)
if [ "$TOKEN" -ne "$xx" ]; then
    echo "Warning: .token file has too open permissions."
fi

