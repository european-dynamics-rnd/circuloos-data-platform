#!/usr/bin/python
# -*- coding:utf-8 -*-
import os
import sys
import logging
import decode_serial_data

from ngsild_agent import NGSILDAgent

from dataclasses import dataclass, asdict
from typing import Optional

from ngsildclient import Entity


@dataclass
class ExtendedType1SerialData(decode_serial_data.type1_serial_data):
    id: str 
    type: str  
    observedAt: Optional[str] =None

def post_data_to_orion(type1_data):
    
    type1_data_extended = ExtendedType1SerialData(
        **asdict(type1_data),  # Unpack original data
        id="urn:ngsi-ld:type1_serial_data:circuloos:serial:id1",
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
    

logging.basicConfig(level=logging.DEBUG)
_logger = logging.getLogger(__name__)

agent = NGSILDAgent(_logger)

serial_data_incoming =  "asdasd#1;342.60;43;51;37;66;44;23;154;59;7#daf33q"

# print(decode_serial_data.parse_input_type1(serial_data_incoming))
post_data_to_orion(decode_serial_data.parse_input_type1(serial_data_incoming))
            


     
     
     
     