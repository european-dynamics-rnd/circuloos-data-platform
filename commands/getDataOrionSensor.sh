#!/bin/bash
#

#

set -e
export $(cat ../.env | grep "#" -v)


if [ $# -eq 0 ]; then
  echo "No sensor as input "
  exit 0
elif [ $# -eq 1 ]; then
    entity="$1"
    echo $entity
fi



curl -s -G -X GET  'http://'"${HOST}"':'"${ORION_LD_PORT}"'/ngsi-ld/v1/entities/'"${entity}"'' \
-H 'NGSILD-Tenant: circuloos_demo' \
-H 'NGSILD-Path: /' \
-H 'Link: <'"${CONTEXT}"'>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"' \
-H 'Accept: application/ld+json' |jq  
