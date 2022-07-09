TEST_PERIODICITY=5

while true
do
  while read ping;
    do
        ping $ping -c 1 -W 1 &> /dev/null
        if [ $? -eq 0 ];
        then
                RESULT=1
                curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$ping value=$RESULT $(date +%s%N)"
                echo "The result for $ping is $RESULT at $(date +%s%N)"
        else
                RESULT=0
                curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$ping value=$RESULT $(date +%s%N)"
                echo "The result for $ping is $RESULT at $(date +%s%N)"
        fi
     done < host.txt
    sleep $TEST_PERIODICITY
    echo
done



