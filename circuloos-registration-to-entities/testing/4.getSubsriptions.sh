#!/bin/bash
set -e
export $(cat ../.env | grep "#" -v)

curl -L -X GET 'http://localhost:'"${ORION_LD_A_PORT}"'/ngsi-ld/v1/subscriptions/' \
  -H 'NGSILD-Tenant: test_federation' \
  -H 'Content-Type: application/ld+json' | jq

