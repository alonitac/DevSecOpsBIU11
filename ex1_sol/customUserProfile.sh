echo Hello $USER
/usr/lib/update-notifier/apt-check --human-readable

# FIXME (no fix needed) - Great!

file=".token"
if [[ -f $file && `stat -c %a $file` != 600 ]] ; then
    echo 'Warning: .token file has too open permissions'
fi



