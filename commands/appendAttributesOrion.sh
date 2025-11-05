#!/bin/bash
#
set -e
export $(cat ../.env | grep "#" -v)

if [ $# -lt 2 ]; then
  echo "Usage: $0 <entity_id> <json_file>"
  echo "Example: $0 urn:ngsi-ld:Building:001 attributes.json"
  exit 1
fi

entity="$1"
json_file="$2"
echo "Appending attributes to entity: $entity"
echo "From file: $json_file"


curl -s -iX POST 'http://'"${HOST}"':'"${ORION_LD_PORT}"'/ngsi-ld/v1/entities/'"${entity}"'/attrs' \
-H 'Content-Type: application/json' \
-H 'NGSILD-Tenant: circuloos_demo' \
-H 'NGSILD-Path: /' \
-H 'Link: <'"${CONTEXT}"'>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"' \
-d @"${json_file}"
echo -e

