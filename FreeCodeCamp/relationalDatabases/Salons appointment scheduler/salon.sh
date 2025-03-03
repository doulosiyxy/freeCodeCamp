#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~\n"

MAIN_MENU() {
  echo -e "Welcome to My Salon, how can I help you?\n"

  SERVICE_LIST=$($PSQL "SELECT * FROM services")

  echo "$SERVICE_LIST" | while read SERVICE_ID BAR SERVICE_NAME
  do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done
  read SERVICE_ID_SELECTED
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
  then
    MAIN_MENU
  else
    SERVICE_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
    SERVICE_SELECTED_FORMATTED=$(echo $SERVICE_SELECTED | sed 's/ |/"/')
    echo -e "\nYou have requested a $SERVICE_SELECTED_FORMATTED.\n"
    GET_CUSTOMER_INFO
  fi
}

GET_CUSTOMER_INFO() {
  # get customer info
  echo -e "Please enter you phone number?\n"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  # if customer doesn't exist
  if [[ -z $CUSTOMER_NAME ]]
  then
    # get new customer name
          echo -e "\nWhat is your name?"
          read CUSTOMER_NAME

    # get time
          echo -e "\nWhat time would like the appointment?"
          read SERVICE_TIME
          CUSTOMER_INFO_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
          ADD_APPOINTMENT
  else
    # get time
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    echo -e "\nHello,$CUSTOMER_NAME. What time would like the appointment?"
    read SERVICE_TIME
    ADD_APPOINTMENT
  fi
}

ADD_APPOINTMENT() {
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  ADD_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID', '$SERVICE_ID_SELECTED', '$SERVICE_TIME')")

  if [[ $ADD_APPOINTMENT_RESULT == "INSERT 0 1" ]]
  then
    echo -e "\nI have put you down for a $SERVICE_SELECTED_FORMATTED at $SERVICE_TIME, $CUSTOMER_NAME."
    else
    echo -e "\nApologies, there was an error. Please contact reception."
  fi
}

MAIN_MENU
