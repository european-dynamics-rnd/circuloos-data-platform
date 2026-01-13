#!/bin/bash


set -e
export $(cat ../.env | grep "#" -v)

# token=$(curl --insecure --location --request POST 'http://localhost:8082/realms/fiware-server/protocol/openid-connect/token' \

token=$(curl -s --insecure --location --request POST 'https://'"${HOST}"':'"${KEYCLOAK_TLS_PORT}"'/realms/fiware-server/protocol/openid-connect/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'username=admin-user' \
--data-urlencode 'password=admin-user' \
--data-urlencode 'grant_type=password' \
--data-urlencode 'client_id=orion-pep' \
--data-urlencode 'client_secret=yWv2aRCm3KKMGrj9lMXQcEXY4v80tcFk' | jq .access_token )
# remove starting and tailing double quatas "
# echo $token
token=$(sed -e 's/^"//' -e 's/"$//' <<<"$token")
echo -n "$token" > token.txt