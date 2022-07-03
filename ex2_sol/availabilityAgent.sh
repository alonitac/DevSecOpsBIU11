TEST_PERIODICITY=5

while true
do
while read TESTED_HOST; do
  if [[ ! -z "$PC" ]]
  then
      ping -c 1 "${PC}" >/dev/null
      RESULT=($?)
      TEST_TIMESTAMP=$(date +%s%N)
      echo "Test result for ${TESTED_HOST} is ${RESULT} at ${TEST_TIMESTAMP}"
      #curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=${PC} value=${TEST_SUCC} ${TIME_EP}"
      curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
  fi
done <~hosts
    sleep $TEST_PERIODICITY
done



