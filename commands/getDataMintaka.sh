#!/bin/bash
#

#

set -e
export $(cat ../.env | grep "#" -v)



if [ $# -eq 0 ]; then
    sensorID="urn:ngsi-ld:circuloos:demo_1:ieq-001"
    echo "No type as input. Providing data for urn:ngsi-ld:circuloos:demo_1:ieq-001"
else
    sensorID="$1"
fi

curl -s -G -X GET  'http://localhost:'"${MINTAKA_PORT}"'/temporal/entities/'"${sensorID}"'' \
-H 'NGSILD-Tenant: circuloos_demo' \
-H 'Link: <'"${CONTEXT}"'>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"' \
-d 'lastN=5' |jq  

