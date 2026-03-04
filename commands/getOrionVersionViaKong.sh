#!/bin/bash
set -e
export $(cat ../.env | grep "#" -v)


if [ $# -lt 1 ]; then
    echo "Usage: $0 <tenant>"
    echo "  tenant: NGSILD-Tenant value"
    exit 1
fi

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
 -H 'NGSILD-Tenant: '"${TENANT}"'' \
 --header 'Authorization: Bearer '"${token}"' ' | jq