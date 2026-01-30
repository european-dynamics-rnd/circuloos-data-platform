from ngsildclient import Entity
import csv
import glob
import json
import os
from datetime import datetime
import urllib3
import requests
import sys


def post_ngsi_to_cb_with_token(entity_ngsild_json,logger):
    # entity_ngsild_json a list of ngsildclient Entities
    config= get_config()
    
    headers = {
        'Content-Type': 'application/ld+json',
        'Accept': 'application/json',
        'NGSILD-Tenant': config['ORION_LD_TENANT'],       
    }
    if config['NGSI_LD_CONTECT_BROKER']['PORT']==443:
        # the CB is behind a PEP proxy (wilma or KONG), need to get a token 
        token= get_orion_token(config)
        headers['Authorization']= 'Bearer ' + token + ' '
        endpoint=f"https://{config['NGSI_LD_CONTECT_BROKER']['HOSTNAME']}/kong/keycloak-orion/ngsi-ld/v1/entityOperations/upsert" 
    else:
        endpoint=f"http://{config['NGSI_LD_CONTECT_BROKER']['HOSTNAME']}:{config['NGSI_LD_CONTECT_BROKER']['PORT']}/ngsi-ld/v1/entityOperations/upsert"
    # cilculoss_orion_ld_client=Client(hostname=NGSI_LD_CONTECT_BROKER_HOSTNAME ,port=NGSI_LD_CONTECT_BROKER_PORT, tenant=ORION_LD_TENANT)
    return_response=[]
    for ngsi_ld_json in entity_ngsild_json:
        # response=cilculoss_orion_ld_client.upsert(ngsi_ld_json)
        ngsi_ld_json_payload='['+ngsi_ld_json.to_json()+']'
        # app.logger.info(endpoint)
        # app.logger.info(headers)
        logger.debug(str(ngsi_ld_json_payload))
        response = requests.post(endpoint,headers=headers,data=ngsi_ld_json_payload)
        response.raise_for_status()  # Will raise an HTTPError if the HTTP request returned an unsuccessful status code
        if not response.status_code // 100 == 2:
            error_l=f"{datetime.now()} Error: post on endpoint {response.text}  status_code {response.status_code}"
            raise ValueError(error_l)
        else:
            return_response.append(f" Id: {ngsi_ld_json['id']} uploaded to Orion-LD: {config['NGSI_LD_CONTECT_BROKER']['HOSTNAME']} correctly with response: {response.status_code} {response.text}")
    return return_response

def get_cb_info_with_token(logger):
    # entity_ngsild_json a list of ngsildclient Entities
    config= get_config()
    
    headers = {}
    if config['NGSI_LD_CONTECT_BROKER']['PORT']==443:
        # the CB is behind a PEP proxy (wilma or KONG), need to get a token 
        token= get_orion_token(config)
        headers['Authorization']= 'Bearer ' + token + ' '
        headers['NGSILD-Tenant']= config['ORION_LD_TENANT']       

        endpoint=f"https://{config['NGSI_LD_CONTECT_BROKER']['HOSTNAME']}/kong/keycloak-orion/version" 
    else:
        endpoint=f"http://{config['NGSI_LD_CONTECT_BROKER']['HOSTNAME']}:{config['NGSI_LD_CONTECT_BROKER']['PORT']}/version"
    # cilculoss_orion_ld_client=Client(hostname=NGSI_LD_CONTECT_BROKER_HOSTNAME ,port=NGSI_LD_CONTECT_BROKER_PORT, tenant=ORION_LD_TENANT)
        # response=cilculoss_orion_ld_client.upsert(ngsi_ld_json)
    # app.logger.info(endpoint)
    # app.logger.info(headers)
    response = requests.get(endpoint,headers=headers)

    response.raise_for_status()  # Will raise an HTTPError if the HTTP request returned an unsuccessful status code
    if not response.status_code // 100 == 2:
        error=f"{datetime.now()} Error: get on endpoint {response.text} status_code {response.status_code}"
        raise ValueError(error)
    else:
        return(f"Successful\n{datetime.now()}\nResponse from {config['NGSI_LD_CONTECT_BROKER']['HOSTNAME']} \n {response.json()}")



def get_orion_token(config):
    urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
    # Determine security mode based on the HOST
    REALM_NAME='fiware-server'
    CLIENT_ID='orion-pep'
    secure=True
    # Construct the request URL and data
    url = f"https://{config['NGSI_LD_CONTECT_BROKER']['HOSTNAME']}/idm/realms/{REALM_NAME}/protocol/openid-connect/token"
    data = {
        'username': config['PARTNER_USERNAME'],
        'password': config['PARTNER_PASSWORD'],
        'grant_type': 'password',
        'client_id': CLIENT_ID,
        'client_secret': config['ORION_PEP_SECRET']
    }

    # Make the POST request to the Keycloak token endpoint
    response = requests.post(url, data=data, verify=secure,  timeout=25)
    response.raise_for_status()  # Will raise an HTTPError if the HTTP request returned an unsuccessful status code
    if response.status_code != 200:
        error=f"{datetime.now()} Error : try to access: {url} response: {response.text}"
        raise ValueError(error)
    # Extract the access token from the response
    # print(response.json())
    token = response.json().get('access_token')
    return token

