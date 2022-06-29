# ....code written here before...

# your changes:
#!/bin/bash
#print greeting to console
echo "Hello" $USER
/usr/lib/update-notifier/apt-check --human-readable
TOKEN="$HOME/.token"
if [[ -f $TOKEN && `stat -c %a $TOKEN` -ne 600 ]]
then

    echo 'Warning: .token file has too open permissions'

fi