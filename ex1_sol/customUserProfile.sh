# FIXME (no fix needed) - Great!


TOKEN_FILE=.token
TOKEN_FILE_PATH=~/$TOKEN_FILE
REQUIRED_PERMISSION=600

echo Hello $USER
echo

/usr/lib/update-notifier/apt-check --human-readable

if [ -f $TOKEN_FILE_PATH ]; then
        if stat -c "%a" $TOKEN_FILE_PATH | grep -q -v $REQUIRED_PERMISSION; then
                echo Warning: $TOKEN_FILE file has too open permissions
        fi
fi
