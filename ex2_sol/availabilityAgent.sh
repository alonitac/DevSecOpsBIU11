
#!/bin/bash
TEST_PERIODICITY=5
while true
do

	while read line
	do
		ping $line -c 1 &>/dev/null
		if [ $? -eq 0 ]
		then
			echo Test resulf for $line is 1 at $(date +%s)
			curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$line value=$? $(date +%s)"
		else
			echo Test result for $line is 0 at $(date +%s)
			curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$line value=$? $(date +%s)"


		fi


	done <hosts

	sleep $TEST_PERIODICITY
done
