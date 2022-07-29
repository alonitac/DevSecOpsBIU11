in .bashrc add:

echo "hello $USER"
/usr/lib/update-notifier/apt-check --human-readable

# FIXME - the filename is .token,  not token (note the dot prefix)

touch /home/$USER/token

FILE=/home/$USER/token
PER=$(stat -c %a $FILE)
if [ $PER -ne 600 ]
then
    echo "Warning: .token file has too open permissions"
fi
