echo Hello "$USER"

/usr/lib/update-notifier/apt-check --human-readable


# shellcheck disable=SC2164
cd /home
touch .token

FILE=~/.token

if `test -f $FILE` && [ `stat -c '%a' $FILE` != 600 ] ;
  then
  echo "Warning: .token file has too open permissions" ;
fi