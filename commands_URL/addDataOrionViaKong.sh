#!/bin/bash
#
set -e
export $(cat ./partner_variables.txt | grep "#" -v)


./getTokenForOrion.sh
token=$(cat "token.txt")

# curl -X GET  'http://'"${HOST}"':'"${ORION_LD_PORT}"'/version' |jq 

KONG_URL='https://'"${HOST}"'/kong/keycloak-orion'

curl -s -iL -X POST  ''"${KONG_URL}"'/ngsi-ld/v1/entityOperations/upsert' \
-H 'NGSILD-Tenant: '"${NGSILD_TENANT}"''' \
-H 'NGSILD-Path: /' \
-H 'Content-Type: application/ld+json' \
-H 'Accept: application/json' \
-H 'Authorization: Bearer '"${token}"' ' \
-d @$1
echo -e