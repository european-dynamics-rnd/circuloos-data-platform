#!/bin/bash
#
#  curl commands to reload the data from the previous tutorial
#

set -e
export $(cat ../.env | grep "#" -v)
export $(cat ./partner_variables.txt | grep "#" -v)

./getTokenForOrion.sh
token=$(cat "token.txt")


if [ $# -eq 0 ]; then
  echo "No sensor as input "
  exit 0
elif [ $# -eq 1 ]; then
    entity="$1"
    echo $entity
fi




KONG_URL='https://'"${HOST}"'/kong/keycloak-orion'
# echo $KONG_URL
curl -s -G -X GET ''"${KONG_URL}"'/ngsi-ld/v1/entities/'"${entity}"'' \
  -H 'NGSILD-Tenant: '"${NGSILD_TENANT}"'' \
  -H 'NGSILD-Path: /' \
  -H 'Link: <'"${CONTEXT}"'>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"' \
  -H 'Accept: application/ld+json' \
  -H 'Authorization: Bearer '"${token}"' ' | jq

