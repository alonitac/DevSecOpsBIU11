#!\bin\bash

echo "*Hello $USER*"

/usr/lib/update-notifier/apt-check --human-readable

FILE=/home/$USER/.token
PERMISION=$(stat -c "%a" $file)

if [[ -f $FILE  && "$PERMISION" -ne 600 ]];
echo "Warning: .token file has too open permissions"

fi
