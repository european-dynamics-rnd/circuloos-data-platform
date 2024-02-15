#!/bin/bash
#
#  curl commands to reload the data from the previous tutorial
#

set -e
export $(cat ../.env | grep "#" -v)

curl -s 'http://'"${HOST}"':'"${QUANTUMLEAP_PORT}"'/version' |jq 

