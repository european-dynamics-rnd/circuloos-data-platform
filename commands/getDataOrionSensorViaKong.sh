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


if [ $# -lt 2 ]; then
    echo "Usage: $0 <tenant> <entity>"
    echo "  entity: entity/sensorID"
    echo "  tenant: NGSILD-Tenant value"
    exit 1
fi

entity="$2"
TENANT="$1"



KONG_URL='https://'"${HOST}"':'"${KONG_PORT}"'/keycloak-orion'
# echo $KONG_URL
curl -s $INSECURE -G -X GET ''"${KONG_URL}"'/ngsi-ld/v1/entities/'"${entity}"'' \' \
  -H 'NGSILD-Tenant: '"${TENANT}"'' \
  -H 'Link: <'"${CONTEXT}"'>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"' \
  -H 'Accept: application/ld+json' \
  -H 'Authorization: Bearer '"${token}"' ' | jq

