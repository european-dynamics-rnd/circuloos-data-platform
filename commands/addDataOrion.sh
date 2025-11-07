#!/bin/bash
#
set -e
export $(cat ../.env | grep "#" -v)

if [ $# -lt 2 ]; then
    echo "Usage: $0 <tenant> <json_file>"
    echo "  json_file: Path to the JSON file to upload"
    echo "  tenant: NGSILD-Tenant value"
    exit 1
fi

jsonFile="$2"
TENANT="$1"


curl -iL -X POST  'http://'"${HOST}"':'"${ORION_LD_PORT}"'/ngsi-ld/v1/entityOperations/upsert' \
-H 'NGSILD-Tenant: '"${TENANT}"'' \
-H 'NGSILD-Path: /' \
-H 'Content-Type: application/ld+json' \
-d @$jsonFile
echo -e