#!/bin/bash

TEST_PERIODICITY=5
#Main loop
while true; do
#set variables
filename='hosts'
ErrorLevel=$?
#Start ping loop
    echo Start
while read line; do
ping -c 1 $line
if [[ $ErrorLevel -eq 0 ]]
then
    echo fail to run command: ping -c 1 $line
else
    echo success to run command: ping -c 1 $line
fi
    echo Test result for $line is $ErrorLevel at $(date +%s%N)
done < $filename
sleep $TEST_PERIODICITY
done
#continue to optional on homework
