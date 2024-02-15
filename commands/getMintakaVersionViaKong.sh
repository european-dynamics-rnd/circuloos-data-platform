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

./getTokenForMintaka.sh
token=$(cat "tokenMintaka.txt")

KONG_URL='https://'"${HOST}"':'"${KONG_PORT}"'/keycloak-mintaka'

curl -s $INSECURE ''"${KONG_URL}"'/info' \
 --header 'Authorization: Bearer '"${token}"' ' |jq
