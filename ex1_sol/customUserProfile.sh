#!/bin/bash

echo Hello $USER #task 1

/usr/lib/update-notifier/apt-check --human-readable #task 2

FILE=/home/$USER/.token #task 3
touch $FILE
STAT=$(stat -c %a $FILE)

# FIXME you should also have to test if the file exists
if [ "$STAT" == "600" ]; then
    echo "You all set"
else
    echo "Warning: .token file has too open permissions"
fi


