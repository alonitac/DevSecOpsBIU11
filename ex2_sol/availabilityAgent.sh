#!/bin/bash

TEST_PERIODICITY=5
PING_TIMESTAMP=$(date +%s%N)
while true
do
  while read HOST_OR_IP
    do
        ping -c 1 -W 1 $HOST_OR_IP &> /dev/null
        if [[ $? -eq 0 ]]
        then
          RETURN_CODE=1
        else
          RETURN_CODE=0
        fi
        curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$HOST_OR_IP value=$RETURN_CODE $PING_TIMESTAMP"
        echo "The result for $HOST_OR_IP is $RETURN_CODE at $(date +%s%N)"
    done < hosts
    sleep $TEST_PERIODICITY
done