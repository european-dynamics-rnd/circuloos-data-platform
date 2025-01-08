#!/usr/bin/python
# -*- coding:utf-8 -*-
import serial
import os
import sys
import logging
import argparse
import sys

import decode_serial_data

from ngsild_agent import NGSILDAgent
from ngsildclient import Entity

from dataclasses import dataclass, asdict
from typing import Optional

libdir = os.path.join(os.path.dirname(os.path.realpath(__file__)), 'lib')
if os.path.exists(libdir):
    sys.path.append(libdir)
   
import RPi.GPIO as GPIO
import time
from waveshare_RS485_RS232_HAT import config

@dataclass
class ExtendedType1SerialData(decode_serial_data.type1_serial_data):
    id: str 
    type: str  
    observedAt: Optional[str] =None
    

def post_data_to_orion(type1_data):
    
    type1_data_extended = ExtendedType1SerialData(
        **asdict(type1_data),  # Unpack original data
        id=_ngsild_id,
        type="type1_serial_data"
        )
    ngsi_ld=agent.generate_ngsild_entity(asdict(type1_data_extended))
    if ngsi_ld is None:
        _logger.error("no data")
    else:
        try:
            responses=agent.post_ngsi_to_cb_with_token(ngsi_ld)
        except Exception as e:
            _logger.error(f"An error occurred: {e}")
            
# Setting the ID 
if len(sys.argv) != 2:
    print("Warning no NGSI-LD id have been specify, using default")
    _ngsild_id='urn:ngsi-ld:type1_serial_data:circuloos:serial:id1'
else:
    _ngsild_id = sys.argv[1]

logging.basicConfig(level=logging.INFO)
_logger = logging.getLogger(__name__)

agent = NGSILDAgent(_logger)

sensor_ngsilf_id= os.getenv('RS', "urn:ngsi-ld:circuloos:serial:id1") 

RS485EN = 22
ser = config.config(Baudrate = 9600 , dev = "/dev/ttySC0")
serial_data_incoming = ''
MAX_NUMBER_OF_CHAR=100

try:
    while(1):
        data_t = ser.Uart_ReceiveByte()
        serial_data_incoming += str(data_t)
        if len(serial_data_incoming)>MAX_NUMBER_OF_CHAR:
            _logger.error(f"Someting is wrong, too many data without new line, reseting them : {serial_data_incoming}")
            serial_data_incoming=''
            
        if(data_t == '\n'):
            GPIO.output(RS485EN, GPIO.LOW)   
            _logger.debug(serial_data_incoming)
            post_data_to_orion(decode_serial_data.parse_input_type1(serial_data_incoming))
            serial_data_incoming = ''
            GPIO.output(RS485EN, GPIO.HIGH)
            
except KeyboardInterrupt:    
    logging.info("ctrl + c:")
    exit()
     