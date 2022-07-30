TEST_PERIODICITY=5

while true
do
    #!/bin/bash
if [[ $# -eq 1 ]]; then
	command -v jq > /dev/null
	if [ $? -eq 0 ]
	then
   		echo "jc is installed"
	else 
   		echo "jc isn't installed please download from: https://stedolan.github.io/jq/download/"
		exit 1
	fi
	IPA=$1
	if [[ $IPA != '127.0.0.1' ]]; then
		RESS=$(curl http://ip-api.com/json/$IPA)
		DATA1=$(echo $RESS | jq -r '.status')
		if [[ $DATA1 = 'success' ]]; then
			echo $RESS | jq -r '.country'
			echo $RESS | jq -r '.region'
			echo $RESS | jq -r '.regionName'
		else
			echo $RESS | jq -r '.message'
			exit 1
		fi
	else
		echo "You entered a loopback IP"
		exit 1
	fi
else
	echo "Only one argument is allowed"
	exit 1
fi

    sleep $TEST_PERIODICITY
done



