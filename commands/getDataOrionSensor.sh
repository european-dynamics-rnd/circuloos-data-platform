#!/bin/bash
#

#

set -e
export $(cat ../.env | grep "#" -v)


if [ $# -lt 2 ]; then
    echo "Usage: $0 <tenant> <entity>"
    echo "  entity: entity/sensorID"
    echo "  tenant: NGSILD-Tenant value"
    exit 1
fi

entity="$2"
TENANT="$1"


curl -s -G -X GET  'http://'"${HOST}"':'"${ORION_LD_PORT}"'/ngsi-ld/v1/entities/'"${entity}"'' \
-H 'NGSILD-Tenant: '"${TENANT}"'' \
-H 'NGSILD-Path: /' \
-H 'Link: <'"${CONTEXT}"'>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"' \
-H 'Accept: application/ld+json' |jq  
