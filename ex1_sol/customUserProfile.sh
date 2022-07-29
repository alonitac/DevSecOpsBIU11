#!/bin/bash

# FIXME (no fix needed) - Great!


echo Hello "$USER"

/usr/lib/update-notifier/apt-check --human-readable


FILE=~/.token

if `test -f $FILE` && [ `stat -c '%a' $FILE` != 600 ] ;
  then
  echo "Warning: .token file has too open permissions" ;
fi