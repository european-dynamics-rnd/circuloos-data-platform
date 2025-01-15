#!/usr/bin/python
# -*- coding:utf-8 -*-
import os
import sys
import logging
import can  #pip install python-can[serial]
import time

from ngsild_agent import NGSILDAgent

from dataclasses import dataclass, asdict
from typing import Optional

from ngsildclient import Entity


@dataclass
class type1_can_data:
    id: str 
    type: str  
    mcp9600_temperature: float
    pt100_temperature: float


def post_data_to_orion(_data):

    ngsi_ld=agent.generate_ngsild_entity(asdict(_data))
    if ngsi_ld is None:
        _logger.error("no data")
    else:
        try:
            responses=agent.post_ngsi_to_cb_with_token(ngsi_ld)
        except Exception as e:
            _logger.error(f"An error occurred: {e}")
    
simulating=False   

if simulating:
    print('\n\n Simulating CAN Agent')
else:
	print('Bring up CAN0....')
	os.system("sudo /sbin/ip link set can0 up type can bitrate 500000")

time.sleep(0.1)	

try:
	if simulating:
		bus=can.interface.Bus( interface='socketcan', channel='vcan0', bitrate=500000 )
	else:
		bus = can.interface.Bus(channel='can0', bustype='socketcan')
except OSError:
	print('Cannot find hardware board found.')
	exit()
	
print('Ready')

logging.basicConfig(level=logging.DEBUG)
_logger = logging.getLogger(__name__)

agent = NGSILDAgent(_logger)

try:
	while True:
		message = bus.recv()	# Wait until a message is received.

		if message.arbitration_id == 1745:   # from sim  3793,  arduiono: 1745
			print(f"Message from sensor !!!. message:{message}")
			mcp9600_temp = (message.data[0] << 8) | message.data[1]
			mcp9600_temp = mcp9600_temp/100
			# Combine high and low bytes for pt100_temp
			pt100_temp =  (message.data[2] << 8) | message.data[3] 
			pt100_temp = pt100_temp/10

			_logger.debug(f"mcp9600_temp: {mcp9600_temp}, pt100_temp: {pt100_temp}")
			_type1_can_data = type1_can_data("urn:ngsi-ld:circuloos:can:id1","type1_can_data",mcp9600_temp,pt100_temp)
			post_data_to_orion(_type1_can_data)
	
	
except KeyboardInterrupt:
	#Catch keyboard interrupt
	os.system("sudo /sbin/ip link set can0 down")
	print('\n\rKeyboard interrtupt')	




