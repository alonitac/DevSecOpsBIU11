#!/bin/bash

# TODO try to keep the correct indentation so the code would be more readable.
# TODO other than that, good solution!
 TEST_PERIODICITY=5

 while true
 do
   while read -r TESTED_HOST
    do
      ping $TESTED_HOST -c 1 -W 1 &> /dev/null

 if [ $? -ne 0 ]
                then RESULT=0
             else RESULT=1
             fi
         TEST_TIMESTAMP=$(date +%s%N)
         echo "for ${TESTED_HOST} ${RESULT} at ${TEST_TIMESTAMP}"
 curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
     done < hosts

     sleep $TEST_PERIODICITY
     done