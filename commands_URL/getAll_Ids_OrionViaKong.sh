#!/bin/bash
#
set -e
export $(cat ./partner_variables.txt | grep "#" -v)


if [ $# -lt 1 ]; then
    echo "Usage: $0 <tenant>"
    echo "  tenant: NGSILD-Tenant value"
    exit 1
fi

TENANT="$1"

./getTokenForOrion.sh
token=$(cat "token.txt")

# curl -X GET  'http://'"${HOST}"':'"${ORION_LD_PORT}"'/version' |jq 

KONG_URL='https://'"${HOST}"'/kong/keycloak-orion'

curl -s -G -X GET  ''"${KONG_URL}"'/ngsi-ld/v1/entities' \
-H 'NGSILD-Tenant: '"${TENANT}"'' \
-H 'NGSILD-Path: /' \
-H 'Content-Type: application/ld+json' \
-H 'Accept: application/json' \
-H 'Authorization: Bearer '"${token}"' ' \
-d 'idPattern=urn:ngsi-ld:.*&limit=1000' | jq -r '.[].id'

echo -e