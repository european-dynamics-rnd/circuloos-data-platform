#!/bin/bash
# 
# to have both SSO and type use ./getquantumleapSensorsToken.sh SSO SENSOR_ID

#

set -e
export $(cat ../.env | grep "#" -v)

if [ "$HOST" == "localhost" ]; then
  INSECURE=' --insecure '
else
  INSECURE=''
fi

./getTokenForQuantumleap.sh

token=$(cat "tokenQuantumleap.txt")

if [ $# -eq 0 ]; then
    sensorID="urn:ngsi-ld:circuloos:demo_1:ieq-001"
    echo "No type as input. Providing data for urn:ngsi-ld:circuloos:demo_1:ieq-001"
else
    sensorID="$1"
fi

KONG_URL='https://'"${HOST}"':'"${KONG_PORT}"'/keycloak-quantumleap'

curl -s $INSECURE -G -X GET  ''"${KONG_URL}"'/v2/entities/'"${sensorID}"'' \
-H 'Fiware-Service: circuloos_demo' \
-H 'Authorization: Bearer '"${token}"' ' \
-d 'lastN=5' |jq  

