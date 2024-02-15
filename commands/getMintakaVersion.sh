#!/bin/bash
#

#

set -e
export $(cat ../.env | grep "#" -v)



curl -s -X GET  'http://'"${HOST}"':'"${MINTAKA_PORT}"'/info' |jq 

