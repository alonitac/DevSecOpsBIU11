# ....code written here before...

# your changes:
#!/bin/bash
#print greeting to console
echo Hello $USER

#check if there are outdated packages
/usr/lib/update-notifier/apt-check --human-readable

#assign variable file for .token file
file="~/.token"

#check if file exists
#check if permissions are too open, if yes, print warning
#if file does not exist, do nothing
if [[ -f $file && `stat -c %a $file` != 600 ]]
then
    echo "Warning: .token file has too open permissions"

elif [[ -f $file && `stat -c %a $file` == 600 ]]
then
    echo "Info: .token file permission settings are good"

else
    :

fi
