#!/bin/bash
#

#

set -e
export $(cat ../.env | grep "#" -v)


if [ $# -eq 0 ]; then
  type="ieq_sensor"
  echo "No type as input. Providing data for type:ieq_sensor"
elif [ $# -eq 1 ]; then
    type="$1"
fi


curl -s -G -X GET  'http://localhost:'"${ORION_LD_PORT}"'/ngsi-ld/v1/entities' \
-H 'NGSILD-Tenant: circuloos_demo' \
-H 'NGSILD-Path: /' \
-H 'Link: <'"${CONTEXT}"'>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"' \
-H 'Accept: application/ld+json' \
-d 'type='"${type}"'' |jq  
