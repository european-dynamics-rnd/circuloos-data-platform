#!/bin/bash
#
set -e
export $(cat ../.env | grep "#" -v)

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Need 2 arguments: addDataOrion.sh JSONDATA NGSILD-Tenant"
    exit 1
else
    JSON_DATA="$1"
    NGSILDTenant="$2"
fi



curl -iL -X POST  'http://'"${HOST}"':'"${ORION_LD_PORT}"'/ngsi-ld/v1/entityOperations/upsert' \
-H 'NGSILD-Tenant: '"${NGSILDTenant}"'' \
-H 'NGSILD-Path: /' \
-H 'Link: <'"${CONTEXT}"'>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"' \
-H 'Content-Type: application/json' \
-d @$JSON_DATA
echo -e