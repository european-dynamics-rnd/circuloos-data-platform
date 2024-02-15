#!/bin/bash
#
#  curl commands to reload the data from the previous tutorial
#

set -e
export $(cat ../.env | grep "#" -v)

curl -L -X POST 'http://localhost:'"${ORION_LD_PORT}"'/ngsi-ld/v1/subscriptions/' \
-H 'Content-Type: application/ld+json' \
-H 'NGSILD-Tenant: circuloos_demo' \
--data-raw '{
  "description": "Notify me of all changes of ieq_sensor",
  "type": "Subscription",
  "entities": [{"type": "leather"}],
  "notification": {
    "attributes": [],
    "format": "normalized",
    "endpoint": {
      "uri": "'"${SUBSCRIBE_URL}"'"
    }
  },
   "@context": "'"${CONTEXT}"'"
  }'

  
