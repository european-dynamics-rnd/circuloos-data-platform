#!/bin/bash
#

#

set -e
export $(cat ./partner_variables.txt | grep "#" -v)

if [ $# -lt 1 ]; then
    echo "Usage: $0 <tenant>"
    echo "  tenant: NGSILD-Tenant value"
    exit 1
fi

TENANT="$1"

./getTokenForMintaka.sh
token=$(cat "tokenMintaka.txt")

KONG_URL='https://'"${HOST}"'/kong/keycloak-mintaka'

curl -s ''"${KONG_URL}"'/info' \
 -H 'NGSILD-Tenant: '"${TENANT}"'' \
 --header 'Authorization: Bearer '"${token}"' ' |jq
