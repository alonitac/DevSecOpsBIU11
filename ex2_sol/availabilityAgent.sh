#!/bin/bash

TEST_PERIODICITY=5
PING_TIMESTAMP=$(date +%N)
EXIT_CODE=$?

while true
do
  for HOST_OR_IP in $(cat ./hosts); do
    ping -c 1 "$HOST_OR_IP" &> /dev/null

    if [[ EXIT_CODE -eq 0 ]]
    then
      RETURN_CODE=1
    else
      RETURN_CODE=0
    fi

  echo "Test result for $HOST_OR_IP is $RETURN_CODE at $PING_TIMESTAMP"
  done

  echo ""
  sleep $TEST_PERIODICITY
done
