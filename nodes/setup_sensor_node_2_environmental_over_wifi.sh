#!/bin/bash
cd demo_data_mqtt
# import building
./demo1-import-data-building
# Import PM sensor service
./provisioning_service.sh json_configurations/service_ENERGY_METER.json
# provition PM senspr
./provisioning_device.sh json_configurations/device_energymeter-001.json
# add testing data
for i in {1..10}
do
  ./generate_measurements_energy_meter.sh
done
