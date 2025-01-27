#!/bin/bash
#

export $(cat ../.env | grep "#" -v)
set -e
echo -e 'Provition service:' "${1}"

curl -s -X POST \
  'http://localhost:'"${IOTA_MQTT_NORTH_PORT}"'/iot/services' \
  -H 'Content-Type: application/json' \
  -H 'fiware-service: circuloos_shopfloor_demo' \
  -H 'fiware-servicepath: /' \
  -d @$1

  echo -e 