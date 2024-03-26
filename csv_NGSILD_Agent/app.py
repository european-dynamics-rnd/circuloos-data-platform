from flask import Flask, render_template, request, redirect, url_for
import os
from werkzeug.utils import secure_filename
import os
import csv_ngsild_agent_utils as utlis
import pprint
import json
import requests
from requests import Request, Session
from datetime import datetime
import sys
import logging

app = Flask(__name__)
UPLOAD_FOLDER = 'uploaded_files'
# ALLOWED_EXTENSIONS = {'json','csv'}
ALLOWED_EXTENSIONS = {'csv'}
entity_ngsild_json_global= None



def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS
           
def generate_ngsi_ld_entities():
    # Your logic to generate NGSI-LD entities  
    config=utlis.get_config()
    lastest_csv= utlis.return_lastest_csv(UPLOAD_FOLDER)
    data=utlis.load_csv_files_to_dict(lastest_csv)
    entity_ngsild_json_str=""
    entity_ngsild_json=[]
    for entity_dict in data:
        entity_ngsild=utlis.generate_ngsild_entity(entity_dict,config['CONTEXT_JSON'])
        # entity_ngsild.to_json()
        entity_ngsild_json_str=entity_ngsild_json_str+'\n,'+ entity_ngsild.to_json( indent=4) #str(len(entity_ngsild_json))+": \n"+ 
        entity_ngsild_json.append(entity_ngsild)
    return entity_ngsild_json_str, entity_ngsild_json

@app.route('/')
def upload_form():
    return render_template('upload.html')

@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return {'status': 'error', 'message': 'No file part'}
    file = request.files['file']
    if file.filename == '':
        return {'status': 'error', 'message': 'No selected file'}
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        file.save(os.path.join(UPLOAD_FOLDER, filename))
        return {'status': 'success', 'message': 'File uploaded successfully'}
    else:
        return {'status': 'error', 'message': 'Invalid file type'}

# For button Generate NGSI-LD entities    
@app.route('/generate-ngsi-ld', methods=['POST'])
def handle_generate_ngsi_ld():
    global entity_ngsild_json_global
    entity_ngsild_json_str, entity_ngsild_json_global  = generate_ngsi_ld_entities()
    return render_template('upload.html', message=entity_ngsild_json_str)

# For button Post NGSI-LD entities to Orion-LD
@app.route('/post-ngsi-ld', methods=['POST'])
def handle_post_ngsi_ld():
    config=utlis.get_config()
    headers = {
        'Content-Type': 'application/ld+json',
        'Accept': 'application/json',
        'NGSILD-Tenant': config['ORION_LD_TENANT'],
        
    }
    if config['NGSI_LD_CONTECT_BROKER']['PORT']==443:
        # the CB is behind a PEP proxy (wilma or KONG), need to get a token 
        try:
            token= utlis.get_orion_token(config)
        except ValueError as e:
            app.logger.error(e)
            return e
        headers['Authorization']= 'Bearer ' + token + ' '
        endpoint=f"https://{config['NGSI_LD_CONTECT_BROKER']['HOSTNAME']}/kong/keycloak-orion/ngsi-ld/v1/entityOperations/upsert" 
    else:
        endpoint=f"http://{config['NGSI_LD_CONTECT_BROKER']['HOSTNAME']}:{config['NGSI_LD_CONTECT_BROKER']['PORT']}/ngsi-ld/v1/entityOperations/upsert"
    # cilculoss_orion_ld_client=Client(hostname=NGSI_LD_CONTECT_BROKER_HOSTNAME ,port=NGSI_LD_CONTECT_BROKER_PORT, tenant=ORION_LD_TENANT)
    responses=[]
    for ngsi_ld_json in entity_ngsild_json_global:
        # response=cilculoss_orion_ld_client.upsert(ngsi_ld_json)
        ngsi_ld_json_payload='['+ngsi_ld_json.to_json()+']'
        # app.logger.info(endpoint)
        # app.logger.info(headers)
        app.logger.info(ngsi_ld_json_payload)
        response = requests.post(endpoint,headers=headers,data=ngsi_ld_json_payload)
        response.raise_for_status()  # Will raise an HTTPError if the HTTP request returned an unsuccessful status code
        if not response.status_code // 100 == 2:
            error=str(datetime.now())+", Error: post on " + endpoint + response.text + "status_code" + str(response.status_code)
            app.logger.error(error)
            responses.append(error) 
        else:
            info=f" Id: {ngsi_ld_json['id']} uploaded to Orion-LD: {config['NGSI_LD_CONTECT_BROKER']['HOSTNAME']} with response: {response}"
            app.logger.info(str(datetime.now())+info)
            responses.append(info)
    return responses


if __name__ == '__main__':
    config=utlis.get_config()
    port = config['CSV_AGENT_PORT']
    app.run(debug=True, host='0.0.0.0', port=port)
