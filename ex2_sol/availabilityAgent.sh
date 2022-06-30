TEST_PERIODICITY=5

while true
do
    while read x; do
      ping -c 1 $x &> /dev/null 2>&1
      RESULT=$?
      if [[ "$RESULT" -nq "0" ]]; then
          RESULT=1
      fi
      curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$x value=$RESULT `date +%s%N`"
    done < hosts
    sleep $TEST_PERIODICITY
done
