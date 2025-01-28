#!/bin/bash
#

export $(cat ../.env | grep "#" -v)
set -e

curl -s 'http://localhost:'"${IOTA_MQTT_NORTH_PORT}"'/iot/services' \
  -H 'Content-Type: application/json' \
  -H 'NGSILD-Tenant: circuloos_shopfloor_demo' \
  -H 'fiware-service: circuloos_shopfloor_demo' \
  -H 'fiware-servicepath: /' |jq 