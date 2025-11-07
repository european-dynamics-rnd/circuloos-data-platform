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
if [ $# -lt 2 ]; then
    echo "Usage: $0 <entity_id> <tenant>"
    echo "  entity_id: Entity ID to retrieve from temporal data"
    echo "  tenant: NGSILD-Tenant value"
    exit 1
fi

sensorID="$1"
TENANT="$2"

KONG_URL='https://'"${HOST}"'/kong/keycloak-mintaka'

curl -s -G -X GET  ''"${KONG_URL}"'/temporal/entities/'"${sensorID}"'' \
-H 'NGSILD-Tenant: '"${TENANT}"'' \
-H 'Link: <'"${CONTEXT}"'>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"' \
-H 'Authorization: Bearer '"${token}"' ' \
-d 'lastN=1' | jq

