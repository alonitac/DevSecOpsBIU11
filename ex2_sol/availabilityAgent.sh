#!/bin/bash

TEST_PERIODICITY=5
TIME=$(date +%s.%N)

while true
do
	while read line; do
	  ping -c 1 -W 1 $line &> /dev/null
		  if [ $? -eq 0 ]; then
	    RESULT=1
	  	else
	  	RESULT=0
	  	fi
  	  echo "Test result for $line is $RESULT at $TIME"
  done < hosts
sleep $TEST_PERIODICITY
done
