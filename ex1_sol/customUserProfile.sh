#!/bin/bash

# FIXME (no fix needed) - The code is correct, but you should fix the warning message in order to pass the tests

TOKEN_F=.token
TOKEN_PATH=~/$TOKEN_F
PREM_CHECK=600
echo Hello $USER
/usr/lib/update-notifier/apt-check --human-readable

if [ -f  $TOKEN_PATH ];then
        if stat -c "%a" $TOKEN_PATH | grep -q -v $PREM_CHECK;then
                        echo Warning : $TOKEN_F file has too open permissions
        fi
else
echo file $TOKEN_F dose not exsit in $TOKEN_PATH "!!"
fi
