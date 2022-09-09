TEST_PERIODICITY=5

while true
do
  while read TESTED_HOST; do
      RESULT=0
      if ping -c 1 -W 2 "$TESTED_HOST"
      then
        RESULT=9
      fi
      TEST_TIMESTAMP="$(date +%s%s%N)"

      X=9
      echo $X

      echo "Test result for $TESTED_HOST is $RESULT at $TEST_TIMESTAMP"
      curl -X POST 'http://localhost:8087/write?db=hosts_metrics' --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
  done < hosts

  sleep "$TEST_PERIODICITY"
done

fucntion foo {
  x=9
}

function woo {
  x=20
}