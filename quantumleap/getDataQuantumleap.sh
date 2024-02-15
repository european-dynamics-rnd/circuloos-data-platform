#!/bin/bash
# 
# to have both SSO and type use ./getquantumleapSensorsToken.sh SSO SENSOR_ID

#

set -e
export $(cat ../.env | grep "#" -v)


if [ $# -eq 0 ]; then
    sensorID="urn:ngsi-ld:circuloos:demo_1:ieq-001"
    echo "No type as input. Providing data for urn:ngsi-ld:circuloos:demo_1:ieq-001"
else
    sensorID="$1"
fi

curl -s -G -X GET  'http://localhost:'"${QUANTUMLEAP_PORT}"'/v2/entities/'"${sensorID}"'' \
-H 'Fiware-Service: circuloos_demo' \
-d 'lastN=5' |jq  

