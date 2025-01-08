import logging
from ngsildclient import Entity
import requests
from datetime import datetime
import os
import urllib3


class NGSILDAgent:
    def __init__(self, logger=None):
        self.logger = logger or self._setup_logger()
        self.config = self._get_config()

    @staticmethod
    def _setup_logger():
        logger = logging.getLogger("NGSILDAgent")
        logging.basicConfig(level=logging.DEBUG)
        return logger
    
    @staticmethod
    def _get_config():
        return {
            'NGSI_LD_CONTECT_BROKER': {
                'HOSTNAME': os.getenv('NGSI_LD_CONTECT_BROKER_HOSTNAME', 'localhost'),
                'PORT': int(os.getenv('NGSI_LD_CONTECT_BROKER_PORT', 443)),
            },
            'ORION_LD_TENANT': os.getenv('ORION_LD_TENANT', ''),
            'CONTEXT_JSON': os.getenv('CONTEXT_JSON', ''),
            'PARTNER_USERNAME': os.getenv('PARTNER_USERNAME', ''),
            'PARTNER_PASSWORD': os.getenv('PARTNER_PASSWORD', ''),
            'ORION_PEP_SECRET': os.getenv('ORION_PEP_SECRET', ''),
        }
       
       
        
    def post_ngsi_to_cb_with_token(self, entity_ngsild):
        if not isinstance(entity_ngsild, Entity):
            raise TypeError("The entity must be an instance of ngsildclient.model.entity.Entity")

        headers = {
            'Content-Type': 'application/ld+json',
            'Accept': 'application/json',
            'NGSILD-Tenant': self.config['ORION_LD_TENANT'],
        }

        if self.config['NGSI_LD_CONTECT_BROKER']['PORT'] == 443:
            token = self._get_orion_token()
            headers['Authorization'] = f'Bearer {token}'
            endpoint = (
                f"https://{self.config['NGSI_LD_CONTECT_BROKER']['HOSTNAME']}/kong/keycloak-orion/ngsi-ld/v1/entityOperations/upsert"
            )
        else:
            endpoint = (
                f"http://{self.config['NGSI_LD_CONTECT_BROKER']['HOSTNAME']}:{self.config['NGSI_LD_CONTECT_BROKER']['PORT']}/ngsi-ld/v1/entityOperations/upsert"
            )

        payload = f"[{entity_ngsild.to_json()}]"
        self.logger.debug(f"Payload: {payload}")
        response = requests.post(endpoint, headers=headers, data=payload)
        response.raise_for_status()

        if response.status_code // 100 != 2:
            raise ValueError(f"Failed to upload entity: {response.text}")

        self.logger.info(
            f"Entity ID: {entity_ngsild['id']} uploaded successfully with response: {response.status_code}"
        )
        return response.text

    def get_cb_info_with_token(self):
        headers = {}

        if self.config['NGSI_LD_CONTECT_BROKER']['PORT'] == 443:
            token = self._get_orion_token()
            headers['Authorization'] = f'Bearer {token}'
            endpoint = (
                f"https://{self.config['NGSI_LD_CONTECT_BROKER']['HOSTNAME']}/kong/keycloak-orion/version"
            )
        else:
            endpoint = (
                f"http://{self.config['NGSI_LD_CONTECT_BROKER']['HOSTNAME']}:{self.config['NGSI_LD_CONTECT_BROKER']['PORT']}/version"
            )

        response = requests.get(endpoint, headers=headers)
        response.raise_for_status()

        if response.status_code // 100 != 2:
            raise ValueError(f"Failed to fetch CB info: {response.text}")

        return response.json()
    

    def _get_orion_token(self):
        urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
        realm_name = 'fiware-server'
        client_id = 'orion-pep'
        url = (
            f"https://{self.config['NGSI_LD_CONTECT_BROKER']['HOSTNAME']}/idm/realms/{realm_name}/protocol/openid-connect/token"
        )
        data = {
            'username': self.config['PARTNER_USERNAME'],
            'password': self.config['PARTNER_PASSWORD'],
            'grant_type': 'password',
            'client_id': client_id,
            'client_secret': self.config['ORION_PEP_SECRET'],
        }

        response = requests.post(url, data=data, verify=True, timeout=25)
        response.raise_for_status()
        return response.json().get('access_token')
    



    # finding keys with the same name but with different naming convention 
    def _find_key_observedat(self,d):
        for key in d:
            if key in ["observedat", "observedAt"]:
                return key
        return None  # Return None if the key is not found



    def generate_ngsild_entity(self, entity):
        """
        Generate an NGSI-LD entity using the provided entity data and context.

        Args:
            entity (dict): A dictionary representing the entity data.
            context (str): The context URL for the NGSI-LD entity.

        Returns:
            Entity: An NGSI-LD entity object.
        """
        # Check if required keys ('type' and 'id') exist in the entity
        if 'type' not in entity:
            raise ValueError("The 'type' field is missing in the entity.")
        if 'id' not in entity:
            raise ValueError("The 'id' field is missing in the entity.")
        
        # Create the base NGSI-LD entity
        entity_ngsild = Entity(
            entity.pop('type', None),
            entity.pop('id', None),
            ctx=[self.config['CONTEXT_JSON']],
        )

        # Get keys from the entity and handle `observedAt` attributes
        keys = list(entity.keys())
        observedat_keyword = self._find_key_observedat(entity)
        if observedat_keyword:
            iso_date_str = entity.pop(observedat_keyword, None)
            keys.remove(observedat_keyword)
            try:
                date_obj = datetime.fromisoformat(iso_date_str)
            except (TypeError, ValueError):
                date_obj = datetime.utcnow()  # Fallback to current UTC timestamp
        else:
            date_obj = datetime.utcnow()

        # Process remaining keys in the entity
        for key in keys:
            if "_unitCode" not in key:  # Skip processing unitCode separately
                value = entity.pop(key)
                if f"{key}_unitCode" in keys:
                    # Handle unitCode if present
                    unit_code = entity.pop(f"{key}_unitCode", None)
                    entity_ngsild.prop(key, value, observedat=date_obj, unitcode=unit_code)
                else:
                    # Default case: Add property without unitCode
                    entity_ngsild.prop(key, value, observedat=date_obj)

        # Ensure all keys have been processed
        if entity:
            raise ValueError(f"Unprocessed attributes remaining: {entity}")

        return entity_ngsild
