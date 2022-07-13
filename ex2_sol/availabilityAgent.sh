#!/bin/bash

TEST_PERIODICITY=5

EXIT_CODE=$?

SEND_PING="ping -c 1 -W 1"
TEST_TIMESTAMP=$(date +%N)


while true
do
  for TESTED_HOST in $(cat ./hosts); do
    $SEND_PING $TESTED_HOST &> /dev/null

    if [[ EXIT_CODE -eq 0 ]]
    then
      RESULT=1
    else
      RESULT=0
    fi

    echo "Test result for $TESTED_HOST is $RESULT at $TEST_TIMESTAMP"
    curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
  done

  echo ""
  sleep $TEST_PERIODICITY
done
