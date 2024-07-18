#!/bin/bash
set -e
export $(cat ../.env | grep "#" -v)

curl -X GET 'http://localhost:'"${ORION_LD_A_PORT}"'/ngsi-ld/v1/entities/urn:ngsi-ld:ed:ieq-001' \
    -H 'NGSILD-Tenant: test_federation' \
    -H 'NGSILD-Path: /' \
    -H 'Link: <http://ld-context/ed-context.jsonld>' |jq