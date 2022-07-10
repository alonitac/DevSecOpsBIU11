#!/bin/bash

TEST_PERIODICITY=5
while true
do
  while read line
    do
        ping -c 1 -W 1 $line &> /dev/null
        if [ $? -eq 0 ]
        then
                RESULT=1
                curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$ping value=$RESULT $(date +%s%N)"
                echo "The result for $line is $RESULT at $(date +%s%N)"
        else
                RESULT=0
                curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$ping value=$RESULT $(date +%s%N)"
                echo "The result for $line is $RESULT at $(date +%s%N)"
        fi
    done < hosts
    sleep $TEST_PERIODICITY
done