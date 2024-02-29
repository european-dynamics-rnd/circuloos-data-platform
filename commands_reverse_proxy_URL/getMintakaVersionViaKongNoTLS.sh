#!/bin/bash
#

#

set -e
export $(cat ../.env | grep "#" -v)

./getTokenForMintakaNoTLS.sh
token=$(cat "tokenMintaka.txt")

KONG_URL='http://'"${HOST}"'/kong/keycloak-mintaka'
echo $KONG_URL

curl -s  ''"${KONG_URL}"'/info' \
 --header 'Authorization: Bearer '"${token}"' ' |jq
