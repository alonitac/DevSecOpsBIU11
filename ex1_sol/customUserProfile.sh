# FIXME (no fix needed) - great solution!

echo Hello $USER

/usr/lib/update-notifier/apt-check --human-readable

TOKEN=~/.token
PERMISSIONS=600

if [ -f $TOKEN ]; then
	if stat -c "%a" $TOKEN | grep -q -v $PERMISSIONS; then
		echo "Warning: .token file has too open permissions"
	fi
fi
