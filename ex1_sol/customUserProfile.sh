# ....code written here before...

# your changes:
#!/bin/bash
#print greeting to console when user logs in
echo Hello $USER

#check for outdated packages to update
/usr/lib/update-notifier/apt-check --human-readable

#set variable file, assign .token to variable
file='.token'

#check if .token exists and its permission levels if exists
if [[ -f $file && `stat -c %a $file` != 600 ]] ; then

#if true print to console
echo 'Warning: .token file has too open permissions'

else
echo 'INFO | .token file has good permission settings.'

fi
