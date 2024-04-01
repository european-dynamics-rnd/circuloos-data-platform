from ngsildclient import Entity
import csv
import glob
import json
import os
from datetime import datetime
import urllib3
import requests
import sys


def post_ngsi_to_cb_with_token(entity_ngsild_json):
    config= get_config()
    error=""
    info=""
    responses=[]
    headers = {
        'Content-Type': 'application/ld+json',
        'Accept': 'application/json',
        'NGSILD-Tenant': config['ORION_LD_TENANT'],       
    }
    if config['NGSI_LD_CONTECT_BROKER']['PORT']==443:
        # the CB is behind a PEP proxy (wilma or KONG), need to get a token 
        try:
            token= get_orion_token(config)
        except Exception as e:
            error=str(e) 
            responses=str(e)    
            return responses,info,error
        headers['Authorization']= 'Bearer ' + token + ' '
        endpoint=f"https://{config['NGSI_LD_CONTECT_BROKER']['HOSTNAME']}/kong/keycloak-orion/ngsi-ld/v1/entityOperations/upsert" 
    else:
        endpoint=f"http://{config['NGSI_LD_CONTECT_BROKER']['HOSTNAME']}:{config['NGSI_LD_CONTECT_BROKER']['PORT']}/ngsi-ld/v1/entityOperations/upsert"
    # cilculoss_orion_ld_client=Client(hostname=NGSI_LD_CONTECT_BROKER_HOSTNAME ,port=NGSI_LD_CONTECT_BROKER_PORT, tenant=ORION_LD_TENANT)
    for ngsi_ld_json in entity_ngsild_json:
        # response=cilculoss_orion_ld_client.upsert(ngsi_ld_json)
        ngsi_ld_json_payload='['+ngsi_ld_json.to_json()+']'
        # app.logger.info(endpoint)
        # app.logger.info(headers)
        info=info+str(ngsi_ld_json_payload)
        response = requests.post(endpoint,headers=headers,data=ngsi_ld_json_payload)
        response.raise_for_status()  # Will raise an HTTPError if the HTTP request returned an unsuccessful status code
        if not response.status_code // 100 == 2:
            error_l=str(datetime.now())+", Error: post on " + endpoint + response.text + "status_code" + str(response.status_code)
            error=error+error_l
            responses.append(error_l) 
        else:
            info=f" Id: {ngsi_ld_json['id']} uploaded to Orion-LD: {config['NGSI_LD_CONTECT_BROKER']['HOSTNAME']} with response: {response}"
            info=info+str(str(datetime.now())+info)
            responses.append(info)
    return responses,info,error

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
        error=str(datetime.now())+", Error : try to access:"+url+" response: "+response.text
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


def return_lastest_csv(UPLOAD_FOLDER):
    # Specify your folder path here
    # Get a list of all JSON files in the folder
    csv_files = glob.glob(os.path.join(UPLOAD_FOLDER, '*.csv'))

    # Sort files by modification time in descending order
    csv_files.sort(key=lambda x: os.path.getmtime(x), reverse=True)
    if csv_files:
        latest_csv_file = csv_files[0]
        print(f"Latest csv file: {latest_csv_file}")
        return latest_csv_file
    else:
        print("No csv files found in the folder.")
        csv_data = None
        return None
    return None

def load_csv_files_to_dict(csv_file):
    # Create an empty list to store the dictionaries
    data = []
    with open(csv_file, mode='r', encoding='utf-8') as file:
        # Read the first row to get the headers
        reader = csv.reader(file)
        headers = next(reader, None)
        # Check if the first two headers are 'id' and 'type'
        if headers[:2] == ['id', 'type']:
            # Reset the file pointer to the start of the file
            file.seek(0)
            csv_dict_reader = csv.DictReader(file, delimiter=',', quotechar='"')
            for row in csv_dict_reader:
                data.append(row)
        else:
            print("The first two headers are not 'id' and 'type'")
            return [] # empty_dict
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
        if  "_unitCode" not in key:
            value = entity.pop(key)
            if key+"_unitCode" in keys:
                unitCode= entity.pop(key+"_unitCode",None)
                entity_ngsild.prop(key,value, observedat=date_obj, unitcode=unitCode)
            else:
                entity_ngsild.prop(key,value, observedat=date_obj)
    # entity['a']='a'   # to test the error
    if len(entity) != 0:
        print(f"error should be empty:{len(entity)}")
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
