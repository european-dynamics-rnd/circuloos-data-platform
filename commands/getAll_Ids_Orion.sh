#!/bin/bash
#

#

set -e
export $(cat ../.env | grep "#" -v)


if [ $# -lt 1 ]; then
    echo "Usage: $0 <tenant>"
    echo "  tenant: NGSILD-Tenant value"
    exit 1
fi

TENANT="$1"


curl -s -G -X GET  'http://'"${HOST}"':'"${ORION_LD_PORT}"'/ngsi-ld/v1/entities' \
-H 'NGSILD-Tenant: '"${TENANT}"'' \
-H 'NGSILD-Path: /' \
-H 'Link: <'"${CONTEXT}"'>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"' \
-d 'idPattern=urn:ngsi-ld:.*&limit=1000' | jq -r '.[].id'



echo -e