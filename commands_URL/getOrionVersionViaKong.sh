#!/bin/bash
set -e
export $(cat ../.env | grep "#" -v)
export $(cat ./partner_variables.txt | grep "#" -v)

if [ $# -lt 1 ]; then
    echo "Usage: $0 <tenant>"
    echo "  tenant: NGSILD-Tenant value"
    exit 1
fi

TENANT="$1"

./getTokenForOrion.sh
token=$(cat "token.txt")



KONG_URL='https://'"${HOST}"'/kong/keycloak-orion'
echo $KONG_URL
curl -s ''"${KONG_URL}"'/version' \
 -H 'NGSILD-Tenant: '"${TENANT}"'' \
 --header 'Authorization: Bearer '"${token}"' ' |jq
