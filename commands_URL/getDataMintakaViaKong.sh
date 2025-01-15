#!/bin/bash
# 
# to have both SSO and type use ./getMintakaSensorsToken.sh SSO SENSOR_ID

#

set -e
export $(cat ../.env | grep "#" -v)
export $(cat ./partner_variables.txt | grep "#" -v)

./getTokenForMintaka.sh

token=$(cat "tokenMintaka.txt")
# echo $token
if [ $# -eq 0 ]; then
    sensorID="urn:ngsi-ld:circuloos:demo_1:ieq-001"
    echo "No type as input. Providing data for urn:ngsi-ld:circuloos:demo_1:ieq-001"
else
    sensorID="$1"
fi

KONG_URL='https://'"${HOST}"'/kong/keycloak-mintaka'

curl -s -G -X GET  ''"${KONG_URL}"'/temporal/entities/'"${sensorID}"'' \
-H 'NGSILD-Tenant: '"${ORION_LD_TENANT}"'' \
-H 'Link: <'"${CONTEXT}"'>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"' \
-H 'Authorization: Bearer '"${token}"' ' \
-d 'lastN=1' | jq

