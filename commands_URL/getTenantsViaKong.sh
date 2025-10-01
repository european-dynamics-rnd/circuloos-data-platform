#!/bin/bash
set -e
export $(cat ../.env | grep "#" -v)
export $(cat ./partner_variables.txt | grep "#" -v)

./getTokenForOrion.sh
token=$(cat "token.txt")


# commands_URL/getOrionVersionViaKong.sh   curl localhost:5056/get-tenants |jq
KONG_URL='https://'"${HOST}"'/kong/tenant-service-keycloak'
echo $KONG_URL
curl -s ''"${KONG_URL}"'/get-tenants' \
 --header 'Authorization: Bearer '"${token}"' ' |jq
