set -e

influxd &

sleep 3
curl -i -XPOST http://localhost:8086/query --data-urlencode "q=CREATE DATABASE hosts_metrics"

# run student solution script
#cd /sol
chmod +x ./availabilityAgent.sh

#echo "127.0.0.1" > hosts
./availabilityAgent.sh &

sleep 20

DATA=$(curl -G 'http://localhost:8086/query?pretty=true' --data-urlencode "db=hosts_metrics" -H "Accept: application/csv" --data-urlencode "q=SELECT * FROM \"availability_test\"")

echo

if ! echo "$DATA" | grep -q 'name,tags,time,host,value'; then
  printf "Bad db columns. Expected to get 'name,tags,time,host,value' but found \'$DATA\'"
  exit 1
fi


if ! echo "$DATA" | grep -q "availability_test"; then
  printf "bad measurement name"
  exit 1
fi

for i in "127.0.0.1,1" "_gateway,0" "google.com,1" "10.0.0.34,0"
do
  RES_LINES=$(echo "$DATA" | grep -c $i)
  if ((RES_LINES < 3)); then
    printf "bad number of tests"
    exit 1
  fi
done

echo "WELL DONE!!! you've passed all tests!"