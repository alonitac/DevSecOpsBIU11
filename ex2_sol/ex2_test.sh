# #  docker run --rm --name influxdb -v /home/alon/Documents/DevSecOpsBIU11/ex2_sol:/sol -p 8086:8086 influxdb:1.8.10 bash /sol/ex2_test.sh

set -e

# start influxdb
influxd &

sleep 3
curl -i -XPOST http://localhost:8086/query --data-urlencode "q=CREATE DATABASE hosts_metrics"

# run student solution script
#cd /sol
chmod +x ./availabilityAgent.sh
./availabilityAgent.sh &

sleep 25

DATA=$(curl -G 'http://localhost:8086/query?pretty=true' --data-urlencode "db=hosts_metrics" -H "Accept: application/csv" --data-urlencode "q=SELECT * FROM \"availability_test\"")

echo "Your test data as found in InfluxDB:"
echo "$DATA"
echo

if ! echo "$DATA" | grep -q 'name,tags,time,host,value'; then
  >&2 printf "Bad db columns. Expected to get 'name,tags,time,host,value' but found \'$DATA\'"
  exit 1
fi


if ! echo "$DATA" | grep -q "availability_test"; then
  echo "Bad measurement name. Expected 'availability_test'"
  exit 1
fi

for i in "127.0.0.1,1" "_gateway,0" "google.com,0" "10.0.0.34,0"
do
  set -- $i
  RES_LINES=$(echo "$DATA" | grep -q -c $i)
  if ((RES_LINES < 3)); then
    echo "Bad test results for $1. Expected at least 3 availability test with result $2."
    exit 1
  fi
done

echo "WELL DONE!!! you've passed all tests!"