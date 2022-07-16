#!/bin/bash

# solution for exersice 2

TEST_PERIODICITY=5

timestemp=$(date +%s%n)
while true
do
for host in $hosts
do
  ping -c 1 -W 1 $host &> /dev/null
  if [[ $? -eq 0]]
    do RESULT=1
  else
    RESULT=0
  fi

  done

echo Test result for "" is "$R" at $timestemp
    curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
done < hosts


    sleep $TEST_PERIODICITY

done