#!/bin/bash

TEST_PERIODICITY=5
TEST_TIMESTAMP=$(date +%s)


while true
do

        while read host
        do
                ping -c 1 -W 1 "${host}" &> /dev/null
                if      [[ $? == 0 ]] ; then
                        RESULT=1
                else
                        RESULT=0
                fi
                echo "Test result for "${host}" is $RESULT at $(date +%s%N)"
                        curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=${host} value=$RESULT $TEST_TIMESTAMP"
        done < hosts
        echo
    sleep $TEST_PERIODICITY
done

