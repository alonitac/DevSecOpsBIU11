TEST_PERIODICITY=5

#HOST_NAME_IP=${awk 'NR==i {print $1}' /etc/hosts}


while true
do
    while [[ $HOST_NAME_IP != "" ]]
    do
      awk 'NR==i {print $1}' /etc/hosts | xargs ping -c 1

      i +=
      done
    sleep $TEST_PERIODICITY
done



