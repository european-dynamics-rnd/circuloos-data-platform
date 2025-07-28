#!/bin/bash
#
set -e
export $(cat ./partner_variables.txt | grep "#" -v)


if [ $# -eq 0 ]; then
    TENNAND_ID="circuloos_ed_wood"
    echo "No type as input. Providing data for "$TENNAND_ID
else
    TENNAND_ID="$1"
fi

./getTokenForOrion.sh
token=$(cat "token.txt")

# curl -X GET  'http://'"${HOST}"':'"${ORION_LD_PORT}"'/version' |jq 

KONG_URL='https://'"${HOST}"'/kong/keycloak-orion'

curl -s -G -X GET  ''"${KONG_URL}"'/ngsi-ld/v1/entities' \
-H 'NGSILD-Tenant: '"${TENNAND_ID}"'' \
-H 'NGSILD-Path: /' \
-H 'Content-Type: application/ld+json' \
-H 'Accept: application/json' \
-H 'Authorization: Bearer '"${token}"' ' \
-d 'idPattern=urn:ngsi-ld:.*&limit=1000' | jq -r '.[].id'

echo -e