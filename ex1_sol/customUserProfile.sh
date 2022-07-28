#!/bin/bash

greet="Hello $USER"

echo $greet

/usr/lib/update-notifier/apt-check --human-readable

if [ -f /home/.token ];then
        echo "token exists"
else
        echo "token does not exists"
        exit
fi

# FIXME the stat command expecting some filename as an argument
if [ "stat -c "%a" -ne "600"" ];then
        echo "Warning: .token file has too open permissions"
else
        echo "premission are ok"
fi

exit