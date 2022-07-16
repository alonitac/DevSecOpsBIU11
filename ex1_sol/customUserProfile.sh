#!\bin\bash

echo "*Hello $USER*"

/usr/lib/update-notifier/apt-check --human-readable
echo

FILE=/home/$USER/.token
PERMISION=$(stat -c "%a" $FILE)

if [[ -f "$FILE"  && "$PERMISION" -ne 600 ]]
then
echo "Warning: .token file has too open permissions"

fi