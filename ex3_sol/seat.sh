LOCK_TTL=600
HALL_CAPACITY=300


function checkSeatNotExceed {
  local seat=$1

  if [[ "$seat" -gt "$HALL_CAPACITY" || "$seat" -le 0 ]]; then
        exit 5
  fi

}
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
function lock {
  local show=$1
  local name=$2
  local seat=$3

  # your implementation here ...
 checkSeatNotExceed "$seat"

  if redis-do "exists book-$show-$seat" | grep -q "1"; then
        echo "Locking failed, seat is already booked"

  elif redis-do "setnx lock-$show-$seat $name" | grep -q "1"; then
	redis-do "EXPIRE lock-$show-$seat $LOCK_TTL" >> /dev/null
	echo "The seat was locked"
#if setnx failed then the lock is taken - check if it is taken ny someone else:
  elif [[ $(redis-do "get lock-$show-$seat") != "$name" ]]; then
        echo "This seat is currently locked by other customer, try again later"

  fi
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

  # your implementation here ...
 checkSeatNotExceed "$3"

  if [[ $(redis-do "get lock-$show-$seat") = "$name" ]]; then
	if redis-do "setnx book-$show-$seat $name" | grep -q "1"; then
 		echo "Successfully booked this seat!"
	fi
  else
	echo "Booking failed, lock your seat before"
  fi
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

  # your implementation here ...
 checkSeatNotExceed "$3"

  if [[ $(redis-do "get lock-$show-$seat") = "$name" ]]; then
	if redis-do "del lock-$show-$seat" | grep -q "1"; then
                echo "Seat was released"
        fi
  fi
}


# OPTIONAL
# This function releases all existed locks for show ($1).
function reset {
  local show=$1

  # your implementation here ...
for seat in $(seq 1 $HALL_CAPACITY)
  do
	redis-do "del lock-$show-$seat"
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