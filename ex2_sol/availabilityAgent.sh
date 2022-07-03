TEST_PERIODICITY=5

while true
do
while read TESTED_HOST; do
  if [[ ! -z "$TESTED_HOST" ]]
  then
      ping -c 1 "${TESTED_HOST}" >/dev/null
      if [ $? -ne 0 ]; then
      	RESULT=1
      else
	RESULT=0
      fi
      TEST_TIMESTAMP=$(date +%s%N)
      echo "Test result for ${TESTED_HOST} is ${RESULT} at ${TEST_TIMESTAMP}"
      curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
  fi
done < hosts

    sleep $TEST_PERIODICITY
done



