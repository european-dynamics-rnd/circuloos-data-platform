#!/bin/bash
#

#

set -e
export $(cat ../.env | grep "#" -v)

./getTokenForMintakaNoTLS.sh
token=$(cat "tokenMintaka.txt")

KONG_URL='http://'"${HOST}"':'"${KONG_PORT}"'/keycloak-mintaka'

curl -s  ''"${KONG_URL}"'/info' \
 --header 'Authorization: Bearer '"${token}"' ' |jq
