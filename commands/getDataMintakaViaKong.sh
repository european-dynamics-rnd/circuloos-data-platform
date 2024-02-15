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

if [ $# -eq 0 ]; then
    sensorID="urn:ngsi-ld:circuloos:demo_1:ieq-001"
    echo "No type as input. Providing data for urn:ngsi-ld:circuloos:demo_1:ieq-001"
else
    sensorID="$1"
fi

KONG_URL='https://'"${HOST}"':'"${KONG_PORT}"'/keycloak-mintaka'

curl -s $INSECURE -G -X GET  ''"${KONG_URL}"'/temporal/entities/'"${sensorID}"'' \
-H 'NGSILD-Tenant: circuloos_demo' \
-H 'Link: <'"${CONTEXT}"'>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"' \
-H 'Authorization: Bearer '"${token}"' ' \
-d 'lastN=5' |jq  

