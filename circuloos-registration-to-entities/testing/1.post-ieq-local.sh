#!/bin/bash
set -e
export $(cat ../.env | grep "#" -v)
# ORION_LD_A_PORT=8888
curl -iL -X POST  'http://localhost:'"${ORION_LD_A_PORT}"'/ngsi-ld/v1/entityOperations/upsert' \
  -H 'Content-Type: application/ld+json' \
  -H 'Accept: application/json' \
  -H 'NGSILD-Tenant: test_federation' \
  -H 'NGSILD-Path: /' \
  -d '
[
  {
    "id": "urn:ngsi-ld:ed:ieq-001",
    "type": "ieq",
    "@context": [
      "http://circuloos-ld-context/circuloos-context.jsonld"
    ],
    "temperature": {
      "type": "Property",
      "value": 242,
      "unitCode": "CEL",
      "observedAt": "2023-09-16T18:06:49Z"
    },
    "relativeHumidity": {
      "type": "Property",
      "value": 16,
      "unitCode": "P1",
      "observedAt": "2023-09-16T18:06:49Z"
    },
    "pm25": {
      "type": "Property",
      "value": 31.1,
      "unitCode": "GQ",
      "observedAt": "2024-01-11T10:00:07.446Z"
    }
  }
]
'