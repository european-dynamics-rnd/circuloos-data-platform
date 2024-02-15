#!/bin/bash


set -e
export $(cat ../.env | grep "#" -v)

# token=$(curl --insecure --location --request POST 'http://localhost:8080/realms/fiware-server/protocol/openid-connect/token' \

if [ "$HOST" == "localhost" ]; then
  INSECURE=' --insecure '
else
  INSECURE=''
fi

token=$(curl -s $INSECURE --location --request POST 'https://'"${HOST}"':'"${KEYCLOAK_TLS_PORT}"'/realms/fiware-server/protocol/openid-connect/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'username=admin-user' \
--data-urlencode 'password=admin-user' \
--data-urlencode 'grant_type=password' \
--data-urlencode 'client_id=mintaka-pep' \
--data-urlencode 'client_secret=zQXGjcxPWuF7YBpAiFtaIOEIOrCiWqeH' | jq .access_token )
# remove starting and tailing double quatas "
# echo $token
token=$(sed -e 's/^"//' -e 's/"$//' <<<"$token")
echo -n "$token" > tokenMintaka.txt