#!/bin/bash

TEST_PERIODICITY=5

while true
do
    # your implementation here

  while read host
  do
    ping -c 1 -W 1 $host in $hosts &> /dev/null
    if [[ $? -eq 0]]
      then
      RESULT=1
    else
      RESULT=0
   fi
    echo "Test result for $host is "$result" at $(date +%s%N)"
    curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$host value=$RESULT $(date +%s%N)"

  done < hosts

  sleep $TEST_PERIODICITY
done

