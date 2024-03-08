#!/bin/bash
set -e
export $(cat ../.env | grep "#" -v)
export $(cat ./partner_variables.txt | grep "#" -v)

./getTokenForOrion.sh
token=$(cat "token.txt")



KONG_URL='https://'"${HOST}"'/kong/keycloak-orion'
echo $KONG_URL
curl -s ''"${KONG_URL}"'/version' \
 --header 'Authorization: Bearer '"${token}"' ' |jq
