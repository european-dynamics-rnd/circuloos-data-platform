#!/bin/bash
#

#

set -e
export $(cat ../.env | grep "#" -v)

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Need 2 arguments: addDataOrion.sh JSONDATA NGSILD-Tenant"
    exit 1
else
    sensorID="$1"
    NGSILDTenant="$2"
fi

curl -s -G -X GET  'http://'"${HOST}"':'"${MINTAKA_PORT}"'/temporal/entities/'"${sensorID}"'' \
-H 'NGSILD-Tenant: '"${NGSILDTenant}"'' \
-H 'Link: <'"${CONTEXT}"'>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"' \
-d 'lastN=5' |jq  

