#!/bin/bash

TEST_PERIODICITY=5
HOST_FILE=/home/jonathan/hosts.txt
NANOSECONDS=1000000

while true
do
        while read host
        do
                ping -c 1 ${host} > /dev/null
                if [[ $? == 0 ]]; then
                        #TIME=$(ping -c 1 ${host} > /dev/null | awk -F '[=]' '/64/ {print $4}' | awk '{print $1}')
                        echo Test result for ${host} is $? at $(( ($( date +%s%N)/1000000 )))
                else
                        echo Test result for ${host} is 1 at $(( ($( date +%s%N)/1000000 )))
                fi
        done < hosts.txt
    sleep $TEST_PERIODICITY
done

