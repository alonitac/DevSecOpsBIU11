#!/bin/bash

# Prints current user's name
echo "Hello" $USER

# Extra space
echo

# Print how many packages are outdated
/usr/lib/update-notifier/apt-check --human-readable

# Extra space
echo

# Checking if file named ".token" exists in the user's home directoy

# Creates a variable called FILE with .token and CORRECTPERM for read and write by the user only permission
FILE=.token
CORRECTPERM=600
if test -f /home/$USER/"$FILE"
then
 FILEPERM=$(stat -c "%a" /home/$USER/"$FILE")
 if [ $FILEPERM != $CORRECTPERM ]
 then
  echo "Warning: .token file has too open permissions"
 fi
fi
