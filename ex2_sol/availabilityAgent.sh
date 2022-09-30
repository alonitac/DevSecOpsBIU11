TEST_PERIODICITY=5

# TODO the below line should be located inside the `while read` loop, otherwise the value of TEST_TIMESTAMP is the same for all tests
# TODO other than that, good solution


TEST_TIMESTAMP=$(date +%s%N)

while true
do
    # your implementation here
    #While loop iteration - Read IP Address from hosts file and present the test result date in nanoseconds
    while read TESTED_HOST; do
        ping -c 1 $TESTED_HOST > /dev/null
        if [[ $? == 0 ]]; then
          RESULT=1
        else
          RESULT=0
                  fi
        echo "Test result for $TESTED_HOST is $RESULT at $TEST_TIMESTAMP"
        curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
      done <hosts
    #end of loop
    

    sleep $TEST_PERIODICITY
done



