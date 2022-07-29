#!/bin/bash

# FIXME (no fix needed) - Great!


echo "Hello $USER"
/usr/lib/update-notifier/apt-check --human-readable

FILE=".token"
FILE_PERM=$(stat -c "%a" $FILE)

if [[ -f $FILE  && "$FILE_PERM" -ne 600 ]]; then
                echo "Warning: $FILE file has too open permissions"
fi
