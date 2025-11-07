#!/bin/bash
# 
# to have both SSO and type use ./getMintakaSensorsToken.sh SSO SENSOR_ID

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

if [ $# -lt 2 ]; then
    echo "Usage: $0 <tenant> <entity>"
    echo "  entity: entity/sensorID"
    echo "  tenant: NGSILD-Tenant value"
    exit 1
fi

entity="$2"
TENANT="$1"

KONG_URL='https://'"${HOST}"':'"${KONG_PORT}"'/keycloak-mintaka'

curl -s $INSECURE -G -X GET  ''"${KONG_URL}"'/temporal/entities/'"${entity}"'' \
-H 'NGSILD-Tenant: '"${TENANT}"'' \
-H 'Link: <'"${CONTEXT}"'>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"' \
-H 'Authorization: Bearer '"${token}"' ' \
-d 'lastN=5' |jq  

