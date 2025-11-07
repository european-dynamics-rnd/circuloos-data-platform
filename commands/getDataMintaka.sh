#!/bin/bash
#

#

set -e
export $(cat ../.env | grep "#" -v)



if [ $# -lt 2 ]; then
    echo "Usage: $0 <tenant> <sensorID>"
    echo "  sensorID: sensorID"
    echo "  tenant: NGSILD-Tenant value"
    exit 1
fi

sensorID="$2"
TENANT="$1"

curl -s -G -X GET  'http://'"${HOST}"':'"${MINTAKA_PORT}"'/temporal/entities/'"${sensorID}"'' \
-H 'NGSILD-Tenant: '"${TENANT}"'' \
-H 'Link: <'"${CONTEXT}"'>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"' \
-d 'lastN=5' |jq  

