#!/bin/bash
#
set -e
export $(cat ../.env | grep "#" -v)

if [ $# -eq 0 ]; then
    TENNAND_ID="circuloos_demo"
    echo "No type as input. Providing data for "$TENNAND_ID
else
    TENNAND_ID="$1"
fi

curl -s -G -X GET  'http://'"${HOST}"':'"${ORION_LD_PORT}"'/ngsi-ld/v1/entities' \
-H 'NGSILD-Tenant: '"${TENNAND_ID}"'' \
-H 'Accept: application/ld+json' \
-d 'idPattern=urn:ngsi-ld:.*&limit=1000' | jq -r '.[].id'
