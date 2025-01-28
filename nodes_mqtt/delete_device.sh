#!/bin/bash
#

export $(cat ../.env | grep "#" -v)

# Function to prompt for user input
prompt_user_input() {
    read -p "Please enter 'YES' to delete ALL mqtt sensors: " user_input
    echo "$user_input"
}

# Main script
while true; do
    input=$(prompt_user_input)
    if [ "$input" = "YES" ]; then
        sensors=$(curl -s -X GET 'http://localhost:'"${IOTA_MQTT_NORTH_PORT}"'/iot/devices' \
            -H 'NGSILD-Tenant: circuloos_shopfloor_demo' -H 'Fiware-Service: circuloos_shopfloor_demo' -H 'Fiware-ServicePath: /' | jq . | grep '"device_id":' | sed 's/"entidevice_idty_name": //g' | sed 's/"//g' | sed 's/,//g')

        echo "$sensors"
        sensors=($sensors) # from string to array
        echo "$sensors"

        for i in "${sensors[@]}"; do
            echo "Deleting: $i"
            curl -s -X DELETE --url 'http://localhost:'"${IOTA_MQTT_NORTH_PORT}"'/iot/devices/'"${i}"'' -H 'NGSILD-Tenant: circuloos_shopfloor_demo' -H 'Fiware-Service: circuloos_shopfloor_demo' -H 'Fiware-ServicePath: /'
        done
        sensors=$(curl -s -X GET 'http://localhost:'"${IOTA_MQTT_NORTH_PORT}"'/iot/devices' \
            -H 'NGSILD-Tenant: circuloos_shopfloor_demo' -H 'Fiware-Service: circuloos_shopfloor_demo' -H 'Fiware-ServicePath: /' | jq . | grep '"device_id":' | sed 's/"device_id": //g' | sed 's/"//g' | sed 's/,//g')
        echo "$sensors"
        break
    else
        echo "Invalid input. Please try again."
    fi
done