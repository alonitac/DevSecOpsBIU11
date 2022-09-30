#!/bin/bash
 # Testing!
TEST_PERIODICITY=5

# TODO good solution Michael, clean and organized code

while true
do
  for HOST_OR_IP in $(cat ./hosts); do
    PING_TIMESTAMP=$(date +%s%N)

    ping -c 1 -W 1 $HOST_OR_IP &> /dev/null
    if [[ $? -eq 0 ]]
    then
      RETURN_CODE=1
    else
      RETURN_CODE=0
    fi

    echo "The result for $HOST_OR_IP is $RETURN_CODE at $PING_TIMESTAMP"
    curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$HOST_OR_IP value=$RETURN_CODE $PING_TIMESTAMP"
  done

  sleep $TEST_PERIODICITY
done


