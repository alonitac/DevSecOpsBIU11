#!/bin/bash

TEST_PERIODICITY=5
TEST_TIMESTAMP=$(($(date +%s%N)/1000000))

while true
do

  while read -r TESTED_HOST; do

  x=$(ping -c 1 "$TESTED_HOST") > /dev/null
  if [[ $x = 0 ]]; then
  echo "Test $RESULT=1 for $TESTED_HOST at $TEST_TIMESTAMP"
  else
  echo "Test $RESULT=0 for $TESTED_HOST at $TEST_TIMESTAMP"
  fi

  echo curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test.sh,hosts=$TESTED_HOST value=$RESULT$TIME_TIMESTAMP"
  done
    sleep $TEST_PERIODICITY
done

