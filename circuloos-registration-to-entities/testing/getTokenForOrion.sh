#!/bin/bash


set -e
export $(cat ./partner_variables.txt | grep "#" -v)

# token=$(curl --insecure --location --request POST 'http://localhost:8080/realms/fiware-server/protocol/openid-connect/token' \
token=$(curl -s --location --request POST 'https://'"${HOST}"'/idm/realms/fiware-server/protocol/openid-connect/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'username='"${PARTNER_USERNAME}"'' \
--data-urlencode 'password='"${PARTNER_PASSWORD}"'' \
--data-urlencode 'grant_type=password' \
--data-urlencode 'client_id=orion-pep' \
--data-urlencode 'client_secret='"${ORION_PEP_SECRET}"''| jq .access_token  )
# remove starting and tailing double quatas "
# echo $token
token=$(sed -e 's/^"//' -e 's/"$//' <<<"$token")
echo -n "$token" > token.txt