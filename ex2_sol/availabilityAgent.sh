TEST_PERIODICITY=5


while true
  do
    for TESTED_HOST in $(cat ./hosts)
      do
        TEST_TIMESTAMP=$(date +%s%N)
        ping -c 1 TESTED_HOST &> /dev/null
        if [[ "$?" -eq 0 ]]
        then RESULT=1
        else RESULT=0
        fi
        echo "Test result for $TESTED_HOST is $RESULT at $TEST_TIMESTAMP"
    curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
  done


sleep $TEST_PERIODICITY;
done









