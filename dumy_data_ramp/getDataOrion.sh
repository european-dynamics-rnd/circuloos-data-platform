#!/bin/bash
#

#

set -e
export $(cat ../.env | grep "#" -v)


# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Need 2 arguments: getDataOrion.sh NGSI-LD_entity_id NGSILD-Tenant"
    exit 1
else
    entity="$1"
    NGSILDTenant="$2"
fi


curl -s -G -X GET  'http://'"${HOST}"':'"${ORION_LD_PORT}"'/ngsi-ld/v1/entities/'"${entity}"'' \
-H 'NGSILD-Tenant: '"${NGSILDTenant}"'' \
-H 'NGSILD-Path: /' \
-H 'Link: <'"${CONTEXT}"'>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"' \
-H 'Accept: application/ld+json' |jq  
