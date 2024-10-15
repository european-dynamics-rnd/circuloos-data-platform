#!/bin/bash
#
set -e
export $(cat ./partner_variables.txt | grep "#" -v)


./getTokenForOrion.sh
token=$(cat "token.txt")

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Need 2 arguments: addDataOrionViaKong.sh JSON_FILE NGSILD-Tenant"
    exit 1
else
    NGSILDTenant="$2"
fi


# curl -X GET  'http://'"${HOST}"':'"${ORION_LD_PORT}"'/version' |jq 

KONG_URL='https://'"${HOST}"'/kong/keycloak-orion'

curl -s -iL -X POST  ''"${KONG_URL}"'/ngsi-ld/v1/entityOperations/upsert' \
-H 'NGSILD-Tenant: '"${NGSILDTenant}"'' \
-H 'NGSILD-Path: /' \
-H 'Link: <'"${CONTEXT}"'>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"' \
-H 'Content-Type: application/json' \
-H 'Accept: application/json' \
-H 'Authorization: Bearer '"${token}"' ' \
-d @$1
echo -e