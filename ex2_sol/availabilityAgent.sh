#!/bin/bash

TEST_PERIODICITY=5
#Main loop
while true; do
#set variables
#filename='hosts'
ErrorLevel=$?
#Start ping loop
while read l; do
ping -c 1 $l
if [[ $ErrorLevel -eq 1 ]]
then
    echo success
fi
     curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$l value=$ErrorLevel `date +%s%N`"
done < hosts
sleep $TEST_PERIODICITY
done
#continue to optional on homework
