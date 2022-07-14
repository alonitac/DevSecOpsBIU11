TEST_PERIODICITY=5

function ping_to_host {
  TESTED_HOST=$1

  # Get the timestamp in nanoseconds and put it to a variable
  TEST_TIMESTAMP="$(date +%s%N)"

  # Mission 2 + Mission 3 + Mission 7
  # Ping a host in background. If successful, RESULT will be equal to 1, else to 0
  # For ping, call once for dynamically timeout duration. To TEST_PERIODICITY sec
  PING_LATENCY="$(ping "$TESTED_HOST" -c 1 -w 1 | head -n 2 | tail -n 1 | echo "$(awk 'BEGIN {FS="[=]|ms"} {print $4}')"sec)"
  # If there is no result, output 0
  if [[ $PING_LATENCY = "sec" ]]
  then
    PING_LATENCY=0
    RESULT=0
  else
    RESULT=1
  fi

  echo "Test result for $TESTED_HOST is $PING_LATENCY at $TEST_TIMESTAMP"

  # Mission 4
  curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
}

while true
do
  # Mission1
  while read TESTED_HOST; do
    # Mission 6 - Use the & operator to run all tests in parallel
    ping_to_host "$TESTED_HOST" &
  done <hosts
  # The loop body will be executed every TEST_PERIODICITY seconds (5 seconds in our case).
  sleep "$TEST_PERIODICITY"

done
