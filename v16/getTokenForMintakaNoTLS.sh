#!/bin/bash


set -e
export $(cat ../.env | grep "#" -v)

# token=$(curl --insecure --location --request POST 'http://localhost:8080/realms/fiware-server/protocol/openid-connect/token' \
token=$(curl -s --location --request POST 'http://'"${HOST}"'/idm/auth/realms/fiware-server/protocol/openid-connect/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'username=admin-user' \
--data-urlencode 'password=admin-user' \
--data-urlencode 'grant_type=password' \
--data-urlencode 'client_id=mintaka-pep' \
--data-urlencode 'client_secret=47qTsRNiiud05sx68hY6lt7IB5TDyXYz' | jq .access_token )
# remove starting and tailing double quatas "
# echo $token
token=$(sed -e 's/^"//' -e 's/"$//' <<<"$token")
echo -n "$token" > tokenMintaka.txt