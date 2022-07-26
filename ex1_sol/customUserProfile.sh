#!\bin\bash
#
echo "*Hello $USER*"

/usr/lib/update-notifier/apt-check --human-readable

FILE=~/.token
PERMISION=$(stat -c "%a" $file)

if [[ -f $FILE  && "$PERMISION" -ne 600 ]]
  then
  echo "Warning: .token file has too open permissions"

fi