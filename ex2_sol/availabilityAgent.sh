#!/bin/bash

TEST_PERIODICITY=5

#HOST_NAME_IP=${awk 'NR==i {print $1}' /etc/hosts}

HOSTNAME_IP=""
RESULT=""
PING_RESULTS=""
NUM=0
TIME_NS=0

while true
do
    while [[ $HOSTNAME_IP != "" ]]
    do
      HOSTNAME_IP=$(awk 'NR==NUM {print $1}' /etc/hosts)
      ping -c 1 HOSTNAME_IP
      echo "Test result for $HOSTNAME_IP is $RESULT at $TIME_NS"


      NUM +=
      done
    sleep $TEST_PERIODICITY
done



