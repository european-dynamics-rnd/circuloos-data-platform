#!/bin/bash
set -e
export $(cat ../.env | grep "#" -v)


curl -L -X POST 'http://localhost:'"${ORION_LD_A_PORT}"'/ngsi-ld/v1/subscriptions/' \
  -H 'Content-Type: application/ld+json' \
  -H 'NGSILD-Tenant: test_federation' \
  -H 'NGSILD-Path: /' \
  --data-raw '{
  "description": "Notify me of all changes in ieq",
  "type": "Subscription",
  "entities": [{"type": "ieq"}],
  "notification": {
    "format": "normalized",
    "endpoint": {
    "uri": "http://registrationtoentities:8888/proxy",
      "accept": "application/json"
    }
  },
   "@context": "'"${CONTEXT}"'"
}' 