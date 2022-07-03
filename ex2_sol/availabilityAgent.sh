TEST_PERIODICITY=5

while true
do

while read PC; do
  if [[ ! -z "$PC" ]]
  then
      ping -c 1 "${PC}" >/dev/null
      TEST_SUCC=($?)
      TIME_EP=$(date +%s%N)
      echo "Test result for ${PC} is ${TEST_SUCC} at ${TIME_EP}"
      curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=${PC} value=${TEST_SUCC} ${TIME_EP}"
  fi
done <~hosts

    sleep $TEST_PERIODICITY
done



