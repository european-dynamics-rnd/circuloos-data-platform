## Demo with IoT Agent - MQTT
**IMPORTANT** Enable the corresponding variable in the service.sh file (change the configuration to activate the Docker with IoT MQTT Agent (comment L17 and uncomment L19)) and install the [mosquitto_pub](https://mosquitto.org/download/).

```console
./provisioning_service.sh sensor_node_2_environmental_over_wifi/json_configurations/service_BME680_autoprovition.json
./provisioning_device.sh sensor_node_2_environmental_over_wifi/json_configurations/device_node-002.json 
```