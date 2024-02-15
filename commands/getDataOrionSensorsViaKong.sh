#!/bin/bash
#
#  curl commands to reload the data from the previous tutorial
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


if [ $# -eq 0 ]; then
  type="ieq_sensor"
  echo "No type as input. Providing data for type:ieq_sensor"
elif [ $# -eq 1 ]; then
    type="$1"
fi



KONG_URL='https://'"${HOST}"':'"${KONG_PORT}"'/keycloak-orion'
# echo $KONG_URL
curl -s $INSECURE -G -X GET ''"${KONG_URL}"'/ngsi-ld/v1/entities' \
  -H 'NGSILD-Tenant: circuloos_demo' \
  -H 'NGSILD-Path: /' \
  -H 'Link: <'"${CONTEXT}"'>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"' \
  -H 'Accept: application/ld+json' \
  -H 'Authorization: Bearer '"${token}"' ' \
  -d 'type='"${type}"'' | jq

