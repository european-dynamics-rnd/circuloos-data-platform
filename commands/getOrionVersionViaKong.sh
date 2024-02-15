#!/bin/bash
set -e
export $(cat ../.env | grep "#" -v)


if [ "$HOST" == "localhost" ]; then
  INSECURE=' --insecure '
else
  INSECURE=''
fi

./getTokenForOrion.sh
token=$(cat "token.txt")



KONG_URL='https://'"${HOST}"':'"${KONG_PORT}"'/keycloak-orion'
# echo $KONG_URL
curl -s $INSECURE ''"${KONG_URL}"'/version' \
 --header 'Authorization: Bearer '"${token}"' ' | jq