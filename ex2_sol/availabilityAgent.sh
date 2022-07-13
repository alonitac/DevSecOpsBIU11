#!/bin/bash

TEST_PERIODICITY=5

TEST_TIMESTAMP=$(date +%s%N)

while true
do
  while read -r TESTED_HOST
  do
    ping -c 1 -W 1 $TESTED_HOST &> /dev/null

    if [ $? -eq 0 ]
    then
      RESULT=1
    else
      RESULT=0
    fi

    curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
    echo "Test result for $TESTED_HOST is $RESULT at $TEST_TIMESTAMP"
  done < hosts

  sleep $TEST_PERIODICITY
done