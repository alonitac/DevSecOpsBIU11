#!/bin/bash

#run docker



TEST_PERIODICITY=5
IPFILE=~\ex2_sol\hosts

# TODO the below line should be located inside the `while read` loop, otherwise the value of TIMESTAMP is the same for all tests
# TODO other than that, good solution
TIMESTAMP=$(echo $(($(date +%s%N)/1000000)))
WORKING=1
NOT_WORKING=0
while true
do

awk '{print $1}' < hosts | while read ip; do
    if ping -c1 $ip >/dev/null 2>&1; then
        echo 'test results for' $ip is $WORKING at $TIMESTAMP
	curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$ip value=$WORKING $TIMESTAMP"
    else
        echo 'test results for' $ip is $NOT_WORKING at $TIMESTAMP
	curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$ip value=$NOT_WORKING $TIMESTAMP"
    fi


done

    sleep $TEST_PERIODICITY
done


