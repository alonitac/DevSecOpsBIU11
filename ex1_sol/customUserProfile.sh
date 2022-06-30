###  customUserProfile ###
echo "Hello $USER"

/usr/lib/update-notifier/apt-check --human-readable # check outdated packages

stat -c "%a"

echo Hello $USER

/usr/lib/update-notifier/apt-check --human-readable

if [[ -a ~/.token && `stat -c '%a' ~/.token` != 600 ]] ; then
    echo "Warning: .token file has too open permissions"
fi