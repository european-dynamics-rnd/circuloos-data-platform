#!/bin/bash
set -e
export $(cat ../.env | grep "#" -v)


if [ "$HOST" == "localhost" ]; then
  INSECURE=' --insecure '
else
  INSECURE=''
fi

./getTokenForOrionNoTLS.sh
token=$(cat "token.txt")



KONG_URL='http://'"${HOST}"'/kong/keycloak-orion'
echo $KONG_URL
curl -s ''"${KONG_URL}"'/version' \
 --header 'Authorization: Bearer '"${token}"' ' |jq
