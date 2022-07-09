TEST_PERIODICITY=5

while true
do
  # Mission1
  while read TESTED_HOST; do
    # Mission2
    # Ping a host and check if the host is unreachable.
    # If it's unreachable, put a result on the '/tmp/availabilityAgent_result' file.
    ping -c 1 "$TESTED_HOST"  | grep 'Unreachable' > /tmp/availabilityAgent_result 2>/dev/null
    if [[ -s /tmp/availabilityAgent_result ]]; then
      # If there is (Which means 'Unreachable'), RESULT equal to 0. Else, RESULT equal to 1.
      RESULT=0
    else
      RESULT=1
    fi

    # Reset the '/tmp/availabilityAgent_result' file.
    sudo cat /dev/null > /tmp/availabilityAgent_result

    # Get the timestamp in nanoseconds and put it to a variable.
    TEST_TIMESTAMP="$(date +%s%N)"

    # Mission 3
    echo "Test result for $TESTED_HOST is $RESULT at $TEST_TIMESTAMP"
    # Mission 4
    # After running the influxdb container and creating the 'hosts_metrics' DB
    if [  "$(docker ps -q -f name=influxdb)" ]; then
      curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
    fi

  done <hosts

  sleep "$TEST_PERIODICITY"
done