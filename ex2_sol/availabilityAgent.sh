
TEST_PERIODICITY=5
while true
do
    while read TESTED_HOST

  do

    ping -c 1 -W 1 $TESTED_HOST &> /dev/null

   if [ "$?" -eq 0 ]; then
        RESULT=0
   else
        RESULT=1
   fi

    echo "Test result for $TESTED_HOST is $RESULT at $(date +%s%N)"
    curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $(date +%s%N)"
done  < hosts

    sleep $TEST_PERIODICITY

done

