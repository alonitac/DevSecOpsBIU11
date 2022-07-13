LOCK_TTL=600
HALL_CAPACITY=300

# This helper can be used to communicate with Redis
# Usage example:
#     redis-do set mykey myval EX 6
# Use as:
#     redis-do [redis command]
function redis-do {
  echo "$1" | redis-cli -u redis://localhost:6378/0
}

# This function lock a name ($2, string) and seat ($3, integer) in show ($1, string).
# Locking is possible only if this seat was not locked by other customer name.
# The lock should be expired automatically after $LOCK_TTL seconds.
# Upon success, print "The seat was locked"
# If this seat was locked by another customer, print "This seat is currently locked by other customer, try again later"
# If this seat is already booked, print "Locking failed, seat is already booked"
#
# Note that seat number must not exceed HALL_CAPACITY, otherwise the program exits with status 5


#  show:seat:lock
#  show:seat:book
function lock {
  local show=$1
  local name=$2
  local seat=$3
    
    if [[ $3 -gt $HALL_CAPACITY ]]; then
    exit 5
    fi

    declare -i len=`redis-do "LLEN  $show:seats"`
    for x in `redis-do LRANGE $show:seats 0 $len` ; do
        if [[ $seat -eq $x ]]; then
            if [[ `redis-do GET $show:$seat:book` == '' ]] ; then
                if [[ `redis-do GET $show:$seat:lock` == '' ]] ; then
                    `redis-do SET $show:$seat:lock $name EX $LOCK_TTL` &> /dev/null
                    echo "The seat was locked"
                    exit 0
                else
                    echo "This seat is currently locked by other customer, try again later"
                    exit 0
                fi                    
            else
                echo "Locking failed, seat is already booked"
                exit 0
            fi
        fi
    done
    redis-do LPUSH $show:seats $seat &> /dev/null
    redis-do SET $show:$seat:lock $name EX $LOCK_TTL &> /dev/null

}

# This function book a name ($2, string) and seat ($3, integer) in show ($1, string).
# Booking is possible only if $2 was locked the seat before for this show.
# Upon success, print "Successfully booked this seat!"
# If the customer was not locked this seat before, print "Booking failed, please lock the seat before"
#
# Note that seat number must not exceed HALL_CAPACITY, otherwise the program exits with status 5
function book {
  local show=$1
  local name=$2
  local seat=$3
   
    if [[ $3 -gt $HALL_CAPACITY ]]; then
    exit 5
    fi

    declare -i len=`redis-do "LLEN  $show:seats"`
    for x in `redis-do LRANGE $show:seats 0 $len` ; do
        if [[ $seat -eq $x ]]; then
            if [[ `redis-do GET $show:$seat:book` == '' ]] ; then
                if [[ `redis-do GET $show:$seat:lock` == "$name" ]] ; then
                    `redis-do SET $show:$seat:book $name` &> /dev/null
                    echo "Successfully booked this seat!"
                    exit 0
                else
                    echo "Booking failed, please lock the seat before"
                    exit 0
                fi                    
            else
                echo "Bookilng failed, seat is already booked"
                exit 0
            fi
        fi
    done

}


# This function releases a lock of name ($2), seat ($3) for show ($1).
# If this seat was not locked, or was locked by another customer, the function does nothing.
# If the seat has been released, print "The seat was released"
#
# Note that seat number must not exceed HALL_CAPACITY, otherwise the program exits with status 5
function release {
  local show=$1
  local name=$2
  local seat=$3

     
    if [[ $3 -gt $HALL_CAPACITY ]]; then
    exit 5
    fi

    declare -i len=`redis-do LLEN $show:seats`
    for x in `redis-do LRANGE $show:seats 0 $len` ; do
        if [[ $seat -eq $x ]]; then
            if [[ `redis-do GET $show:$seat:lock` == '' ]] ; then
                if [[ `redis-do GET $show:$seat:lock` == "$name" ]] ; then
                    redis-do DEL $show:$seat:lock &> /dev/null
                    echo "The seat was released"
                    exit 0
                else
                    exit 0
                fi                    
            else
                exit 0
            fi
        fi
    done

}


# OPTIONAL
# This function releases all existed locks for show ($1).
function reset {
  local show=$1

      if [[ $3 -gt $HALL_CAPACITY ]]; then
    exit 5
    fi

    declare -i len=`redis-do "LLEN  $show:seats"`
    for x in `redis-do "LRANGE $show:seats 0 $len"` ; do
        `redis-do "DEL $show:$seat:lock"` &> /dev/null
    done
}


if [[ "$1" = "book" ]]; then
  book "${@:2}"
elif [[ "$1" = "lock" ]]; then
  lock "${@:2}"
elif [[ "$1" = "release" ]]; then
  release "${@:2}"
elif [[ "$1" = "reset" ]]; then
  reset "${@:2}"
fi
