#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
#check if argument was added

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else

  #get atomic number
  if [[ $1 =~ [0-9] ]]
    then
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1")
    else
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1' OR name = '$1'")
  fi
  #check atom_number exists
  if [[ -z $ATOMIC_NUMBER ]]
  then
    echo I could not find that element in the database.
  else
  #get all element info
  ELEMENT_INFO=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) WHERE atomic_number = $ATOMIC_NUMBER")
  echo "$ELEMENT_INFO" | while IFS="|" read NUMBER SYMBOL NAME TYPE MASS MELTING_POINT BOILING_POINT TYPE_ID
  do
    #output data
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
  fi


fi
