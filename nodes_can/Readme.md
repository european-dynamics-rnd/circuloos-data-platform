# Enable virtual CAN bus on linux

```
sudo modprobe vcan
sudo ip link add dev vcan0 type vcan
sudo ip link set up vcan0
```

# Scripts
- simulation_can_node.py: simulating the message from an actual ESP32 over CAN for easy debuging and testing
- testing_CAN_Rx.py: testing the hardware of RasberyPI for recieving the CNA messages. Use the flag simulating for testing


# Sample json
```json
{
  "@context": "http://circuloos-ld-context/circuloos-context.jsonld",
  "id": "urn:ngsi-ld:type1_can_data:circuloos:can:id1",
  "type": "type1_can_data",
  "mcp9600_temperature": {
    "type": "Property",
    "value": 122.32,
    "observedAt": "2025-01-09T14:47:31.000Z"
  },
  "pt100_temperature": {
    "type": "Property",
    "value": 58.02,
    "observedAt": "2025-01-09T14:47:31.000Z"
  }
}
```