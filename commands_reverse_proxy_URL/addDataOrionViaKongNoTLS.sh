#!/bin/bash
#
set -e
export $(cat ../.env | grep "#" -v)


./getTokenForOrionNoTLS.sh
token=$(cat "token.txt")

# curl -X GET  'http://'"${HOST}"':'"${ORION_LD_PORT}"'/version' |jq 

KONG_URL='http://'"${HOST}"'/kong/keycloak-orion'

curl -iL -X POST  ''"${KONG_URL}"'/ngsi-ld/v1/entityOperations/upsert' \
-H 'NGSILD-Tenant: circuloos_demo' \
-H 'NGSILD-Path: /' \
-H 'Content-Type: application/ld+json' \
-H 'Accept: application/json' \
-H 'Authorization: Bearer '"${token}"' ' \
-d @$1
echo -e