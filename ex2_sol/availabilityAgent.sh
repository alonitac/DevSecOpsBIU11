TEST_PERIODICITY=5


function test {
  ping -W 2 -c 1 $1
  PING_RESULT=$(ping -W 2 -c 1 $1)
  if [ -z "$PING_RESULT" ]; then
    PING_RESULT=1
  fi
  echo "Test result for $1 is $PING_RESULT at $(date +%s%N)"

  curl -XPOST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$1 value=$PING_RESULT $(date +%s%N)"

}

while true
do

    # your implementation here

    while read p; do
      test $p
    done < hosts

    echo

    sleep $TEST_PERIODICITY
done



