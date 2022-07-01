#Mission1
echo -e "****Hello $USER****"

PATH=$PATH:$HOME/bin

export PATH

echo “##############################################################”
echo ” Welcome to my linux station Mr `whoami` “
echo “##############################################################”

#Mission2-displays the number of updates:

updates=$(/usr/lib/update-notifier/apt-check --human-readable)
if [ ${updates:0:1} != 0 ]; then
   echo -e "$updates"
fi

#Mission3-If file exists and permission is not 600:

if [[ -f "$HOME/.token" && "$(stat -c "%a" $HOME/.token 2>/dev/null)" -ne '600' ]]
then
        echo -e  "\nWarning: .token file has too open permissions\n"
fi