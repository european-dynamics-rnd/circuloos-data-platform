set -e
export $(cat ../.env | grep "#" -v)


# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Need 2 arguments: getDataOrion.sh  NGSILD-Tenant"
    exit 1
else
    NGSILDTenant="$1"
fi


curl -s -G -X GET  'http://'"${HOST}"':'"${ORION_LD_PORT}"'/ngsi-ld/v1/entities' \
-H 'NGSILD-Tenant: '"${NGSILDTenant}"'' \
-H 'NGSILD-Path: /' \
-H 'Link: <'"${CONTEXT}"'>; rel="http://www.w3.org/ns/json-ld#context"; type="application/ld+json"' \
-H 'Accept: application/ld+json' \
-d 'idPattern=urn:ngsi-ld:.*'|jq  

