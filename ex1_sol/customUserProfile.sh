# FIXME (no fix needed) - Great!

echo "Hello" $USER
/usr/lib/update-notifier/apt-check --human-readable
TOKEN="$HOME/.token"
if [[ -f $TOKEN && `stat -c %a $TOKEN` -ne 600 ]]
then

    echo 'Warning: .token file has too open permissions'

fi