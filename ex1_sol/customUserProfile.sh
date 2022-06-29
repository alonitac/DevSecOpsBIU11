# ....code written here before...

# your changes:

#print greeting to console when user logs in
echo Hello $USER

#check for outdated packages to update
/usr/lib/update-notifier/apt-check --human-readable

#set variable file, assign .token to variable
file='.token'

#check if .token exists and its permission levels if exists
if [[ -f $file && `stat -c %a $file` != 600 ]] ; then
#if different from 600, print warning
echo 'Warning: .token file has too open permissions'

else
# if == 600, print info message
echo 'INFO | .token file has good permission settings.'
fi