#!/bin/bash

TEST_PERIODICITY=5

while true
do
    # your implementation here

    while IFS="" read -r TESTED_HOST || [ -n "$TESTED_HOST" ] # iterate over the lines of file hosts, omiting white spaces
    do
        ping -c 1 -W 1 "$TESTED_HOST" &> /dev/null # single ping for each TESTED_HOST (line) with timeout of 1 sec
            if [[ "$?" -eq 0 ]] # check exit status of a ping
               then RESULT=1
            else RESULT=0
            fi
        TEST_TIMESTAMP=$(date +%s%N) # returns the number of nanoseconds

        printf '%s\n' "Test result for $TESTED_HOST is $RESULT at $TEST_TIMESTAMP"

        curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
    done < hosts

    sleep $TEST_PERIODICITY
    echo
done
