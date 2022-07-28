# Hello User
echo "Hello $USER"

# FIXME (no fix needed) - great!


# Package updates Status
/usr/lib/update-notifier/apt-check --human-readable

#Variables
TOKEN=.token
TOKEN_PATH=~/$TOKEN
PERMISSIONS=600

# Script
if [ -f $TOKEN_PATH ]; then
	if stat -c %a $TOKEN_PATH | grep -q -v $PERMISSIONS; then
		echo 'Warning: .token file has too open permissions'
        fi
fi
