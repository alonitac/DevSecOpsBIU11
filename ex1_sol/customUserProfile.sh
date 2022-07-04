#!/bin/bash

# Greet the user. e.g. if the user is john, the message Hello john will be printed to stdout (standard output)
echo Hello $USER
echo

# Print how many packages are outdated
/usr/lib/update-notifier/apt-check --human-readable
echo

# Given a file called .token in the home directory of the user, check the file permissions
# If the octal representation of the permissions set is different from 600 (read and write by the user only),
# print a warning message to the user: Warning: .token file has too open permissions

FILE=/home/$USER/.token

if [[ -f "$FILE" && $(stat -c "%a" $FILE) != 600 ]] ; then
    echo "Warning: .token file has too open permissions"
fi