def get_config():
    # ORION_LD_TENANT="circuloos_demo"
    # CONTEXT_JSON="http://circuloos-ld-context/circuloos-context.jsonld"
    config={}
    NGSI_LD_CONTECT_BROKER_HOSTNAME=os.getenv('NGSI_LD_CONTECT_BROKER_HOSTNAME','localhost')
    NGSI_LD_CONTECT_BROKER_PORT=int(os.getenv('NGSI_LD_CONTECT_BROKER_PORT',-1))
    server={}
    server['HOSTNAME']=NGSI_LD_CONTECT_BROKER_HOSTNAME
    config['NGSI_LD_CONTECT_BROKER']=server
            
    if NGSI_LD_CONTECT_BROKER_PORT>0:
        config['NGSI_LD_CONTECT_BROKER']['PORT']=NGSI_LD_CONTECT_BROKER_PORT
    else:
        # CB runs on another place and it is under PEP Proxy (Wilma or Kong)
        config['NGSI_LD_CONTECT_BROKER']['PORT']=443
        
    config['ORION_LD_TENANT']=os.getenv('ORION_LD_TENANT',"")
    config['CONTEXT_JSON']=os.getenv('CONTEXT_JSON',"")
    config['CSV_AGENT_PORT']=os.environ.get('CSV_AGENT_PORT', 5000)
    config['PARTNER_USERNAME']=os.getenv('PARTNER_USERNAME',"")
    config['PARTNER_PASSWORD']=os.getenv('PARTNER_PASSWORD',"")
    config['ORION_PEP_SECRET']=os.getenv('ORION_PEP_SECRET',"")
    return config

def find_key_observedat(d):
    for key in d:
        if key in ["observedat", "observedAt"]:
            return key
    return None  # Return None if the key is not found


def return_lastest_csv(UPLOAD_FOLDER,logging):
    # Specify your folder path here
    # Get a list of all JSON files in the folder
    csv_files = glob.glob(os.path.join(UPLOAD_FOLDER, '*.csv'))

    # Sort files by modification time in descending order
    csv_files.sort(key=lambda x: os.path.getmtime(x), reverse=True)
    if csv_files:
        latest_csv_file = csv_files[0]
        logging.debug(f"Latest csv file: {latest_csv_file}")
        return latest_csv_file
    else:
        raise ValueError("No uploaded csv files found.")
    return None

def load_csv_files_to_dict(csv_file,logging):
    # Create an empty list to store the dictionaries
    data = []
    with open(csv_file, mode='r', encoding='utf-8-sig') as file:
        # Read the first row to get the headers
        reader = csv.reader(file)
        headers = next(reader, None)
        logging.debug(f"header for file:{csv_file} is {headers}")
        # Check if the first two headers are 'id' and 'type'
        if headers[:2] == ['id', 'type']:
            # Reset the file pointer to the start of the file
            file.seek(0)
            csv_dict_reader = csv.DictReader(file, delimiter=',', quotechar='"')
            for row in csv_dict_reader:
                data.append(row)
        else:
            raise ValueError(f"The first two headers are not 'id' and 'type'. Header is:{headers}")
    return data

def generate_ngsild_entity(entity, context):
    # entity['type']
    entity_ngsild = Entity(
        entity.pop('type',None),
        entity.pop('id',None),
        ctx=[
            context,
        ],
    )
    keys = list(entity.keys())
    observedat_keyword=find_key_observedat(entity)
    if observedat_keyword in keys:
        iso_date_str=entity.pop(observedat_keyword,None)
        keys.remove(observedat_keyword)
        #check if timeStamp is ISO8601
        try:
            date_obj = datetime.fromisoformat(iso_date_str)
        except ValueError:
            date_obj=datetime.utcnow()
    else:
        date_obj=datetime.utcnow()
    for key in keys:
        # TODO add Relationship, Polygon
        if  "_unitCode" not in key:
            value = entity.pop(key)
            # create the entity with unitCode, pop both colmus from csv
            if key+"_unitCode" in keys:
                unitCode= entity.pop(key+"_unitCode",None)
                entity_ngsild.prop(key,value, observedat=date_obj, unitcode=unitCode)
            else:
                match key:
                    case key if "_Relationship" in key:
                        entity_ngsild.rel(key.replace("_Relationship", ""),value, observedat=date_obj)
                    case key if "_Polygon" in key:
                        geojson_polygon = {
                            "type": "Polygon",
                            "coordinates": str(value.replace('"',''))
                        }
                        entity_ngsild.prop(key.replace("_Polygon", ""),geojson_polygon, observedat=date_obj)
                    case _:
                        entity_ngsild.prop(key,value, observedat=date_obj)
    # entity['a']='a'   # to test the error
    if len(entity) != 0:
        raise ValueError(f"You have {len(entity)} attributes {entity} remaining")
    return entity_ngsild

def load_lastest_json_file(UPLOAD_FOLDER):
    # Specify your folder path here
    # Get a list of all JSON files in the folder
    json_files = glob.glob(os.path.join(UPLOAD_FOLDER, '*.json'))

    # Sort files by modification time in descending order
    json_files.sort(key=lambda x: os.path.getmtime(x), reverse=True)

    # Check if there are any JSON files in the folder
    if json_files:
        latest_json_file = json_files[0]
        print(f"Latest JSON file: {latest_json_file}")

        # Load the latest JSON file into a variable
        with open(latest_json_file, 'r') as file:
            json_data = json.load(file)
        print("JSON data loaded successfully.")
    else:
        print("No JSON files found in the folder.")
        json_data = None
    return json_data
