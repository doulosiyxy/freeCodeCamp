#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

#generate random number
GENERATE_NUMBER() {
  RANDOM_NUMBER=$(( RANDOM % 1000))
  echo $RANDOM_NUMBER
  GET_USERNAME
}

GET_USERNAME() {
  #user name prompt: Enter your username:
  echo -e "\nEnter your username:"
  #get username
  read USERNAME
  CHECK_USERNAME
}

CHECK_USERNAME() {
  #check username
  USERNAME_RESULT=$($PSQL "SELECT name FROM user_info WHERE name = '$USERNAME'")
  if [[ -z $USERNAME_RESULT ]]
  then
    #if not used output
    echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
    #update user_info with name.
    USER_UPDATE_RESULT=$($PSQL "INSERT INTO user_info(name) VALUES('$USERNAME')")
    GET_GUESS
  else
    #get user info: 1) games_played, 2) best_game
    NAME=$($PSQL "SELECT name FROM user_info WHERE name = '$USERNAME'")
    GAMES_RESULT=$($PSQL "SELECT COUNT(game_id) FROM user_info FULL JOIN games USING(user_id) WHERE name='$USERNAME'")
    BEST_GAME_RESULT=$($PSQL "SELECT MIN(guesses) FROM user_info FULL JOIN games USING(user_id) WHERE name='$USERNAME'")
    #if used output: Welcome back, <username>! You have played <games_played> games, and your best game took <best_game> guesses.
    echo -e "\nWelcome back, $NAME! You have played $GAMES_RESULT games, and your best game took $BEST_GAME_RESULT guesses."
    GET_GUESS
  fi
}

GET_GUESS() {
  if [[ -z $1 ]]
  then
    echo -e "\nGuess the secret number between 1 and 1000:"
  else
    echo -e "\n$1"
    COUNT_GUESS
  fi
  read USER_GUESS
  EVALUATE_GUESS
}

EVALUATE_GUESS() {
  if [[ ! $USER_GUESS =~ [0-9] ]]
  then
    if [[ ! $USER_GUESS =~ 'exit' ]]
    then
      GET_GUESS "That is not an integer, guess again:"
    else
      EXIT
    fi
  else
    if [[ $USER_GUESS -gt $RANDOM_NUMBER ]]
    then
      GET_GUESS "It's lower than that, guess again:"
    elif [[ $USER_GUESS -lt $RANDOM_NUMBER ]]
      then
      GET_GUESS "It's higher than that, guess again:"
    elif [[ $USER_GUESS == $RANDOM_NUMBER ]]
      then
      COUNT_GUESS
      UPDATE_USER
      echo -e "\nYou guessed it in $COUNT tries. The secret number was $RANDOM_NUMBER. Nice job!"
    fi
  fi
}

COUNT_GUESS() {
  COUNT=$(( COUNT + 1 ))
}

UPDATE_USER() {
    ID=$($PSQL "SELECT user_id FROM user_info WHERE name = '$USERNAME'")
    DATA_UPDATE_RESULT=$($PSQL "INSERT INTO games(guesses, user_id) VALUES($COUNT, $ID)")
}

EXIT() {
  exit
}

GENERATE_NUMBER
