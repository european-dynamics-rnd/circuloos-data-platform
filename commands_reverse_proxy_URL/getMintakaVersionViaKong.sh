#!/bin/bash
#

#

set -e
export $(cat ../.env | grep "#" -v)

./getTokenForMintaka.sh
token=$(cat "tokenMintaka.txt")

KONG_URL='https://'"${HOST}"'/kong/keycloak-mintaka'

curl -s ''"${KONG_URL}"'/info' \
 --header 'Authorization: Bearer '"${token}"' ' |jq
