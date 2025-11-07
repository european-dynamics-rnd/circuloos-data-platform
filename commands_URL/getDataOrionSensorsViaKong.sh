#!/bin/bash
#
#  curl commands to reload the data from the previous tutorial
#

set -e
export $(cat ../.env | grep "#" -v)
export $(cat ./partner_variables.txt | grep "#" -v)

./getTokenForOrion.sh
token=$(cat "token.txt")


if [ $# -lt 2 ]; then
  echo "Usage: $0  <tenant> <type>"
  echo "  type: Entity type to retrieve"
  echo "  tenant: NGSILD-Tenant value"
  exit 1
fi

type="$2"
TENANT="$1"

KONG_URL='https://'"${HOST}"'/kong/keycloak-orion'
# echo $KONG_URL
curl -s -G -X GET ''"${KONG_URL}"'/ngsi-ld/v1/entities' \
  -H 'NGSILD-Tenant: '"${TENANT}"'' \
  -H 'NGSILD-Path: /' \
  -H 'Link: <'"${CONTEXT}"'>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"' \
  -H 'Accept: application/ld+json' \
  -H 'Authorization: Bearer '"${token}"' ' \
  -d 'type='"${type}"'' | jq

