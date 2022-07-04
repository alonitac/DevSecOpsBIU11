Created by anan - DevSecOpsBIU11
#!/bin/bash
# Program name: pingall.sh
# Tested on local machine #

TESTED_HOST=/home/anan/exam/exam2/host
TEST_PERIODICITY=5
TEST_TIMESTAMP=$(date +%s%N)


while true
do

for ip in $(cat $TESTED_HOST)
do

        echo "Ping in progress"
        ping $ip -c 1 $TESTED_HOST &> /dev/null

        if [ "$?" -eq "0" ]; then
        echo Test result for "${myArray[@]}" = $ip is 0 at ${TEST_TIMESTAMP}
        curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$TESTED_HOST value=0 $TEST_TIMESTAMP"

else
        echo Test result for "${myArray[@]}" = $ip is 1 at ${TEST_TIMESTAMP}
        curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$TESTED_HOST value=1 $TEST_TIMESTAMP"
        fi


done < host




sleep $TEST_PERIODICITY
done