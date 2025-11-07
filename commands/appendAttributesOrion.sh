#!/bin/bash
#
set -e
export $(cat ../.env | grep "#" -v)

if [ $# -lt 3 ]; then
  echo "Usage: $0 <TENANT> <entity_id> <json_file>"
  echo "Example: $0 circuloos_demo urn:ngsi-ld:Building:001 attributes.json"
  exit 1
fi

TENANT="$1"
entity="$2"
json_file="$3"
echo "Appending attributes to entity: $entity"
echo "From file: $json_file"


curl -s -iX POST 'http://'"${HOST}"':'"${ORION_LD_PORT}"'/ngsi-ld/v1/entities/'"${entity}"'/attrs' \
-H 'Content-Type: application/json' \
-H 'NGSILD-Tenant: '"${TENANT}"'' \
-H 'Link: <'"${CONTEXT}"'>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"' \
-d @"${json_file}"
echo -e

