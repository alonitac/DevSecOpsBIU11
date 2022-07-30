#!/bin/bash

TEST_PERIODICITY=5

while true; do
  while read ADDRESS; do                # reading all lines in hosts file and pinging them
    ping -c 1 -W 1 $ADDRESS &>/dev/null # pinging silently with single ping and 1 second timeout
    if [ $? -eq 0 ]; then               # checking the ping result
      RESULT=1
    else
      RESULT=0
    fi
    TEST_TIMESTAMP=$(date +%s%N) # returns the ping time in nanoseconds
    echo "Test result for $ADDRESS is $RESULT at $TEST_TIMESTAMP"
    curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$ADDRESS value=$RESULT $TEST_TIMESTAMP" # writing the test results to Infl$
  done <hosts
  echo " " # prints a new line to separate each iterate
  sleep $TEST_PERIODICITY
done
