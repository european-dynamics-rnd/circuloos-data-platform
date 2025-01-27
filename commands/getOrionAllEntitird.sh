#!/bin/bash
#
#  curl commands to reload the data from the previous tutorial
#

set -e
export $(cat ../.env | grep "#" -v)

curl -s -G -X GET  'http://'"${HOST}"':'"${ORION_LD_PORT}"'/ngsi-ld/v1/entities' \
-H 'NGSILD-Tenant: circuloos_shopfloor_demo' \
-H 'Accept: application/ld+json' \
-d 'idPattern=urn:ngsi-ld:.*&limit=1000' | jq -r '.[].id'
