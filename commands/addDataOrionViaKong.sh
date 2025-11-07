#!/bin/bash
#
set -e
export $(cat ../.env | grep "#" -v)

if [ "$HOST" == "localhost" ]; then
  INSECURE=' --insecure '
else
  INSECURE=''
fi

./getTokenForOrion.sh
token=$(cat "token.txt")

# curl -X GET  'http://'"${HOST}"':'"${ORION_LD_PORT}"'/version' |jq 

if [ $# -lt 2 ]; then
    echo "Usage: $0 <tenant> <json_file>"
    echo "  json_file: Path to the JSON file to upload"
    echo "  tenant: NGSILD-Tenant value"
    exit 1
fi

jsonFile="$2"
TENANT="$1"

KONG_URL='https://'"${HOST}"':'"${KONG_PORT}"'/keycloak-orion'

curl -iL $INSECURE -X POST  ''"${KONG_URL}"'/ngsi-ld/v1/entityOperations/upsert' \
-H 'NGSILD-Tenant: '"${TENANT}"'' \
-H 'NGSILD-Path: /' \
-H 'Content-Type: application/ld+json' \
-H 'Accept: application/json' \
-H 'Authorization: Bearer '"${token}"' ' \
-d @$jsonFile
echo -e