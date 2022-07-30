TEST_PERIODICITY=5
RESULT=0
Time_Stamp=$(date +%s%N)
while true
do
 for TESTED_HOST in $(cat hosts);do
  ping -c 1 ${TESTED_HOST}>/dev/null
if [ $? -eq 0 ]; then
  RESULT=0

    echo "test for result 0 " ${TESTED_HOST} "at" ${Time_Stamp}
else
RESULT=1

echo "ping failed test result 1" ${TESTED_HOST} "at" ${time_Stamp}
fi
sleep $TEST_PERIODICITY
curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $Time_Stamp"
done


done




