#!/bin/bash
#
set -e
export $(cat ../.env | grep "#" -v)

if [ "$HOST" == "localhost" ]; then
  INSECURE=' --insecure '
else
  INSECURE=''
fi

./getTokenForOrion.sh
token=$(cat "token.txt")

# curl -X GET  'http://'"${HOST}"':'"${ORION_LD_PORT}"'/version' |jq 

KONG_URL='https://'"${HOST}"':'"${KONG_PORT}"'/keycloak-orion'

curl -iL $INSECURE -X POST  ''"${KONG_URL}"'/ngsi-ld/v1/entityOperations/upsert' \
-H 'NGSILD-Tenant: circuloos_demo' \
-H 'NGSILD-Path: /' \
-H 'Content-Type: application/ld+json' \
-H 'Accept: application/json' \
-H 'Authorization: Bearer '"${token}"' ' \
-d @$1
echo -e