#!/bin/bash
TEST_PERIODICITY=5
file1="/home/simon/hosts"
#!/bin/bash
TEST_PERIODICITY=5
file1="/home/simon/hosts"
HOSTS=$(cat "$file1")
while true
do
    for TESTED_HOST in $HOSTS
  do
    TEST_TIMESTAMP=$(date +%s%N)
    ping -c 1 $TESTED_HOST &> /dev/null

   if [ "$?" -eq 0 ]; then
        RESULT=0
   else
        RESULT=1
   fi

    echo Test result for "$TESTED_HOST" is "$RESULT" at $TEST_TIMESTAMP
    curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
done
    echo
    sleep $TEST_PERIODICITY

done



