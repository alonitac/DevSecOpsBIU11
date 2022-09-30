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

# This function checks if the seat number exceeds HALL_CAPACITY, otherwise the program exists with status 5
function seat_check {
  # TODO Good
  local seat=$1
  if [ $seat -gt $HALL_CAPACITY ]
    then
    exit 5
  fi
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

  seat_check "$seat" # This function checks if the seat number exceeds HALL_CAPACITY, otherwise the program exists with status 5

  seatTest=$(redis-do "get ${show}:${seat}") # attempt to get specific seat

  # TODO Good
  if [ -z $seatTest ]; then                                   # attempting to lock the seat
    redis-do "set ${show}:${seat} ${name}" &>/dev/null        # locking a seat
    redis-do "EXPIRE ${show}:${seat} ${LOCK_TTL}" &>/dev/null # set expire time for a seat
    echo "Seat was locked"
  else
    echo "Locking failed, seat is already booked"
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

  seat_check "$seat" # This function checks if the seat number exceeds HALL_CAPACITY, otherwise the program exists with status 5

  GET_SHOW=$(redis-cli -u redis://localhost:6378/0 get $show:$seat) # attempt to book a seat

  if [ $GET_SHOW == $name ]; then
    echo "Successfully booked this seat!"
  else
    echo "Booking failed, please lock the seat before"
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

  # TODO Good
  seat_check "$seat" # This function checks if the seat number exceeds HALL_CAPACITY, otherwise the program exists with status 5

  local ticket="$show:$seat" # Getting tickets status
  local lock_status="$(redis-do "get $ticket")"

  if [ $lock_status = "$name" ]; then              # Does nothing if the seat was locked by another customer or if this seat was not locked
    redis-do "del $ticket" &>/dev/null             # Removing lock status
    redis-do "srem $show:lock $ticket" &>/dev/null # Removing the ticket from lock set
    echo "The seat was released"
  fi

}

# OPTIONAL
# This function releases all existed locks for show ($1).
function reset {
  local show=$1

  # your implementation here ...

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
