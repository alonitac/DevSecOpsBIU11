#!/bin/bash

TEST_PERIODICITY=5
TIME=$(date +%s.%N)

while true
do
	while read HOSTS_FILE; do
	  ping -c 1 -W 1 $HOSTS_FILE &> /dev/null
	 	if [ $? -eq 0 ]; then
	    	RESULT=1
	  	else
	  	RESULT=0
	  	fi
	  TIME=$(date +%s.%N)
  	  echo "Test result for $line is $RESULT at $TIME"
	  curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$HOSTS_FILE value=$RESULT $TIME"
        done < hosts
sleep $TEST_PERIODICITY
done
