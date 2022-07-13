#!/bin/bash

TEST_PERIODICITY=5
while true
do
  while read HOST_OR_IP
    do
        ping -c 1 -W 1 $HOST_OR_IP &> /dev/null
        if [ $? -eq 0 ]
        then
                RESULT=1
        else
                RESULT=0
        fi
        curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$HOST_OR_IP value=$RESULT $(date +%s%N)"
        echo "The result for $HOST_OR_IP is $RESULT at $(date +%s%N)"
    done < hosts
    sleep $TEST_PERIODICITY
done