

TEST_PERIODICITY=5

while true
do
    # your implementation here
    for TESTED_HOST in $(cat ./hosts)
    do
        TEST_TIMESTAMP=$(date +%s%N)
        ping -c 1 -W 1 $TESTED_HOST &> /dev/null
        if [ "$?" -eq 0 ]; then RESULT=1; else RESULT=0; fi
        echo "Test result for $TESTED_HOST is $RESULT at $TEST_TIMESTAMP"

        curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"

    done



    sleep $TEST_PERIODICITY
done
##!/bin/bash
#
#TEST_PERIODICITY=5
#
#while true; do
#
#  RESULT=$?
#  TS=$(date +%s%N)
#  for TESTED_HOST in $(cat ./hosts); do #thanks to yitav!!!!!!! i went with while and not for!!!!!
#  ping -c 1 $TESTED_HOST > /dev/null
#  if [ $RESULT -eq 0 ]; then
#    RESULT=1
#  else
#    RESULT=0
#  fi
##print results
#     echo Test result for $TESTED_HOST is $RESULT at $TS
##influxdb
#  curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TS"
#done
#
#sleep $TEST_PERIODICITY
#
#done
#
#
















#
##!/bin/bash
#
#TEST_PERIODICITY=5
#while true; do
#filename='hosts'
#RESULT=$?
#while read hostname
#do
#    ping -c 1 -t 1 "$RESULT" > /dev/null 2>&1 &&
#    if [ $ErrorLevel -eq 0 ]; then
#    echo success
#else
#    echo fail
#fi
#    echo Test result for $output is $ErrorLevel at `date +%s%N`
#curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP" `date +%s%N`"
#done < 'hosts'
sleep $TEST_PERIODICITY
done

##!/bin/bash
#
#TEST_PERIODICITY=5
#while true; do
#filename="hosts"
#ErrorLevel=$?
#while IFS='' read -r l || [[ -n "$l" ]]; do
#ping -c 1 $l
#if [[ $ErrorLevel -eq 1 ]]; then
#    echo success
#else
#    echo fail
#fi
#curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$l value=$ErrorLevel `date +%s%N`"
#done < "$filename"
#sleep $TEST_PERIODICITY
#done
##continue to optional on homework
# echo "Checking $LINE"