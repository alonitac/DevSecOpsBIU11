#!/bin/bash

TEST_PERIODICITY=5

HOST_FILE=/home/jonathan/hosts.txt


while true
do
        while read host
        do
                RESULTS=$(ping -c 1 ${host})
                TIME=$(awk 'BEGIN { FS="=" } {print $3}' $RESULTS)
                if [[ $? != 1 ]]; then
                        echo Test result for ${host} is $TIME
                else
                        echo Failed
                fi
        done < hosts.txt
    sleep $TEST_PERIODICITY
done
