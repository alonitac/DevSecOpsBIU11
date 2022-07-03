#!/bin/bash
TEST_PERIODICITY=5

while true
do
while read line; do
        ping -D $line -c  1 1>/dev/null
        EC=$?
        TEST_TIMESTAMP=$(date +%s%N)
                if [  "$EC" -eq "0" ]; then
                echo Test result for ${line} is 1 at $TEST_TIMESTAMP
                curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$line value=1 $TEST_TIMESTAMP"
                else
                echo Test result for ${line} is 0 at $TEST_TIMESTAMP
                curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$line value=0 $TEST_TIMESTAMP"
                fi
done < hosts
echo
sleep $TEST_PERIODICITY
done


