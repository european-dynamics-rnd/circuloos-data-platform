#!/bin/bash
#
set -e
export $(cat ../.env | grep "#" -v)


curl -iL -X POST  'http://'"${HOST}"':'"${ORION_LD_PORT}"'/ngsi-ld/v1/entityOperations/upsert' \
-H 'NGSILD-Tenant: circuloos_demo' \
-H 'NGSILD-Path: /' \
-H 'Content-Type: application/ld+json' \
-d @$1
echo -e