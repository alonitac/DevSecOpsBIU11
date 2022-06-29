# ....code written here before...

# your changes:
#!/bin/bash

# greeting variable
greeting="Hello" $USER
# print greeting to console
echo "Hello " $USER

# print number of available pkg updates
/usr/lib/update-notifier/apt-check --human-readable

# assign variable for token file
tokenFile="$HOME/.token"
# assign variable for permission level
permissionLevel=600

# check if token file exists
# and also check if it is not equal to 600
if [[ -f $tokenFile && $(stat -c %a "$tokenFile") -ne $permissionLevel ]]
then
  # if it exists and is equal to 600, print warning message
  echo 'Warning: .token file has too open permissions'
fi