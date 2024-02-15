#!/bin/bash
#

#

set -e
export $(cat ../.env | grep "#" -v)

if [ "$HOST" == "localhost" ]; then
  INSECURE=' --insecure '
else
  INSECURE=''
fi

./getTokenForQuantumleap.sh
token=$(cat "tokenQuantumleap.txt")

KONG_URL='https://'"${HOST}"':'"${KONG_PORT}"'/keycloak-quantumleap'

curl -s $INSECURE ''"${KONG_URL}"'/version' \
 --header 'Authorization: Bearer '"${token}"' ' |jq
