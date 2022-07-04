#!/bin/bash

TEST_PERIODICITY=5

while true
do
    # your implementation here
    FILENAME="hosts"
    HOSTS_LINES=$(cat $FILENAME)

    for TESTED_HOST in $HOSTS_LINES # iterate over the lines of file hosts
    do
        TEST_TIMESTAMP=$(date +%s%N) # returns the number of nanoseconds
        ping -c 1 -W 1 "$HOSTS_LINES" &> /dev/null # single ping for each TESTED_HOST (line) with timeout of 1 sec
            if [ "$?" -eq 0 ] # check exit status of a ping
               then RESULT=1
            else RESULT=0
            fi
        echo "Test result for $TESTED_HOST is $RESULT at $TEST_TIMESTAMP"
        curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
    done

    sleep $TEST_PERIODICITY
    echo
done
